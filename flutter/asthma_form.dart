import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../navigator/bottom_navigator.dart';

class AsthmaForm extends StatefulWidget {
  const AsthmaForm({super.key});

  @override
  _AsthmaFormState createState() => _AsthmaFormState();
}

class _AsthmaFormState extends State<AsthmaForm> {
  final formkey = GlobalKey<FormState>();
  int cough = 0;
  int phlegm = 0;
  int wheeze = 0;
  int Dysp = 0;
  int Exe = 0;
  int AR = 0;
  int par2 = 0;
  int RIr = 0;
  int REm = 0;
  int Ecz = 0;
  int Food = 0;
  int Cold = 0;
  int AP = 0;
  int Psmoke = 0;
  int Animal = 0;
  int Damp = 0;
  int asthma = 0;

  String getStatusLabel(int value) {
    switch (value) {
      case 0:
        return 'Healthy';
      case 1:
        return 'Moderate';
      case 2:
        return 'Severe';
      default:
        return '';
    }
  }

  Color getStatusColor(int value) {
    switch (value) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
        return const Color.fromARGB(255, 230, 97, 97);
      default:
        return Colors.transparent;
    }
  }

  String getStatusLabelss(int value) {
    switch (value) {
      case 0:
        return 'Healthy';
      case 1:
        return 'Mild';
      case 2:
        return 'Moderate';
      case 3:
        return 'Severe';
      default:
        return '';
    }
  }

  Color getStatusColorss(int value) {
    switch (value) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.yellow;
      case 3:
        return const Color.fromARGB(255, 230, 97, 97);
      default:
        return Colors.transparent;
    }
  }

  String getStatusLabels(int value) {
    switch (value) {
      case 0:
        return 'Healthy';
      case 1:
        return 'Mild';
      case 2:
        return 'Moderate';
      case 3:
        return 'Moderate';
      case 4:
        return 'Severe';
      case 5:
        return 'Severe';
      default:
        return '';
    }
  }

  Color getStatusColors(int value) {
    switch (value) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.yellow;
      case 4:
        return const Color.fromARGB(255, 230, 97, 97);
      case 5:
        return const Color.fromARGB(255, 230, 97, 97);

      default:
        return Colors.transparent;
    }
  }

  Future<void> _submitForm() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      try {
        var url = Uri.parse('https://asthma-flask-final.onrender.com');
        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'cough': cough.toString(),
            'phlegm': phlegm.toString(),
            'wheeze': wheeze.toString(),
            'Dysp': Dysp.toString(),
            'Exe': Exe.toString(),
            'AR': AR.toString(),
            'par2': par2.toString(),
            'RIr': RIr.toString(),
            'REm': REm.toString(),
            'Ecz': Ecz.toString(),
            'Food': Food.toString(),
            'Cold': Cold.toString(),
            'AP': AP.toString(),
            'Psmoke': Psmoke.toString(),
            'Animal': Animal.toString(),
            'Damp': Damp.toString(),
          }),
        );

        if (response.statusCode == 200) {
          String result = jsonDecode(response.body)['result'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(result: result),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.home),
      ), floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
                'assets/images/1.png'), // Replace with the actual path to your background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.7),
                BlendMode.dstATop), // Set the opacity value between 0.0 and 1.0
          ),
        ),
        child: Form(
          key: formkey,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      color: Colors.white.withOpacity(0.9),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: const Text(
                              'MEDICAL DATA SEVERITY',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 19, 90, 138),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: const [
                              SizedBox(width: 8),
                              Text('Cough'),
                            ],
                          ),
                          Slider(
                            value: cough.toDouble(),
                            min: 0,
                            max: 5,
                            divisions: 5,
                            label: getStatusLabels(cough),
                            activeColor: getStatusColors(cough),
                            onChanged: (double value) {
                              setState(() {
                                cough = value.toInt();
                              });
                            },
                          ),
                          Row(
                            children: const [
                              SizedBox(width: 8),
                              Text('Wheeze'),
                            ],
                          ),
                          Slider(
                            value: wheeze.toDouble(),
                            min: 0,
                            max: 3,
                            divisions: 3,
                            label: getStatusLabelss(wheeze),
                            activeColor: getStatusColorss(wheeze),
                            onChanged: (double value) {
                              setState(() {
                                wheeze = value.toInt();
                              });
                            },
                          ),
                          Row(
                            children: const [
                              SizedBox(width: 8),
                              Text('Shortness of Breath'),
                            ],
                          ),
                          Slider(
                            value: Dysp.toDouble(),
                            min: 0,
                            max: 3,
                            divisions: 3,
                            label: getStatusLabelss(Dysp),
                            activeColor: getStatusColorss(Dysp),
                            onChanged: (double value) {
                              setState(() {
                                Dysp = value.toInt();
                              });
                            },
                          ),
                          Row(
                            children: const [
                              SizedBox(width: 8),
                              Text('Phlegm'),
                            ],
                          ),
                          Slider(
                            value: phlegm.toDouble(),
                            min: 0,
                            max: 2,
                            divisions: 2,
                            label: getStatusLabel(phlegm),
                            activeColor: getStatusColor(phlegm),
                            onChanged: (double value) {
                              setState(() {
                                phlegm = value.toInt();
                              });
                            },
                          ),
                          Row(
                            children: const [
                              SizedBox(width: 8),
                              Text('Exposure to Smoke'),
                            ],
                          ),
                          Slider(
                            value: Psmoke.toDouble(),
                            min: 0,
                            max: 2,
                            divisions: 2,
                            label: getStatusLabel(Psmoke),
                            activeColor: getStatusColor(Psmoke),
                            onChanged: (double value) {
                              setState(() {
                                Psmoke = value.toInt();
                              });
                            },
                          ),
                          Row(
                            children: const [
                              SizedBox(width: 8),
                              Text('Cold Status'),
                            ],
                          ),
                          Slider(
                            value: Cold.toDouble(),
                            min: 0,
                            max: 2,
                            divisions: 2,
                            label: getStatusLabel(Cold),
                            activeColor: getStatusColor(Cold),
                            onChanged: (double value) {
                              setState(() {
                                Cold = value.toInt();
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Card(
                      color: Colors.white.withOpacity(0.9),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8),
                            child: const Text(
                              'MEDICAL HISTORY:',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 19, 90, 138),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 16),
                          CheckboxListTile(
                            title: const Text('Exercise induced symptoms'),
                            value: Exe == 1,
                            onChanged: (value) {
                              setState(() {
                                Exe = value ?? false ? 1 : 0;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Parents with Asthma'),
                            value: par2 == 1,
                            onChanged: (value) {
                              setState(() {
                                par2 = value ?? false ? 1 : 0;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Reaction to Irritants'),
                            value: RIr == 1,
                            onChanged: (value) {
                              setState(() {
                                RIr = value ?? false ? 1 : 0;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Reaction to Emotions'),
                            value: REm == 1,
                            onChanged: (value) {
                              setState(() {
                                REm = value ?? false ? 1 : 0;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Eczema'),
                            value: Ecz == 1,
                            onChanged: (value) {
                              setState(() {
                                Ecz = value ?? false ? 1 : 0;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Food Allergy'),
                            value: Food == 1,
                            onChanged: (value) {
                              setState(() {
                                Food = value ?? false ? 1 : 0;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      color: Colors.white.withOpacity(0.9),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: const Text(
                              'ENVIRONMENT TRIGGERS:',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 19, 90, 138),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 16),
                          CheckboxListTile(
                            title: const Text('Air Pollution'),
                            value: AP == 1,
                            onChanged: (value) {
                              setState(() {
                                AP = value ?? false ? 1 : 0;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Exposure to Animals'),
                            value: Animal == 1,
                            onChanged: (value) {
                              setState(() {
                                Animal = value ?? false ? 1 : 0;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Dampness'),
                            value: Damp == 1,
                            onChanged: (value) {
                              setState(() {
                                Damp = value ?? false ? 1 : 0;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      /*bottomNavigationBar: BottomNavigator(
    currentIndex: currentIndex,
    onTap: (index) => setState(() => currentIndex = index),
    ),*/
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String result;

  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Color boxColor;
    String imagePath;
    TextStyle textStyle;

    if (result == 'You may have asthma attack risk. Please consult a doctor.') {
      imagePath = 'assets/images/risk.png'; // Replace with the actual path to the red image
      textStyle = TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold);
    } else if (result == 'You do not have asthma attack risk.') {
      imagePath = 'assets/images/safe.png'; // Replace with the actual path to the green image
      textStyle = TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold);
    } else {
      // Handle other result values or add default behavior
      boxColor = Colors.white;
      imagePath = ''; // Replace with the actual path to the default image
      textStyle = TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);
    }


    return Scaffold(
        appBar: AppBar(
          title: Text('Result'),
        ),
        body: Center(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(height: 16),
                  Text(
                    result,
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            ),
        );
    }
}
