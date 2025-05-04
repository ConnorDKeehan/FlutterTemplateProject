import 'package:flutter/material.dart';
import 'package:songguessgame/main.dart';
import 'package:songguessgame/styles/app_styles.dart';
import 'package:songguessgame/widgets/add_item_button.dart';

class AddGameButton extends StatefulWidget {
  final VoidCallback onAdded;
  const AddGameButton({super.key, required this.onAdded});

  @override
  State<AddGameButton> createState() => _AddGameButtonState();
}

class _AddGameButtonState extends State<AddGameButton> {
  final _roundNumberController = TextEditingController();

  void handleAdd() async {
    final roundNumber = int.parse(_roundNumberController.text.trim());

    await signalR.createGame(roundNumber);

    widget.onAdded();

    _roundNumberController.clear();

    Navigator.of(context).pop();
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,      // let it grow above the keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _roundNumberController,
              decoration: InputDecoration(
                hintText: 'Number of rounds',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              minLines: 2,
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: handleAdd,
                  style: AppStyles.submitButtonStyle,
                  child: const Text('Add')
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AddItemButton(onPressed: _showBottomSheet);
  }
}