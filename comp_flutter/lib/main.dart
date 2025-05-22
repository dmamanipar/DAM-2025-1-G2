import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  bool _isChecked = false;
  bool _switchValue = false;
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OutlinedButton')),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(5),
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    print('OutlinedButton presionado');
                  },
                  child: Text('OutlinedButton'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 20),
                    side: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ), // Define el borde
                  ),
                ),

                IconButton(
                  icon: Icon(Icons.thumb_up),
                  color: Colors.blue,
                  iconSize: 40.0,
                  onPressed: () {
                    print('IconButton presionado');
                  },
                ),

                FloatingActionButton(
                  onPressed: () {
                    print('FAB presionado');
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green,
                ),
                SizedBox(height: 8,),
                ElevatedButton.icon(
                  onPressed: () {
                    print('Botón con ícono y texto presionado');
                  },
                  icon: Icon(Icons.send),
                  label: Text('Enviar'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),

                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                    hintText: 'Escribe tu nombre',
                  ),
                  onChanged: (text) {
                    print('Texto ingresado: $text');
                  },
                ),
                SizedBox(height: 8,),


                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {_email = value; },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese un correo';
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return 'Ingrese un correo válido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('Correo ingresado: $_email');
                          }
                        },
                        child: Text('Enviar'),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                    Text('Acepto los términos y condiciones'),
                  ],
                ),

                Switch(
                  value: _switchValue,
                  onChanged: (bool value) {
                    setState(() {
                      _switchValue = value;
                    });
                    print('Switch: $_switchValue');
                  },
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text('Opción 1'),
                      leading: Radio<int>(
                        value: 1,
                        groupValue: _selectedValue,
                        onChanged: (int? value) {
                          setState(() { _selectedValue = value!; });
                          print("Seleccionado: $_selectedValue");
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Opción 2'),
                      leading: Radio<int>(
                        value: 2,
                        groupValue: _selectedValue,
                        onChanged: (int? value) {
                          setState(() {_selectedValue = value!; });
                          print("Seleccionado: $_selectedValue");
                        },
                      ),
                    ),
                  ],
                ),





              ],
            ),
            )
          ]

        ),
      ),
    );
  }
}
