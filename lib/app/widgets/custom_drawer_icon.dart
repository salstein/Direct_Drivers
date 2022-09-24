import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/asset_path.dart';


class CustomAppBar extends StatelessWidget {
  final void Function()? onTap;
  const CustomAppBar({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 8, right: 8),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: AppBar().preferredSize.height,
                width: AppBar().preferredSize.height,
                child: Padding(padding: const EdgeInsets.all(4.0),
                  child: Card(margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0),),
                    child: Container(decoration: BoxDecoration(color: Theme.of(context).cardColor, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(2),
                      child: InkWell(onTap: onTap,
                        child: ClipRRect(borderRadius: BorderRadius.circular(32.0),
                            child: SvgPicture.asset(AssetPath.menuBar, fit: BoxFit.none,),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
