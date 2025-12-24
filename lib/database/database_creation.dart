import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('orders.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 8, // Incremented from 7 to 8 for completed_products table
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    var batch = db.batch();

    if (oldVersion < 2) {
      batch.execute(
          'ALTER TABLE orders ADD COLUMN isCompleted INTEGER DEFAULT 0');
    }
    if (oldVersion < 3) {
      try {
        batch.execute('ALTER TABLE orders DROP COLUMN orderId');
      } catch (e) {
        // Column might not exist, continue
      }
      batch.execute('ALTER TABLE orders ADD COLUMN orderId INTEGER');
      batch.execute(
          'CREATE UNIQUE INDEX IF NOT EXISTS idx_orderId ON orders (orderId)');
    }
    if (oldVersion < 4) {
      batch.execute('ALTER TABLE orders ADD COLUMN displayOrderId TEXT');
    }
    if (oldVersion < 5) {
      try {
        final tableInfo = await db.rawQuery("PRAGMA table_info(orders)");
        final hasAddress =
            tableInfo.any((column) => column['name'] == 'address');
        if (!hasAddress) {
          batch.execute('ALTER TABLE orders ADD COLUMN address TEXT');
        }
      } catch (e) {
        print('Error checking/adding address column: $e');
      }
    }
    if (oldVersion < 7) {
      // Add notes column
      try {
        final tableInfo = await db.rawQuery("PRAGMA table_info(orders)");
        final hasNotes = tableInfo.any((column) => column['name'] == 'notes');
        if (!hasNotes) {
          batch.execute('ALTER TABLE orders ADD COLUMN notes TEXT');
        }
      } catch (e) {
        print('Error adding notes column: $e');
      }
    }
    // CHANGE: Add completed_products table if upgrading to version 8
    if (oldVersion < 8) {
      try {
        batch.execute('''
          CREATE TABLE completed_products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            order_id TEXT NOT NULL,
            product_name TEXT NOT NULL,
            completed INTEGER DEFAULT 0,
            UNIQUE(order_id, product_name)
          )
        ''');
      } catch (e) {
        print('Error creating completed_products table: $e');
      }
    }

    try {
      await batch.commit();
    } catch (e) {
      print('Error during database upgrade: $e');
    }
  }

  Future _createDB(Database db, int version) async {
    const orderTable = '''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerName TEXT NOT NULL,
        phone TEXT NOT NULL,
        address TEXT,
        deliveryDate TEXT NOT NULL,
        products TEXT NOT NULL,
        isCompleted INTEGER DEFAULT 0,
        orderId INTEGER,
        displayOrderId TEXT UNIQUE,
        notes TEXT
      )
    ''';
    await db.execute(orderTable);

    // CHANGE: Added creation of completed_products table
    const completedProductsTable = '''
      CREATE TABLE completed_products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id TEXT NOT NULL,
        product_name TEXT NOT NULL,
        completed INTEGER DEFAULT 0,
        UNIQUE(order_id, product_name)
      )
    ''';
    await db.execute(completedProductsTable);

    await db.execute(
        'CREATE UNIQUE INDEX IF NOT EXISTS idx_orderId ON orders (orderId)');
  }

  Future<String> getNextDisplayOrderId() async {
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT MAX(CAST(SUBSTR(displayOrderId, 2) AS INTEGER)) as maxId FROM orders');
    int nextId = 1;
    if (result.first['maxId'] != null) {
      nextId = (result.first['maxId'] as int) + 1;
    }
    return '#${nextId.toString().padLeft(5, '0')}';
  }

  Future<int> insertOrder(Map<String, dynamic> order) async {
    final db = await instance.database;
    return await db.insert('orders', order);
  }

  Future<List<Map<String, dynamic>>> fetchOrdersByDate(String date,
      {bool excludeCompleted = false}) async {
    final db = await instance.database;
    String query = 'SELECT * FROM orders WHERE deliveryDate LIKE ?';
    if (excludeCompleted) {
      query += ' AND (isCompleted = 0 OR isCompleted IS NULL)';
    }
    query += ' ORDER BY displayOrderId DESC';
    return await db.rawQuery(query, ['$date%']);
  }

  Future<void> updateOrderCompletionStatus(
      String displayOrderId, bool isCompleted) async {
    final db = await instance.database;
    await db.update(
      'orders',
      {'isCompleted': isCompleted ? 1 : 0},
      where: 'displayOrderId = ?',
      whereArgs: [displayOrderId],
    );
  }

  // Single updateOrder method with error handling
  Future<int> updateOrder(
      Map<String, dynamic> order, String displayOrderId) async {
    try {
      final db = await instance.database;
      return await db.update(
        'orders',
        order,
        where: 'displayOrderId = ?',
        whereArgs: [displayOrderId],
      );
    } catch (e) {
      print('Error updating order: $e');
      rethrow;
    }
  }

  Future<void> deleteOrder(String displayOrderId) async {
    final db = await instance.database;
    await db.delete(
      'orders',
      where: 'displayOrderId = ?',
      whereArgs: [displayOrderId],
    );

    // CHANGE: Also delete related product completion records
    await db.delete(
      'completed_products',
      where: 'order_id = ?',
      whereArgs: [displayOrderId],
    );
  }

  // Method for database reset (if needed)
  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'orders.db');

    // Delete the database
    await deleteDatabase(path);

    // Reinitialize the database
    _database = null;
    await database;
  }

  // CHANGE: Added methods for tracking completed products

  // Set a product as completed or not completed
  Future<void> setProductCompletion(
      String orderId, String productName, bool completed) async {
    final db = await instance.database;

    // Use REPLACE to handle both insert and update scenarios
    await db.rawInsert(
        'INSERT OR REPLACE INTO completed_products(order_id, product_name, completed) VALUES(?, ?, ?)',
        [orderId, productName, completed ? 1 : 0]);
  }

  // Get a list of completed product names for an order
  Future<List<String>> getCompletedProducts(String orderId) async {
    final db = await instance.database;
    final results = await db.query('completed_products',
        where: 'order_id = ? AND completed = 1', whereArgs: [orderId]);

    return results.map((row) => row['product_name'] as String).toList();
  }
}
