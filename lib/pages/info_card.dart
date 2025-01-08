import 'package:fluent_ui/fluent_ui.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, this.title, this.subTitle, required this.child});

  final String? title;
  final String? subTitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  title!,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
              )
            : Container(),
        subTitle != null
            ? const SizedBox(
                height: 10,
              )
            : Container(),
        subTitle != null
            ? Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  subTitle!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              )
            : Container(),
        const SizedBox(
          height: 20,
        ),
        child
      ],
    ));
  }
}
