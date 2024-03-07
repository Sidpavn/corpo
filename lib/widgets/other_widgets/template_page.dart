
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/network_connectivity.dart';
import '../../../models/themes/theme.dart';
import 'network_error.dart';

class TemplatePage extends StatefulWidget {

  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if(Provider.of<InternetConnection>(context).connection){
      return WillPopScope(
        child: SafeArea(
          child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                backgroundColor: ColorTheme.creme,
                body: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Container()
                      ),
                    );
                  },
                ),
              )
          ),
        ),
        onWillPop: () async => false,
      );
    }
    return networkError();
  }

}