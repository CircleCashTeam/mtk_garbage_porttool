import 'package:fluent_ui/fluent_ui.dart';

enum PortMethods { mt6572Common, mt6735Common, mtkCommon }

class PagePort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PagePortLeft(),
            SizedBox(width: 10,),
            PagePortRight(),
          ],
        ));
  }
}

class PagePortLeft extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("移植方案"),
              SizedBox(width: 10,),
              ComboBox(
                  onChanged: (value) {
                      
                  },
                    items: [
                  'MT6735/37(m) Kernel 3.18.19',
                  'MT6572/82/92 Kernel 3.4.67',
                  'MTK Common Kernel and Options'
                ].map((e) {
                  return ComboBoxItem(value: e, child: Text(e));
                }).toList()),
            ],
          ),
          Expanded(child: 
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Card(
              child: TreeView(items: 
              List.generate(200, (value) {
                return TreeViewItem(content: Text("item $value"), value: value);
              })
              ),
            ),
          )),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Button(child: Text("dummy"), onPressed: () {})),
              SizedBox(width: 10,),
              Expanded(child: Button(child: Text("dymmy"), onPressed: () {})),
            ],
          )

        ],
      ),
    );
  }
}

class PagePortRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("日志输出"),
              Button(child: const Text("清除"), onPressed: () {})
              ],
          ),
          const SizedBox(height: 10,),
          const Expanded(
            child: TextBox(
              minLines: null,
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
