import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/chat_message.dart';
import 'package:myapp/state/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'F3 Chat App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0),
            child: ElevatedButton(
              onPressed: () =>
                  Provider.of<AppState>(context, listen: false).flipAuthState(),
              child: Consumer<AppState>(builder: (context, value, child) {
                return Text(value.isLoggedIn ? "Logout" : "Login");
              }),
            ),
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Consumer<AppState>(
        builder: (context, value, child) {
          if (!value.isLoggedIn) {
            return const Center(
              child: Text("Sign In To Get Started"),
            );
          }
          return Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              child: value.messages.isEmpty
                  ? const Center(
                      child: Text("Start chatting"),
                    )
                  : ListView.builder(
                      reverse: true,
                      itemCount: value.messages.length,
                      itemBuilder: ((context, index) {
                        return ChatMessage(
                          input: value.messages[index].input,
                          output: value.messages[index].output ?? "",
                          timestamp: value.messages[index].timestamp,
                        );
                      })),
            ),
            MessageBar(
                messageBarHitText: "Whats on your mind?",
                onSend: (input) {
                  value.addMessage(input);
                }),
          ]);
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () =>
      //       Provider.of<AppState>(context, listen: false).flipAuthState(),
      //   tooltip: 'Increment',
      //   child: Consumer<AppState>(builder: (context, value, child) {
      //     return Text(value.isLoggedIn ? "Logout" : "Login");
      //   }),
      // ),
    );
  }
}
