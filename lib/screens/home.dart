import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/screens/check.dart';
import 'package:pomodoro/screens/pomodoro.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  late String nome = '';
  late String email = '';

  getUser() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      nome = user.displayName!;
      email = user.email!;
    }
  }

  logOut() async {
    await _firebaseAuth.signOut().then(
          (user) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ChecarPage(),
            ),
          ),
        );
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(nome),
            accountEmail: Text(email),
          ),
          ListTile(
            dense: true,
            title: const Text('Sair'),
            trailing: const Icon(Icons.exit_to_app_rounded),
            onTap: (() {
              logOut();
            }),
          )
        ],
      )),
      appBar: AppBar(backgroundColor: Colors.red),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PomodoroScreen(),
                              ));
                        },
                        child: Container(
                          width: width * 0.9,
                          height: height * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    '00:00',
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
