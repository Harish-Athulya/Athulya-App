class Room {
  String id;
  final String branch;
  final String date;
  final String count;
  final String occupied;

  Room(
    {
      this.id = '',
      required this.branch,
      required this.date,
      required this.count,
      required this.occupied
    }
  );

  Map<String, dynamic> toJson() => {
        'id': id,
        'branch': branch,
        'date': date,
        'count': count,
        'occupied': occupied,
      };

  static Room fromJson(Map<String, dynamic> json) => Room(
      branch: json['branch'],
      date: json['date'],
      count: json['count'],
      occupied: json['occupied'],
      id: json['id']
  );

  static String docId(String branch, String date) {
    final String documentId;
    late final String abbrBranch;

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

    documentId = '${abbrBranch}-${date}';
    print(documentId);
    return documentId;
  }



  
}