class Food {
  String? id;
  final String? branch;
  final String date;
  final String time;
  final String foodType;
  final String menu;
  final String imageName;

  Food(
      {this.id = '',
      required this.branch,
      required this.date,
      required this.time,
      required this.foodType,
      required this.menu,
      required this.imageName});

  Map<String, dynamic> toJson() => {
        'id': id,
        'branch': branch,
        'date': date,
        'time': time,
        'foodType': foodType,
        'menu': menu,
        'imageName': imageName
      };

  static Food fromJson(Map<String, dynamic> json) => Food(
      branch: json['branch'],
      date: json['date'],
      time: json['time'],
      foodType: json['foodType'],
      menu: json['menu'],
      imageName: json['imagePath'],
      id: json['id']);

  static String docId(String branch, String date, String food) {
    final String documentId;
    late final String abbrBranch;
    late final String image;

    switch (branch) {
      case 'Arumbakkam':
        abbrBranch = 'ARM';
        break;
      case 'Neelankarai':
        abbrBranch = 'NLK';
        break;
      case 'Pallavaram':
        abbrBranch = 'PVM';
        break;
      case 'Perungudi':
        abbrBranch = 'PRG';
        break;
    }

    switch (food) {
      case 'Breakfast':
        image = 'Img1';
        break;
      case 'Lunch':
        image = 'Img2';
        break;
      case 'Snack':
        image = 'Img3';
        break;
      case 'Dinner':
        image = 'Img4';
        break;
    }
    documentId = '${abbrBranch}-${date}-${image}';
    print(documentId);
    return documentId;
  }
}
