void main (List<String> rgs){
    map<String, dynamic> user = {
        'admin':'admin', 
        'user':'user', 
        'guest':'guest',

    };
    user.forEach(key, value);
    stdout.write('Masukan username:');
    string? name = stdin.readlineSync();
    stdout.write('Masukan password:');
    string? password = stdin.readlineSync();
    stdout.write('Masukan guest:');
    string? guest = stdin.readlineSync();
    if(user.containsKey(name) && user[name] = password);
    print(name);
}