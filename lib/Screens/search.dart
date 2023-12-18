import 'package:flutter/material.dart';
import 'package:medihub_1/color/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'searchresault.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> availableEquipment = [
    'Aerosol',
    'Chair Wheel',
    'Blood pressure machine',
    // Add more equipment names from the database
  ];
    String selectedEquipment = '';

 List<DateTime> _selectedDays = [];
  Map<DateTime, Color> _dayColors = {};
  double minPrice = 0.0;
  double maxPrice = 100.0; // Set your maximum price range

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:
     
     
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          
          children: [
            SearchBar(),
            Text(
              'Available Equipment Categories:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
           SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: availableEquipment
            .map(
              (equipment) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedEquipment = equipment;
                  });
                  print('Selected: $equipment');
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: equipment == selectedEquipment
                        ? green
                        : Colors.blue,
                  ),
                  child: Text(
                    equipment,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ),
            SizedBox(height: 10),
            Text(
              'Price Range:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              min: 0,
              activeColor: green,
              max: 7000,
              value: maxPrice,
              onChanged: (value) {
                setState(() {
                  maxPrice = value;
                });
              },
            ),
            Text('Max Price: ${maxPrice.toStringAsFixed(2)} DZD /Day '),
            SizedBox(height: 20),
            Text(
              'Select Date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
           
           Expanded(
  child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: TableCalendar(
  calendarFormat: _calendarFormat,
  focusedDay: _focusedDay,
  firstDay: DateTime.utc(2023, 1, 1),
  lastDay: DateTime.utc(2023, 12, 31),
  calendarStyle: CalendarStyle(
    selectedDecoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.blue,
    ),
    todayDecoration: BoxDecoration(
      shape: BoxShape.circle,
      
      color: Colors.blue,
    ),
  ),
  onDaySelected: (selectedDay, focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });
  },
  onFormatChanged: (format) {
    setState(() {
      _calendarFormat = format;
    });
  },
  onPageChanged: (focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
  },
  calendarBuilders: CalendarBuilders(
    // Add a gesture detector to each date cell
    defaultBuilder: (context, date, _) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedDay = date;
            if (_selectedDays.contains(date)) {
              _selectedDays.remove(date);
            } else {
              _selectedDays.add(date);
            }
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _selectedDays.contains(date)
                ? green
                : Colors.transparent,
          ),
          child: Text(
            date.day.toString(),
            style: TextStyle(
              color: _selectedDay == date ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    },
  ),
),
    ),
  ),
),
            
            SizedBox(height: 20),
            ElevatedButton(
               style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48), backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),
               ),
             onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPageres()),
    );
  
                // Perform search with selected data
               
                //print('Selected Date: $_selectedDay');

              },
              child:Text(
              'Book',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            ),
          ],
        ),
      ),
    );
    
  }
}
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: double.infinity,
      height: 50.0, // Set the desired height
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: dark),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: Icon(Icons.search, color: dark),
        ),
      ),
    );
  }
}

