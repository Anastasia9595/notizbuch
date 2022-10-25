import 'package:flutter/material.dart';

/// A customizable alert dialog to provide feedback to the user.
/// For the Icon choose either a [IconData] or a [Text] widget.
/// The title should describe the alert as [String].
/// For the content its recommended to use a [Text] widget, but you can also use another [Widget].
/// The [actions] should be a list of 1-2 [Widget]s, which will be displayed as buttons.
/// For every action you can add a [Function] which will be executed when the button is pressed.
class Alert extends StatelessWidget {
  final IconData? icon;
  final Text? iconWidget;
  final Color iconColor;
  final String title;
  final Color titleColor;
  final Widget content;
  final List<Function> functions;
  final List<String> functionNames;
  const Alert(
      {super.key,
      this.icon,
      this.iconWidget,
      required this.iconColor,
      required this.title,
      required this.titleColor,
      required this.content,
      required this.functions,
      required this.functionNames});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              backgroundColor: Colors.blueGrey.shade100,
              scrollable: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: SizedBox(
                  height: 42,
                  child: FittedBox(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: titleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              content: SizedBox(
                height: 60,
                child: SingleChildScrollView(
                  child: content,
                ),
              ),
              actions: [
                functions.length == 2
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: FittedBox(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                  fixedSize: const Size(69, 42),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () => functions[0](),
                                child: Text(functionNames[0]),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: FittedBox(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade900,
                                  fixedSize: const Size(69, 42),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () => functions[1](),
                                child: Text(functionNames[1]),
                              ),
                            ),
                          ),
                        ],
                      )
                    : functions.length == 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: FittedBox(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey,
                                      fixedSize: const Size(69, 42),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () => functions[0](),
                                    child: Text(functionNames[0]),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(),
              ],
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.center,
                    height: 69,
                    width: 69,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(69),
                    ),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: iconColor,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Center(
                        child: iconWidget ??
                            Icon(
                              icon,
                              size: 50,
                              color: Colors.blueGrey.shade100,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
