import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/login_page/phone_page.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Numpad extends StatefulWidget {
  final int length;
  final Function onChange;
  final bool isCreatePin;

  const Numpad({
    super.key,
    this.length = 6,
    required this.onChange,
    this.isCreatePin = false,
  });

  @override
  State<Numpad> createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {
  String number = '';
  String resetpin = 'reset';

  setValue(String val) {
    if (number.length < widget.length) {
      setState(() {
        number += val;

        widget.onChange(number);
      });
    }

    if (number.length == widget.length) {
      setState(() {
        number = '';
        widget.onChange('');
      });
    }
  }

  backspace(String text) {
    if (text.isNotEmpty) {
      setState(() {
        number = text.split('').sublist(0, text.length - 1).join('');
        widget.onChange(number);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.h,
      ),
      child: Column(
        children: <Widget>[
          Preview(text: number, length: widget.length),
          // pinold != '' || pinold == null
          //     ?
          //     : SizedBox.shrink(),
          !widget.isCreatePin
              ? TextButton(
                  onPressed: () async {
                    // SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();
                    // resetpin = prefs.getString(KeyStorage.pin);
                    // await prefs.remove(KeyStorage.pin);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Phone_page(clearpin: resetpin),
                      ),
                    );
                  },
                  child: Text(
                    'ลืมรหัสผ่าน',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '1',
                onPressed: () => setValue('1'),
              ),
              NumpadButton(
                text: '2',
                onPressed: () => setValue('2'),
              ),
              NumpadButton(
                text: '3',
                onPressed: () => setValue('2'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '4',
                onPressed: () => setValue('4'),
              ),
              NumpadButton(
                text: '5',
                onPressed: () => setValue('5'),
              ),
              NumpadButton(
                text: '6',
                onPressed: () => setValue('6'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NumpadButton(
                text: '7',
                onPressed: () => setValue('7'),
              ),
              NumpadButton(
                text: '8',
                onPressed: () => setValue('8'),
              ),
              NumpadButton(
                text: '9',
                onPressed: () => setValue('9'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const NumpadButton(),
              NumpadButton(
                text: '0',
                onPressed: () => setValue('0'),
              ),
              NumpadButton(
                icon: Icons.backspace,
                onPressed: () => backspace(number),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Preview extends StatelessWidget {
  final int length;
  final String text;

  const Preview({super.key, this.length = 6, required this.text});

  @override
  Widget build(BuildContext context) {
    List<Widget> previewLength = [];

    for (var i = 0; i < length; i++) {
      previewLength.add(Dot(isActive: text.length >= i + 1));
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Wrap(children: previewLength),
    );
  }
}

class Dot extends StatelessWidget {
  final bool isActive;

  const Dot({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 14.w,
        height: 13.h,
        decoration: BoxDecoration(
          color: isActive ? Colors.teal.shade700 : Colors.white,
          border: Border.all(
            width: 1.0,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}

class NumpadButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool haveBorder;
  final VoidCallback? onPressed;

  const NumpadButton({
    super.key,
    this.text,
    this.icon,
    this.haveBorder = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle = TextStyle(
      fontSize: 32.sp,
      color: Colors.white,
    );

    Widget label = icon != null
        ? Icon(
            icon,
            color: Colors.white,
          )
        : Text(text ?? '', style: buttonStyle);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          padding: const EdgeInsets.all(8.0),
        ),
        onPressed: onPressed,
        child: label,
      ),
    );
  }
}
