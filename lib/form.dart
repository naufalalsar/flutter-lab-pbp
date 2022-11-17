import 'package:demo/main.dart';
import 'package:flutter/material.dart';
import 'package:demo/page/to_do_page.dart';


class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _namaLengkap = "";
  bool jenjangSarjana = false;
  bool jenjangDiploma = false;
  bool jenjangMagister = false;
  bool jenjangDoktor = false;
  double umur = 0;
  String kelasPBP = 'A';
  List<String> listKelasPBP = ['A', 'B', 'C', 'D', 'E', 'F', 'KI'];
  bool _nilaiSwitch = false;

  String _jenjang() {
    if (jenjangDiploma == true) {
      return "Diploma";
    } else if (jenjangDoktor == true) {
      return "Doktor";
    } else if (jenjangMagister == true) {
      return "Magister";
    } else {
      return "Sarjana";
    }
  }

  String _latihan() {
    if (_nilaiSwitch == false) {
      return "Tidak";
    } else {
      return "Iya";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      // Menambahkan drawer menu
      drawer: Drawer(
        child: Column(
          children: [
            // Menambahkan clickable menu
            ListTile(
              title: const Text('Counter'),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Form'),
              onTap: () {
                // Route menu ke halaman form
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyFormPage()),
                );
              },
            ),
    
            ListTile(
              title: const Text('To Do'),
              onTap: () {
                // Route menu ke halaman to do
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ToDoPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Pak Dengklek",
                    labelText: "Nama Lengkap",
                    // Menambahkan icon agar lebih intuitif
                    icon: const Icon(Icons.people),
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      _namaLengkap = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      _namaLengkap = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama lengkap tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      leading: Icon(Icons.school),
                      title: Text("Jenjang"),
                    ),
                    CheckboxListTile(
                      title: const Text('Sarjana'),
                      value: jenjangSarjana,
                      onChanged: (bool? value) {
                        setState(() {
                          jenjangSarjana = value!;
                          if (value) {
                            jenjangMagister =
                                jenjangDiploma = jenjangDoktor = false;
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Diploma'),
                      value: jenjangDiploma,
                      onChanged: (bool? value) {
                        setState(() {
                          jenjangDiploma = value!;
                          if (value) {
                            jenjangMagister =
                                jenjangSarjana = jenjangDoktor = false;
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Magister'),
                      value: jenjangMagister,
                      onChanged: (bool? value) {
                        setState(() {
                          jenjangMagister = value!;
                          if (value) {
                            jenjangDiploma =
                                jenjangSarjana = jenjangDoktor = false;
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Doktor'),
                      value: jenjangDoktor,
                      onChanged: (bool? value) {
                        setState(() {
                          jenjangDoktor = value!;
                          if (value) {
                            jenjangMagister =
                                jenjangSarjana = jenjangDiploma = false;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.co_present),
                title: Row(
                  children: [
                    Text('Umur: ${umur.round()}'),
                  ],
                ),
                subtitle: Slider(
                  value: umur,
                  max: 100,
                  divisions: 100,
                  label: umur.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      umur = value;
                    });
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.class_),
                title: const Text(
                  'Kelas PBP',
                ),
                trailing: DropdownButton(
                  value: kelasPBP,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: listKelasPBP.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      kelasPBP = newValue!;
                    });
                  },
                ),
              ),
              SwitchListTile(
                title: const Text('Practice Mode'),
                value: _nilaiSwitch,
                onChanged: (bool value) {
                  setState(() {
                    _nilaiSwitch = value;
                  });
                },
                secondary: const Icon(Icons.run_circle_outlined),
              ),
              TextButton(
                child: const Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 15,
                          child: Container(
                            child: ListView(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              shrinkWrap: true,
                              children: <Widget>[
                                Center(child: const Text('Informasi Data')),
                                SizedBox(height: 20),
                                Column(
                                  children: [
                                    Text("Nama : $_namaLengkap "),
                                    Text("Jenjang : ${_jenjang()}"),
                                    Text("Umur : $umur"),
                                    Text("Kelas : $kelasPBP"),
                                    Text("Latihan : ${_latihan()}"),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Kembali'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
