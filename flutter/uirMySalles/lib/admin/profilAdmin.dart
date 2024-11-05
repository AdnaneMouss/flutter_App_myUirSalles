import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/admin/acceuil.dart';
import 'package:flutter_1/admin/complaintes.dart';
import 'package:flutter_1/admin/comptes.dart';
import 'package:flutter_1/admin/cours.dart';
import 'package:flutter_1/admin/dashboard.dart';
import 'package:flutter_1/admin/infos_basiques_admin.dart';
import 'package:flutter_1/admin/infos_contact_admin.dart';
import 'package:flutter_1/admin/reservations.dart';
import 'package:flutter_1/admin/salles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_1/globals.dart' as globals;

void main() {
  runApp( const MyApp());
}
Color drawerHeaderColor =  const Color(0xFFC62B20);
String a = globals.globalDataA;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData.light(),  // Default light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: ThemeMode.light,

      routes: {
        'profilA': (context) => const profilAdmin(),
        'dashboard':(context) => const dashboardAdmin(),
        'acceuil': (context) => const acceuilAdmin(),
        'sallesA': (context) => const sallesAdmin(),
        'reservationsA': (context) => const reservationsAdmin(),
        'complaintesA': (context) => const complaintesAdmin(),
        'cours': (context) => const coursAdmin(),
        'infosbasiquesA':(context)=>const infosBasiquesAdmin(),
        'infoscontactA':(context)=>const infosContactAdmin(),
        'login':(context)=>const ConnexionPage(),
        'comptes':(context)=>const comptesAdmin(),
      },
      home: const profilAdmin(),
    );
  }
}

String name="";
String username="aziz_bdr";
String password="";
String email="";
String phoneNumber="";
class profilAdmin extends StatefulWidget {
  const profilAdmin({Key? key}) : super(key: key);

  @override
  _profilAdmin createState() =>_profilAdmin();
}
class _profilAdmin extends State<profilAdmin>{
  String? password;

  @override
  void initState() {
    super.initState();
    fetchName();
    fetchPassword();
    fetchEmail();
    fetchNumber();
  }

  Future<void> fetchName() async {
    final String url = 'http://127.0.0.1/api_flutter_1/retrieve/retrievename.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'username': username,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data.containsKey('name')) {
          setState(() {
            name = data['name']; // Set the fetched name in the state
          });
        } else {
          setState(() {
            name = 'Name not found'; // Set a default message if 'name' is not available
          });
        }
      } else {
        setState(() {
          name = 'Failed to fetch data'; // Set an error message if HTTP request fails
        });
      }
    } catch (e) {
      setState(() {
        name = 'Error: $e'; // Set an error message if an exception occurs
      });
    }
  }
  Future<void> fetchPassword() async {
    final String url = 'http://127.0.0.1/api_flutter_1/retrieve/retrievepassword.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'username': username,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data.containsKey('password')) {
          setState(() {
            password = data['password']; // Set the fetched name in the state
          });
        } else {
          setState(() {
            password = 'Password not found'; // Set a default message if 'name' is not available
          });
        }
      } else {
        setState(() {
          password = 'Failed to fetch data'; // Set an error message if HTTP request fails
        });
      }
    } catch (e) {
      setState(() {
        password = 'Error: $e'; // Set an error message if an exception occurs
      });
    }
  }
  Future<void> fetchNumber() async {
    final String url = 'http://127.0.0.1/api_flutter_1/retrieve/retrievephone.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'username': username,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data.containsKey('phoneNumber')) {
          setState(() {
            phoneNumber = data['phoneNumber']; // Set the fetched name in the state
          });
        } else {
          setState(() {
            phoneNumber = 'phoneNumber not found'; // Set a default message if 'name' is not available
          });
        }
      } else {
        setState(() {
          phoneNumber = 'Failed to fetch data'; // Set an error message if HTTP request fails
        });
      }
    } catch (e) {
      setState(() {
        phoneNumber = 'Error: $e'; // Set an error message if an exception occurs
      });
    }
  }
  Future<void> fetchEmail() async {
    final String url = 'http://127.0.0.1/api_flutter_1/retrieve/retrieveemail.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'username': username,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data.containsKey('email')) {
          setState(() {
            email = data['email']; // Set the fetched name in the state
          });
        } else {
          setState(() {
            email = 'Password not found'; // Set a default message if 'name' is not available
          });
        }
      } else {
        setState(() {
          email = 'Failed to fetch data'; // Set an error message if HTTP request fails
        });
      }
    } catch (e) {
      setState(() {
        email = 'Error: $e'; // Set an error message if an exception occurs
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(39.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.white,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'P R O F I L',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          titleSpacing: 100,
        ),
      ),
      drawer: Drawer(
        child: Column(children: [
          DrawerHeader(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  title: Stack(
                    children: [
                      Image.asset(
                        "assets/piconline2.png",
                        width: 50, // Adjust the width as needed
                        height: 50, // Adjust the height as needed
                        fit: BoxFit.cover, // or another BoxFit option depending on your layout requirements
                      ),
                      Positioned(
                        bottom: 10,
                        left: 60,
                        right: 20,
                        child: Container(
                          color: Colors.white.withOpacity(0), // You can customize the background color and opacity
                          padding: EdgeInsets.symmetric(vertical: 1.0),
                          child: Text(
                            a,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,// You can customize the text color
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),),

                    ],),
                  trailing: Image.asset('assets/logoUIR.png'),
                ),
                const SizedBox(height: 10),
                ListTile(
                    leading: Image.asset('assets/admin/menu.png'),
                    title: Text(
                      'M        E         N        U',
                      style: TextStyle(
                          color: drawerHeaderColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'profilA');
                    }),
              ],
            ),),
          ListTile(
              leading: Image.asset('assets/admin/dashboard.png'),
              title: Text(
                "D A S H B O A R D ",
                style: TextStyle(color: drawerHeaderColor, fontSize: 11),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'dashboard');
              }),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  // Adjust the color to your preference
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Image.asset('assets/admin/class.png'),
            title: Text(
              "S A L L E S",
              style: TextStyle(color: drawerHeaderColor, fontSize: 11),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'sallesA');
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  // Adjust the color to your preference
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Image.asset('assets/admin/reservations.png'),
            title: Text(
              "R E S E R V A T I O N S",
              style: TextStyle(color: drawerHeaderColor, fontSize: 11),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'reservationsA');
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  // Adjust the color to your preference
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Image.asset('assets/admin/cours.png'),
            title: Text(
              "C O U R S",
              style: TextStyle(color: drawerHeaderColor, fontSize: 11),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'cours');
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  // Adjust the color to your preference
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Image.asset('assets/admin/profile.png'),
            title: Text("P R O F I L",
                style: TextStyle(color: drawerHeaderColor, fontSize: 11)),
            onTap: () {
              Navigator.pushNamed(context, 'profilA');
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  // Adjust the color to your preference
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Image.asset('assets/admin/comptes.png'),
            title: Text(
              "C O M P T E S",
              style: TextStyle(color: drawerHeaderColor, fontSize: 11),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'comptes');
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  // Adjust the color to your preference
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
              leading: Image.asset('assets/admin/complaintes.png'),
              title: Text(
                "C O M P L A I N T E S",
                style: TextStyle(color: drawerHeaderColor, fontSize: 11),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'complaintesA');
              }),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  // Adjust the color to your preference
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Image.asset('assets/admin/logout.png'),
            title: Text(
              "D E C O N N E X I O N",
              style: TextStyle(color: drawerHeaderColor, fontSize: 11),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context)
                  {
                    return AlertDialog(
                      title: Text('Message de confirmation',
                        style: TextStyle(color: drawerHeaderColor),),
                      content: Text(
                          'Voulez-vous vraiment vous déconnecter?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Non',
                            style: TextStyle(color: drawerHeaderColor),),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: Text(
                            'Oui',
                            style: TextStyle(color: drawerHeaderColor),),
                        ),
                      ],
                    );
                  });
            },
          ),
        ]
        ),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 0,left:10,right: 60, bottom: 0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/piconline2.png"), // Image 1 in the first row
                      const SizedBox(width: 12), // Spacer between the images// Image 2 in the first row
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 35,),
              ListTile(
                title:const Text("Informations basiques:",style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                trailing:Image.asset("assets/admin/edit.png", alignment: Alignment.bottomRight,),
                onTap:() {
                  Navigator.pushNamed(context,'infosbasiquesA');
                },
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/admin/name.png", alignment: Alignment.bottomRight,),
                title: Text('$name',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                subtitle: const Text("Nom complet", style: TextStyle(color: Colors.black87, fontSize: 11)),
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/admin/username.png", alignment: Alignment.bottomRight,),
                title:Text(username,style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                subtitle: const Text("Nom d'utilisateur", style: TextStyle(color: Colors.black87, fontSize: 11)),
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/admin/padlock.png", alignment: Alignment.bottomRight,),
                title:Text('$password',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                subtitle: const Text("Mot de passe", style: TextStyle(color: Colors.black87, fontSize: 11)),
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              const SizedBox(height: 20,),
              ListTile(
                title:const Text("Informations de contact:",style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                trailing:Image.asset("assets/admin/edit.png", alignment: Alignment.bottomRight,),
                onTap:() {
                  Navigator.pushNamed(context,'infoscontactA');
                },
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/admin/phone.png", alignment: Alignment.bottomRight,),
                title: Text('$phoneNumber',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                subtitle: const Text("Numéro de téléphone", style: TextStyle(color: Colors.black87, fontSize: 11)),
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/admin/mail.png", alignment: Alignment.bottomRight,),
                title: Text('$email',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                subtitle: const Text("Adresse e-mail", style: TextStyle(color: Colors.black87, fontSize: 11)),
              ),

            ],
          ),
        ),),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // Set your desired height here
        child: SizedBox(
          height: 50.0, // Adjust this to match preferredSize height
          child: BottomAppBar(
            color: Colors.transparent,
            child: Center(
              child: Text(
                '©Université internationale de RABAT-2024',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0, // Adjust font size if needed// Change text color if needed
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
