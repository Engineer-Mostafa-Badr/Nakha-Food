import 'package:flutter/material.dart';
import 'package:nakha/core/components/utils/widgets.dart';
import 'package:nakha/core/extensions/widgets_extensions.dart';
import 'package:nakha/core/res/app_images.dart';

class SwitchButtonReuse extends StatefulWidget {
  const SwitchButtonReuse({
    super.key,
    required this.switchValue,
    required this.onSwitchChanged,
  });

  final bool switchValue;
  final Function(bool) onSwitchChanged;

  @override
  State<SwitchButtonReuse> createState() => _SwitchButtonReuseState();
}

class _SwitchButtonReuseState extends State<SwitchButtonReuse>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _switchValue = false;

  void _onSwitchChanged(bool value) {
    setState(() {
      _switchValue = value;
    });
    widget.onSwitchChanged(value);
  }

  @override
  void initState() {
    super.initState();
    _switchValue = widget.switchValue;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AssetSvgImage(
      _switchValue
          ? AssetImagesPath.selectedSwitchSVG
          : AssetImagesPath.unselectedSwitchSVG,
    ).addAction(
      onTap: () {
        _onSwitchChanged(!_switchValue);
      },
    );
  }
}
