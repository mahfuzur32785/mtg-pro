import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({Key? key, required this.icon, required this.text, required this.onPressed}) : super(key: key);
  final IconData icon;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: (){
          onPressed();
        },
        child: Container(
          height: 55,
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.black54,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 16,
                color: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
