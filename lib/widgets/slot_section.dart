import 'package:flutter/material.dart';
import '../model/slot_model.dart';

class SlotSection extends StatelessWidget {
  final List<Slot> slots;
  final VoidCallback onEdit;

  const SlotSection({super.key, required this.slots, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              const Text(
                "Available Slots",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            ],
          ),

          const SizedBox(height: 10),

          Column(
            children: slots.map((slot) {
              return Card(
                child: ListTile(
                  title: Text(
                    "${slot.date.day}/${slot.date.month}/${slot.date.year}",
                  ),

                  subtitle: Text(slot.times.join(", ")),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
