import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/destination',
      routes: {
        '/destination': (context) => DestinationScreen(),
        '/login': (context) => LoginScreen(),
      },
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade700)),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DestinationScreen extends StatelessWidget {
  const DestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final login = ModalRoute.of(context)?.settings.arguments;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Où partons-nous ?'),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).pushNamed(
                      '/login',
                    ),
                icon: login == null
                    ? const Icon(Icons.account_box)
                    : const Icon(Icons.logout),
                color: Colors.pink.shade700),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Campagne',
                icon: Icon(Icons.house_siding),
              ),
              Tab(
                text: 'Sur l\'eau',
                icon: Icon(Icons.houseboat_outlined),
              ),
              Tab(
                text: 'Avec vue',
                icon: Icon(Icons.panorama),
              ),
              Tab(
                text: 'Bord de mer',
                icon: Icon(Icons.scuba_diving),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DestinationDetails(),
            Text('B'),
            Text('C'),
            Text('D'),
          ],
        ),
      ),
    );
  }
}

class DestinationDetails extends StatelessWidget {
  const DestinationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [DestinationPhoto(), const DestinationInfos()],
    );
  }
}

class DestinationPhoto extends StatelessWidget {
  const DestinationPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/przntr.appspot.com/o/48bc7a49-b260-457a-b207-70a47f14e13c.png?alt=media&token=103ba2cf-5800-43d8-b9cf-21b4d0fae2a2',
            fit: BoxFit.cover,
            errorBuilder: (context, _, __) =>
                const Icon(Icons.warning, color: Colors.red),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
        ),
        Positioned(left: 8, top: 8, child: MembersFavorite())
      ],
    );
  }
}

class MembersFavorite extends StatelessWidget {
  const MembersFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white70,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite, color: Colors.pink),
          /*SizedBox(width: 12),*/
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('Coup de coeur Voyageurs'),
          )
        ],
      ),
    );
  }
}

class DestinationInfos extends StatelessWidget {
  const DestinationInfos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text('Paris, France'),
              Spacer(),
              Icon(Icons.star, color: Colors.orange),
              Text('4.78')
            ],
          ),
          Text('3-9 avril'),
          Text('120€ nuit'),
        ],
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController fieldLoginController = TextEditingController();
  TextEditingController fieldPasswordController = TextEditingController();
  late final String? login;
  late final String? password;

  @override
  void initState() {
    super.initState();
    login = '';
    password = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (login) {
                    if (login == null || login.isEmpty) {
                      return 'Aucune email renseigné';
                    }

                    if (password == "basile@gmail.com") {
                      return 'Informations incorrectes';
                    }

                    return null;
                  },
                  controller: fieldLoginController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: "Entrez votre email",
                      labelText: "Email"),
                ),
                TextFormField(
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return 'Aucune password renseigné';
                    }

                    if (password == "walid") {
                      return 'Informations incorrectes';
                    }

                    return null;
                  },
                  controller: fieldPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: "Entrez votre mots de passe",
                    labelText: "Password",
                  ),
                ),
                ElevatedButton(
                    child: const Text("Connexion"),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print('Login : ${fieldLoginController.text}');
                        print('Password :${fieldPasswordController.text}');
                        Navigator.of(context).pushNamed(
                          '/destination',
                          arguments: {'login': fieldLoginController.text},
                        );
                      }
                    })
              ],
            )));
  }
}
