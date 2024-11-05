import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_1/admin/comptes.dart';
import 'package:flutter_1/prof/acceuil.dart';
import 'package:flutter_1/prof/complainte.dart';
import 'package:flutter_1/prof/infos_basiques_prof.dart';
import 'package:flutter_1/prof/infos_contact_prof.dart';
import 'package:flutter_1/prof/notifications.dart';
import 'package:flutter_1/prof/profil.dart';
import 'package:flutter_1/prof/reservations.dart';
import 'package:flutter_1/secu/complaintes.dart';
import 'package:flutter_1/secu/infos_basiques.dart';
import 'package:flutter_1/secu/infos_contact.dart';
import 'package:flutter_1/secu/notifications.dart';
import 'package:flutter_1/secu/profil.dart';
import 'package:flutter_1/secu/reservations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_1/globals.dart' as globals;
import 'package:flutter_1/admin/complaintes.dart';
import 'package:flutter_1/admin/cours.dart';
import 'package:flutter_1/admin/dashboard.dart';
import 'package:flutter_1/admin/infos_basiques_admin.dart';
import 'package:flutter_1/admin/infos_contact_admin.dart';
import 'package:flutter_1/admin/profilAdmin.dart';
import 'package:flutter_1/admin/reservations.dart';
import 'package:flutter_1/admin/salles.dart';
void main() {
  runApp(const MyApp());
}

bool _obscureText = true;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'notifications': (context) => const notificationsProf(),
        'complaintes': (context) => const complaintesProf(),
        'reservations': (context) =>  const reservationsProf(),
        'profil': (context) => const profilProf(),
        'infosbasiques':(context)=>const infosBasiquesProf(),
        'infoscontact':(context)=>const infosContactProf(),
        'profilA': (context) => const profilAdmin(),
        'sallesA': (context) => const sallesAdmin(),
        'comptes': (context) => const comptesAdmin(),
        'dashboard': (context) => const dashboardAdmin(),
        'reservationsA': (context) => const reservationsAdmin(),
        'complaintesA': (context) => const complaintesAdmin(),
        'cours': (context) => const coursAdmin(),
        'infosbasiquesA':(context)=>const infosBasiquesAdmin(),
        'infoscontactA':(context)=>const infosContactAdmin(),
        'profilS': (context) => const profil(),
        'reservationsS': (context) => const reservations(),
        'complaintesS': (context) => const complaintes(),
        'notificationsS': (context) => const notifications(),
        'infosbasiquesS':(context)=>const infosBasiques(),
        'infoscontactS':(context)=>const infosContact(),
        'login':(context)=>const ConnexionPage(),
      },
      title: 'Flutter Connexion Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConnexionPage(),
    );
  }
}

class ConnexionPage extends StatefulWidget {
  @override
  const ConnexionPage({Key? key}) : super(key: key);

  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> login() async {
    var url = 'http://127.0.0.1/api_flutter_1/login.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        "username": username.text,
        "password": password.text,
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        print('CA MARCHE');
        String userType = data['userType'];
        if (data['status'] == 'success') {
          if (userType == 'Agent') {
            globals.globalDataS = username.text;
            Fluttertoast.showToast(
              msg: "Login successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.black,
              fontSize: 16.0,
            );
            // Navigate to 'complaintes' page
            Navigator.pushNamed(context, 'notificationsS');
          } else if (userType == 'Admin') {
            globals.globalDataA = username.text;
            Fluttertoast.showToast(
              msg: "Login successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.black,
              fontSize: 16.0,
            );
            // Set global data
            // Navigate to 'dashboard' page
            Navigator.pushNamed(context, 'comptes');
          } else if (userType == 'Prof') {
            globals.globalDataP = username.text;
            Fluttertoast.showToast(
              msg: "Login successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.black,
              fontSize: 16.0,
            );
            // Navigate to 'acceuilProf' page
            Navigator.pushNamed(context, 'notifications');
          }} else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Erreur',
                      style: TextStyle(color: Colors.black),),
                    content: Text(
                        'Ces informations ne correspondent à aucun compte'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  );
                }
            );
          }
        }

    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img.jpg'),
          fit: BoxFit.cover, // Adjust this based on your needs
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logoUIR.png',
                    height: 150,
                    width: 150,
                  ),
                ),
                const Text(
                  'A U T H E N T I F I C A T I O N',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Bienvenue à myUIRSalles!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Entrez les informations qui vous ont été fournies:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    labelText: "Nom d'utilisateur",
                    labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Set the border color
                      borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe', labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Set the border color
                      borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(

                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer un mot de passe';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      login();
                    },
                    child: const Text(
                      'Se connecter',
                      style: TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(

                      side: MaterialStateProperty.all(BorderSide(color: Colors.white)), // Set the border color
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                      )),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.transparent,
          child: Text(
            '©Université internationale de RABAT-2024',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
