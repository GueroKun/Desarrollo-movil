import 'package:flutter/material.dart';
import 'package:flutter_application_2/Student.dart';
import 'package:flutter_application_2/Worker.dart';

void main() {
  runApp(const MyApp());
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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String name = 'Christian';
  int age = 20;
  bool programming = true;

  List<String> Lista = ['Christian', 'Alice', 'Rose', 'Ashley'];
  List<Worker> workersList = [];


  Student student = Student(name: "Christian", enrollment: "20223TN087");

  TextEditingController _txtNameCtrl = TextEditingController();
  TextEditingController _txtLastNameCtrl = TextEditingController();
  TextEditingController _txtAgeCtrl = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _addStudent() {
    final name = _txtNameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please set all data")));
      return;
    }
    setState(() {
      Lista.add(name);
    });
    _txtNameCtrl.clear();
  }

  // Workers
   void _addWorker() {
    final nombre = _txtNameCtrl.text.trim();
    final apellidos = _txtLastNameCtrl.text.trim();
    final edad = _txtAgeCtrl.text.trim();
    if (nombre.isEmpty || apellidos.isEmpty || edad.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Todos los campos son obligatorios")),
      );
      return;
    }
    final edadInt = int.tryParse(edad);
    if (edadInt == null || edadInt < 18) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("El trabajador debe ser mayor de edad")),
      );
      return;
    }
    final id = workersList.length + 1;
    setState(() {
      workersList.add(Worker(id, nombre, apellidos, edadInt));
    });
    _txtNameCtrl.clear();
    _txtLastNameCtrl.clear();
    _txtAgeCtrl.clear();
  }

  void _removeLastWorker() {
    setState(() {
      if (workersList.isNotEmpty) {
        workersList.removeLast();
      }
    });
  }

  Widget getWorkers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 14),
        Text("Lista de trabajadores: "),
        SizedBox(height: 10),
       ...workersList.map((worker) => Text(
            "- ${worker.id}: ${worker.nombre} ${worker.apellidos}, Age: ${worker.edad}"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getWorkers(),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                controller: _txtNameCtrl,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                controller: _txtLastNameCtrl,
                decoration: const InputDecoration(
                  labelText: "Apellidos",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                controller: _txtAgeCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Edad",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addWorker,
                  child: const Text("Registrar"),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _removeLastWorker,
                  child: const Text("Eliminar último trabajador"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
