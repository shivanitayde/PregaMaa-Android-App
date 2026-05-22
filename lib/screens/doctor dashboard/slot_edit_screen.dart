import 'package:flutter/material.dart';
import 'package:pregmaa/data/dummy_data.dart';
import 'package:pregmaa/model/slot_model.dart';

class SlotEditScreen extends StatefulWidget {
  const SlotEditScreen({super.key});

  @override
  State<SlotEditScreen> createState() => _SlotEditScreenState();
}

class _SlotEditScreenState extends State<SlotEditScreen> {
  DateTime? selectedDate;

  List<String> tempTimes = [];

  /// Pick Date
  pickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  /// Pick Time
  pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      final formatted = time.format(context);

      setState(() {
        tempTimes.add(formatted);
      });
    }
  }

  /// Add Slot
  addSlot() {
    if (selectedDate == null || tempTimes.isEmpty) return;

    setState(() {
      slots.add(
        Slot(
          id: DateTime.now().millisecondsSinceEpoch.toString(),

          date: selectedDate!,

          times: List.from(tempTimes),
        ),
      );

      selectedDate = null;

      tempTimes.clear();
    });
  }

  /// Delete Slot
  deleteSlot(int index) {
    setState(() {
      slots.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Slots")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            /// Select Date
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? "Select Date"
                        : "${selectedDate!.day}/"
                              "${selectedDate!.month}/"
                              "${selectedDate!.year}",
                  ),
                ),

                ElevatedButton(
                  onPressed: pickDate,
                  child: const Text("Pick Date"),
                ),
              ],
            ),

            const SizedBox(height: 15),

            /// Add Time
            Row(
              children: [
                Expanded(child: Text(tempTimes.join(", "))),

                ElevatedButton(
                  onPressed: pickTime,
                  child: const Text("Add Time"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Save Slot
            ElevatedButton(onPressed: addSlot, child: const Text("Add Slot")),

            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 10),

            /// Existing Slots
            Expanded(
              child: ListView.builder(
                itemCount: slots.length,

                itemBuilder: (context, index) {
                  final slot = slots[index];

                  return Card(
                    child: ListTile(
                      title: Text(
                        "${slot.date.day}/"
                        "${slot.date.month}/"
                        "${slot.date.year}",
                      ),

                      subtitle: Text(slot.times.join(", ")),

                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          deleteSlot(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
