import 'package:equipment_app/models/equipment.dart';
import 'package:flutter/material.dart';

class EquipmentTile extends StatelessWidget {
  const EquipmentTile({Key? key, required this.equipment}) : super(key: key);

  final Equipment equipment;

  final double iconSize = 40;

  Icon iconFromDeviceType(BuildContext context, DeviceType type) {
    final IconData icon;

    switch (type) {
      case DeviceType.laptop:
        icon = Icons.laptop;
        break;
      case DeviceType.tablet:
        icon = Icons.tablet;
        break;
      case DeviceType.mouse:
        icon = Icons.mouse;
        break;
      case DeviceType.keyboard:
        icon = Icons.keyboard;
        break;
      case DeviceType.headphones:
        icon = Icons.headphones;
        break;
      case DeviceType.camera:
        icon = Icons.photo_camera;
        break;
      case DeviceType.other:
        icon = Icons.devices;
        break;
      default:
        icon = (Icons.devices);
        break;
    }

    return Icon(icon,
        size: iconSize, color: Theme.of(context).colorScheme.primary);
  }

  Icon? iconFromAvailable(bool? available) {
    if (available == null) {
      return null;
    }

    final Icon icon;

    icon = available
        ? const Icon(
            Icons.check_circle,
            color: Colors.green,
          )
        : const Icon(
            Icons.cancel,
            color: Colors.red,
          );

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(equipment.name),
      subtitle: Text(equipment.serial),
      leading: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Align(
              alignment: Alignment.center,
              child: iconFromDeviceType(context, equipment.deviceType))),
      trailing: iconFromAvailable(equipment.available),
      onTap: () {},
    );
  }
}
