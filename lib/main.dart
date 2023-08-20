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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<AppState>(
              builder: (context, value, child) {
                return ListView.builder(
                    itemCount: value.messages.length,
                    itemBuilder: ((context, index) {
                      return ChatMessage(
                        input: value.messages[index].input,
                        output: value.messages[index].output ?? "",
                        timestamp: value.messages[index].timestamp,
                      );
                    }));
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<AppState>(context, listen: false).signIn(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
