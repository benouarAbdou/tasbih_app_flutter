import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasbih/constants/colors.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String dikrName = 'سبحان الله'; // Example dikr name
    int dikrValue = 1025; // Example dikr value

    // Update the home screen widget with dikr name and value
    _updateWidget(dikrName, dikrValue);

    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: MyColors.primaryColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dikrName, // Display dikr name
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$dikrValue', // Display dikr value
                  style: GoogleFonts.rakkas(
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to update the widget
  Future<void> _updateWidget(String dikrName, int dikrValue) async {
    try {
      await HomeWidget.saveWidgetData<String>('widget_dikr_name', dikrName);
      await HomeWidget.saveWidgetData<int>('widget_dikr_value', dikrValue);
      await HomeWidget.updateWidget(
        name: 'MyWidgetProvider', // Android Widget Provider Class Name
        iOSName: 'MyWidget',
      );
    } catch (e) {
      print('Error updating widget: $e');
    }
  }
}
