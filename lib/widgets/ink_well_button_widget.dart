import 'package:flutter/material.dart';

class IWButtonWidget extends StatefulWidget {
  const IWButtonWidget({Key? key, required this.title, required this.function, required this.heightFactor, required this.widthFactor}) : super(key: key);

  final String title;
  final Function function;
  final num heightFactor;
  final num widthFactor;

  void loadSignup(BuildContext context) {
    //Navigator.of(context).pushNamed(SignupScreenLevel02.routeName, arguments: {});
  }

  @override
  State<IWButtonWidget> createState() => _IWButtonWidgetState();
}

class _IWButtonWidgetState extends State<IWButtonWidget> {
  @override
  Widget build(BuildContext context) {
    /*return Container(
      color: Colors.blue,
      width: MediaQuery.of(context).size.width * widget.widthFactor,
      height: MediaQuery.of(context).size.height * widget.heightFactor,
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            setState(() {
              widget.function.call();
              // widget.loadSignup(context);
            });
          },
          child: Center(
            child: Text(widget.title, textScaleFactor: 2, style: const TextStyle(fontWeight: FontWeight.bold)),
          )),
    );*/

    return SizedBox(
      width: MediaQuery.of(context).size.width * widget.widthFactor,
      height: MediaQuery.of(context).size.height * widget.heightFactor,
      child: MaterialButton(
        color: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onPressed: () {
          setState(() {
            widget.function.call();
            // widget.loadSignup(context);
          });
        },
        child: Center(
          child: Text(widget.title, textScaleFactor: 2, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
