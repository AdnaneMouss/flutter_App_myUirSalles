import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/admin/acceuil.dart';
import 'package:flutter_1/admin/complaintes.dart';
import 'package:flutter_1/admin/comptes.dart';
import 'package:flutter_1/admin/dashboard.dart';

import 'package:flutter_1/admin/infos_basiques_admin.dart';
import 'package:flutter_1/admin/infos_contact_admin.dart';
import 'package:flutter_1/admin/profilAdmin.dart';
import 'package:flutter_1/admin/reservations.dart';
import 'package:flutter_1/admin/salles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_1/globals.dart' as globals;

void main() {
  runApp(const MyApp());
}
String a = globals.globalDataA;
Color drawerHeaderColor = const Color(0xFFC62B20);
Color addButtonColor = const Color(0xFFC62B20);
Color salleNumeroColor = Colors.white;
int requeteInsertionCours = 0;
int requeteModificationcours = 0;
int numToDelete = 0;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
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
      home: const coursAdmin(),
    );
  }
}

class coursAdmin extends StatefulWidget {
  const coursAdmin({Key? key}) : super(key: key);

  @override
  _cours createState() => _cours();
}

class _cours extends State<coursAdmin> {
  List<dynamic> list = [];
  String? selectedFiliere;
  List<String> filieres = [
    'Aéronautique',
    'Automobile',
    'Numérique et Informatique',
    'Energies renouvelables',
    'Architecture',
    'Médecine dentaire',
    'Management',
    'Finance',
  ];
  String? selectedProf;
  String? selectedAnnee;
  late List<String> annee = ["1ère année","2ème année","3ème année","4ème année","5ème année","6ème année"];
  late List<String> profData = [];
  TextEditingController filiereController = TextEditingController();
  TextEditingController profController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  //List<String> profNames = await fetchProfNames();

  @override
  void initState() {
    super.initState();
    fetchAndSetComplaintes();
    fetchAndSetProfsData();
  }

  /*void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un cours'),
          content: Column(
            children: [
              TextFormField(
                controller: nomController,
                decoration: InputDecoration(labelText: 'Nom du cours'),
              ),
              TextFormField(
                controller: filiereController,
                decoration: InputDecoration(labelText: 'Filière'),
              ),
              TextFormField(
                controller: profController,
                decoration: InputDecoration(labelText: 'Prof'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialogue
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: (filiereController.text.isNotEmpty &&
                  profController.text.isNotEmpty &&
                  nomController.text.isNotEmpty)
                  ? () {
                // Ajouter la salle
                addCours(
                  nomController.text,
                  filiereController.text,
                  profController.text,
                );
                Navigator.of(context).pop(); // Fermer le dialogue
              }
                  : null, // Disable the button if the conditions are not met
              child: Text('Valider'),
            ),
          ],
        );
      },
    );
  }*/

  Future<List<dynamic>> fetchComplaintes() async {
    final String url =
        'http://127.0.0.1/api_flutter_1/retrieve/getCours.php'; // Replace with your PHP script URL

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data as List<
            dynamic>; // Return the parsed JSON data as a list of dynamic objects
      } else {
        // Handle HTTP error status codes
        print('HTTP Error: ${response.statusCode}');
        return []; // Return an empty list if there's an error
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      return []; // Return an empty list in case of exceptions
    }
  }

  Future<void> fetchAndSetComplaintes() async {
    var fetchedComplaintes =
    await fetchComplaintes(); // Call the function to fetch notifications
    setState(() {
      list = fetchedComplaintes; // Set the fetched notifications to the list
    });
  }

  Future<void> deleteCours() async {
    final String url = 'http://127.0.0.1/api_flutter_1/insert/deleteCours.php';

    try {
      var response = await http.post(Uri.parse(url), body: {
        'id': numToDelete.toString(),
      });

      if (response.statusCode == 200) {
        // Handle success
        print('Cours deleted successfully');
        // Update the UI by fetching the updated list of salles
        fetchAndSetComplaintes();
      } else {
        // Handle other HTTP status codes
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }

  Future<void> addCours(String nom, String filiere, String prof, String annee) async {
    final String url = 'http://127.0.0.1/api_flutter_1/insert/addCours.php';

    try {
      var response = await http.post(Uri.parse(url), body: {
        'filiere': filiere,
        'prof': selectedProf.toString(),
        'nom': nom,
        'annee':selectedAnnee.toString(),
      });

      if (response.statusCode == 200) {
        print('cours added successfully');
        fetchAndSetComplaintes();
      } else {
        print('HTTP Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateCours(String filiere, String prof, String nom,String annee,
     String filiereActuel, String profActuel,  String nomActuel, String anneeActuelle) async {
    final String url = 'http://127.0.0.1/api_flutter_1/insert/updateCours.php';

    try {
      var response = await http.post(Uri.parse(url), body: {
        'filiere': filiere,
        'prof': prof,
        'nom': nom,
        'annee': annee,
        'nomActuel': nomActuel.toString(),
        'profActuel': profActuel.toString(),
        'filiereActuel': filiereActuel.toString(),
        'anneeActuelle':anneeActuelle.toString(),
      });

      if (response.statusCode == 200) {
        // Handle success
        print('Salle updated successfully');
        // Update the UI by fetching the updated list of salles
        fetchAndSetComplaintes();
      } else {
        // Handle other HTTP status codes
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }

  Future<List<String>> fetchProfData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://127.0.0.1/api_flutter_1/retrieve/retrieveprofessors.php'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<String> profList = data.map((item) => item.toString()).toList();
        return profList;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return []; // Return an empty list or handle the error accordingly
    }
  }

  Future<void> fetchAndSetProfsData() async {
    try {
      final data = await fetchProfData();
      setState(() {
        profData = data;
      });
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        const Size.fromHeight(39.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.white,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'C O U R S ',
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
                      Navigator.pushNamed(context, 'cours');
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: list.isEmpty
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.builder(
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color(0xFFC62B20),
                    child: ListTile(
                      leading:
                          Icon(Icons.book_outlined,color: Colors.white,),
                      contentPadding: EdgeInsets.all(8),
                      title: Text(
                        'Cours: ${list[i]['nom']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: salleNumeroColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filière: ${list[i]['filiere']}',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                              Colors.grey,
                            ),
                          ),
                          Text(
                            'Année: ${list[i]['annee']}',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                              Colors.grey,
                            ),
                          ),
                          Text(
                            'Prof: ${list[i]['prof']}',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                              Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () {
                             numToDelete= int.tryParse('${list[i]['id']}') ?? 0;
                            String nomCours= '${list[i]['nom']}';
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor:
                                    const Color(0xFFC62B20),
                                    title: Text(
                                      'Confirmation',
                                      style:
                                      TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                        'Voulez-vous vraiment supprimer le cours $nomCours ? '),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Annuler',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          deleteCours();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Supprimer',
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),

                        ],
                      ),
                      onTap: null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: const Color(0xFFC62B20),
                title: Text(
                  'Ajouter un cours',
                  style: TextStyle(color: Colors.white),
                ),
                content: Container(
                  height: 300.0, // Set a smaller height
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nomController,
                        decoration: InputDecoration(
                          labelText: 'Nom du cours',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: selectedFiliere, // Valeur sélectionnée
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFiliere =
                                newValue; // Mettre à jour la valeur sélectionnée
                          });
                        },
                        items: filieres.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Filière',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: Color.fromARGB(255, 201, 186, 185),
                      ),

                      DropdownButtonFormField<String>(
                        value: selectedAnnee, // Valeur sélectionnée
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAnnee =
                                newValue; // Mettre à jour la valeur sélectionnée
                          });
                        },
                        items: annee.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Année',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: Color.fromARGB(255, 201, 186, 185),
                      ),
                      SizedBox(height: 1,),
                      DropdownButtonFormField<String>(
                        value: selectedProf, // Valeur sélectionnée
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedProf =
                                newValue; // Mettre à jour la valeur sélectionnée
                          });
                        },
                        items: profData.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Enseignant',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: Color.fromARGB(255, 201, 186, 185),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fermer le dialogue
                    },
                    child: Text(
                      'Annuler',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      addCours(
                        nomController.text,
                        selectedFiliere.toString(),
                        selectedProf.toString(),
                        selectedAnnee.toString(),
                      );
                      Navigator.of(context).pop(); // Fermer le dialogue
                    },
                    child: Text('Valider'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add ,color: Colors.white,),
        backgroundColor: addButtonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
