// Catalog of the products that the company sells.

class Product {
  final String id;
  final String name;
  final String unit;
  double quantity;

  Product ({
    required this.id,
    required this.name,
    required this.unit,
    this.quantity = 0.0, // define the quantity of every product as 0 by default
  });

  Product copy(){
    return Product(
      name: name,
      unit: unit,
      id: id,
    );
  }
}

//list of products that the store sells
final List<Product> productsList = [
  Product(id: '1', name: 'Κοτόπουλο μικρό', unit: 'Τεμάχιο'),
  Product(id: '2', name: 'Κοτόπουλο μεσαίο', unit: 'Τεμάχιο'),
  Product(id: '3', name: 'Κοτόπουλο μεγάλο', unit: 'Τεμάχιο'),
  Product(id: '4', name: 'Στήθος κοτόπουλο', unit: 'Τεμάχιο'),
  Product(id: '5', name: 'Μπούτι κοτόπουλο', unit: 'Τεμάχιο'),
  Product(id: '6', name: 'Συκωτάκια', unit: 'Κιλό'),
  Product(id: '7', name: 'Φτερούγες', unit: 'Κιλό'),
  Product(id: '8', name: 'Σουβλάκι κοτόπουλο', unit: 'Τεμάχιο'),
  Product(id: '9', name: 'Σουβλάκι μαριναρισμένο', unit: 'Τεμάχιο'),
  Product(id: '10', name: 'Σνίτσελ', unit: 'Τεμάχιο'),
  Product(id: '11', name: 'Κοτομπουκιές', unit: 'Κιλό'),
  Product(id: '12', name: 'Γύρος κοτόπουλο', unit: 'Κιλό'),
  Product(id: '13', name: 'Φιλέτο Στήθος', unit: 'Τεμάχιο'),
  Product(id: '14', name: 'Φιλέτο Μπούτι', unit: 'Τεμάχιο'),
  Product(id: '15', name: 'Εντόσθια', unit: 'Κιλό'),
  Product(id: '16', name: 'Παριζάκι Κοτόπουλο', unit: 'Τεμάχιο'),
  Product(id: '17', name: 'Πλατάρια', unit: 'Κιλό'),
  Product(id: '18', name: 'Ρέντζες - Στομάχια', unit: 'Κιλό'),
  Product(id: '19', name: 'Λουκάνικο', unit: 'Τεμάχιο'),
  Product(id: '20', name: 'Μπιφτέκι', unit: 'Τεμάχιο'),
  Product(id: '21', name: 'Ρολό κοτόπουλο μικρό', unit: 'Τεμάχιο'),
  Product(id: '22', name: 'Ρολό κοτόπουλο μεγάλο', unit: 'Τεμάχιο'),
  Product(id: '23', name: 'Κιμάς στήθος', unit: 'Κιλό'),
  Product(id: '24', name: 'Κιμάς μπούτι', unit: 'Κιλό'),
  Product(id: '25', name: 'Κιμάς ανάμεικτος', unit: 'Κιλό'),
  Product(id: '26', name: 'Αυγά μεγάλο', unit: 'Τεμάχιο'),
  Product(id: '27', name: 'Αυγά μικρό', unit: 'Τεμάχιο'),
  Product(id: '28', name: 'Αυγά εξάδα', unit: 'Τεμάχιο'),
  Product(id: '29', name: 'Καφέ Αυγά', unit: 'Τεμάχιο'),
  Product(id: '30', name: 'Λευκά Αυγά', unit: 'Τεμάχιο'),
];