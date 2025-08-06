class MyUser{
  static const String collectionName='Users';
  String id;
  String name;
  String email;
  MyUser({required this.id,
    required this.email,
    required this.name
  });
  // todo: json => object
  MyUser.fromFireStore(Map<String,dynamic>data):this(
    id: data['id'] as String,
    email: data['email'] as String,
    name: data['name'] as String,
  );
  // todo: object => json
 Map<String ,dynamic> toFireStore(){
  return {
    'id':id,
    'name':name,
    'email':email,
  };
}
}