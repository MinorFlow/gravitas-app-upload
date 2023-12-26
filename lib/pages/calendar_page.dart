import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with AutomaticKeepAliveClientMixin {
  DateTime today = DateTime.now();
  @override
  bool get wantKeepAlive => true;

  final List<bool> _selections1 = List.generate(3, (index) => false);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        TableCalendar(
          locale: 'ko-KR',
          focusedDay: today,
          firstDay: DateTime.utc(2021, 01, 01),
          lastDay: DateTime.utc(2030, 12, 31),
          daysOfWeekHeight: 30, // 날짜 설정
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronVisible: true,
            rightChevronVisible: true,
            titleTextStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ), //헤더 디자인
          calendarStyle: CalendarStyle(
            // 켈린더 내부 디자인
            outsideDaysVisible: false, //이전, 이후 달 보이지 않기
            defaultTextStyle: const TextStyle(
                //평일 날짜 디자인
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500),
            weekendTextStyle: const TextStyle(
                //주말 날짜 디자인
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.w500),
            todayDecoration: BoxDecoration(
                // 오늘 날짜 디자인
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 3)),
            todayTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.blue),
            tableBorder: const TableBorder(
              top: BorderSide(color: Colors.black),
              horizontalInside: BorderSide(color: Colors.black),
              verticalInside: BorderSide(color: Colors.black),
            ),
            rowDecoration: const BoxDecoration(
              color: Colors.white30,
            ),
            selectedDecoration: const BoxDecoration(
              color: Colors.brown,
            ),
          ),
        ),
        ToggleButtons(
          renderBorder: true,
          borderRadius: BorderRadius.circular(10),
          borderWidth: 10,
          borderColor: Colors.white,
          selectedColor: Colors.blue,
          fillColor: Colors.blue,
          color: Colors.black12,
          onPressed: (int index) {
            setState(() {
              _selections1[index] = !_selections1[index];
            });
          },
          isSelected: _selections1,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                "Today",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "ALL",
                style: TextStyle(fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.tune),
            ),
          ],
        ), // 토글 버튼
      ],
    );
  }
}