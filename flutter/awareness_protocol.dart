//import 'package:asthma/features/peakflow_meter.dart';
import 'package:asthma/navigator/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'home.dart';
//import 'medication_list.dart';
//import 'profile.dart';
//import 'sos_button.dart';
//import 'vital_signs.dart';

class AwarenessProtocol extends StatefulWidget {
  const AwarenessProtocol({super.key});

  @override
  State<AwarenessProtocol> createState() => _AwarenessProtocolState();
}

class _AwarenessProtocolState extends State<AwarenessProtocol> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awareness Asthma Protocol'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                )); // Navigate back to the homepage
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTabRectangle(
              'Causes, Triggers, and Symptoms',
              'Asthma is a chronic respiratory condition characterized by inflammation and narrowing of the airways.\n\nCommon Causes:\n- Genetic factors\n- Environmental factors\n- Respiratory infections\n- Premature birth\n- Allergic reactions\n\nCommon Triggers:\n- Allergens\n- Respiratory infections\n- Cold air\n- Exercise\n- Irritants\n\nCommon Symptoms:\n- Coughing\n- Wheezing\n- Shortness of breath\n- Chest tightness\n- Rapid breathing',
            ),
            _buildTabRectangle(
              'How to Use Your Asthma Inhaler',
              '1. Shake the inhaler well before using it.\n'
                  '2. Remove the cap and hold the inhaler upright with your index finger on the top and thumb on the bottom.\n'
                  '3. Exhale fully to empty your lungs.\n'
                  '4. Place the mouthpiece between your teeth and close your lips around it, creating a good seal.\n'
                  '5. Start inhaling slowly and deeply while simultaneously pressing down on the canister to release the medication.\n'
                  '6. Continue inhaling for 3-5 seconds or as long as comfortable.\n'
                  '7. Hold your breath for 10 seconds to allow the medication to reach deep into your lungs.\n'
                  '8. Exhale slowly and breathe normally.\n'
                  '9. If a second dose is prescribed, wait for 1-2 minutes before repeating the steps.\n'
                  '10. After use, replace the cap to protect the inhaler.',
            ),
            _buildTabRectangle(
              'How to Use the Peak Flow Meter',
              '1. Stand up straight and remove any food or gum from your mouth.\n'
                  '2. Set the meter\'s indicator to the lowest point or zero.\n'
                  '3. Take a deep breath and fill your lungs with as much air as possible.\n'
                  '4. Place the mouthpiece of the peak flow meter in your mouth, sealing your lips around it.\n'
                  '5. Make sure your tongue does not block the airflow path.\n'
                  '6. Blow into the meter as hard and fast as you can.\n'
                  '7. Note the measurement shown on the meter.\n'
                  '8. Repeat the process two more times and record the highest of the three readings.\n'
                  '9. Compare your highest reading with your personal best or target value to assess your lung function.\n'
                  '10. Remember to clean the mouthpiece of the peak flow meter regularly to maintain accuracy.',
            ),
            _buildTabRectangle(
              'Asthma and Severe Weather',
              'Severe weather conditions can impact individuals with asthma and potentially worsen their symptoms. Here are some key points to consider:\n\n'
                  '- Cold Weather: Cold air can be a trigger for asthma symptoms. Cover your nose and mouth with a scarf or mask when going outside in cold weather.\n'
                  '- Hot Weather: High heat and humidity can also trigger asthma symptoms. Stay hydrated, seek shade, and avoid strenuous activities during extremely hot days.\n'
                  '- Thunderstorms: Thunderstorms can lead to sudden changes in temperature, humidity, and wind patterns. These changes may trigger asthma attacks. Stay indoors during storms and keep windows closed.\n'
                  '- Air Pollution: Severe weather events can worsen air pollution, which can be a trigger for asthma. Pay attention to air quality forecasts and take necessary precautions.\n'
                  '- Allergens: Severe weather can result in increased pollen or mold spore levels, which can trigger asthma symptoms. Stay updated on pollen and mold forecasts and take appropriate measures.\n\n'
                  'It is essential for individuals with asthma to monitor weather conditions and be prepared with appropriate medications and asthma management plans during severe weather events.',
            ),
            _buildTabRectangle(
              'How to Deal with an Asthma Patient',
              'If you are caring for someone with asthma, here are some important considerations:\n\n'
                  '- Education: Learn about asthma, its triggers, symptoms, and emergency management. Understand the individual\'s asthma action plan.\n'
                  '- Medication: Ensure the individual takes their prescribed asthma medications regularly and as directed. Assist with proper inhaler technique if needed.\n'
                  '- Allergen Control: Help create an environment that minimizes exposure to common asthma triggers like dust mites, pet dander, pollen, and mold.\n'
                  '- Communication: Maintain open communication with the individual regarding their symptoms, triggers, and any changes in their condition.\n'
                  '- Emergency Plan: Be familiar with the individual\'s asthma emergency plan. Know when and how to administer rescue medications and seek medical help if necessary.\n'
                  '- Support: Offer emotional support and understanding. Encourage the individual to manage stress and maintain a healthy lifestyle.\n\n'
                  'Remember, each person\'s asthma is unique, so it\'s important to work closely with the individual and their healthcare team to provide the best care and support.',
            ),
            _buildTabRectangle(
              'Tips for asthma management',
              '1. Follow the Asthma Action Plan: Work with your healthcare provider to create an asthma action plan that outlines daily management and emergency steps.\n'
                  '2. Take Medications as Prescribed: Use your prescribed asthma medications regularly, even when you feel fine, to prevent symptoms and manage inflammation.\n'
                  '3. Avoid Asthma Triggers: Identify and avoid triggers such as allergens, tobacco smoke, pollution, strong odors, and respiratory infections.\n'
                  '4. Maintain Good Indoor Air Quality: Keep your home clean, minimize dust, use allergen-proof bedding, and ensure proper ventilation.\n'
                  '5. Stay Active: Engage in regular physical activity, as it can help improve lung function and overall well-being. Consult with your healthcare provider for suitable activities.\n'
                  '6. Monitor Peak Flow: Use a peak flow meter to track your lung function regularly and note any significant changes or drops.\n'
                  '7. Keep Rescue Medications Handy: Carry your quick-relief inhaler (rescue medication) with you at all times in case of asthma symptoms or emergencies.\n'
                  '8. Manage Stress: Practice stress-reducing techniques such as deep breathing exercises, meditation, or engaging in hobbies you enjoy.\n'
                  '9. Educate Others: Educate your family, friends, and coworkers about asthma, its triggers, and how they can support you during asthma episodes.\n'
                  '10. Regular Follow-up with Healthcare Provider: Schedule regular check-ups with your healthcare provider to assess your asthma control and adjust the treatment plan as needed.\n\n'
                  'Remember, proper asthma management and self-care can help you lead a healthy and active life with minimal asthma symptoms.',
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.home),
      ),
    );
  }

  Widget _buildTabRectangle(String tabName, String information) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              tabName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Text(
                information,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            tabName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
