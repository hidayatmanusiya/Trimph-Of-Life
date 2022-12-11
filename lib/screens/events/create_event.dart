import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triumph_life_ui/Controller/event_controller.dart';
import 'package:triumph_life_ui/common_widgets/spaces_widgets.dart';
import 'package:triumph_life_ui/common_widgets/text_field.dart';

class CreateEvent extends StatelessWidget {
  final EventController eventController = Get.put(EventController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('New Event'),
          ),
          body: Container(
            child: Form(
                child: SingleChildScrollView(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _heading('Title'),
                textBox(
                  hint: "Title",
                  validator: controller.titleValidator,
                  onSave: (input) {
                    controller.title = input;
                  },
                ),
                spc20,
                _heading('Description'),
                textBox(
                  hint: "Description",
                  maxLine: null,
                  onSave: (input) {
                    controller.description = input;
                  },
                ),
                spc20,
                _heading('Location'),
                textBox(
                  hint: "Location",
                  maxLine: null,
                  onSave: (input) {
                    controller.description = input;
                  },
                ),
                spc20,
                Row(
                  children: [
                    _heading('Event Time: ${controller.getDate()} '),
                    if (controller.isTime) Text('at ${controller.getTime()}')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text('Select Date')),
                    TextButton(
                        onPressed: () {
                          _selectTime(context);
                        },
                        child: Text('Select Time'))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('Post')),
                  ],
                )
              ],
            ))),
          ),
        );
      },
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: eventController.selectedDateTime, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != eventController.selectedDateTime)
      eventController.selectedDateTime = picked;
    eventController.update();
  }

  _selectTime(BuildContext context) async {
    final timepicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(eventController.selectedDateTime));
    if (timepicked != null) {
      eventController.updateDate(timepicked.hour, timepicked.minute);
    }
  }

  Widget _heading(txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        txt,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
