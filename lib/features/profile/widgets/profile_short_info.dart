import 'package:flutter/cupertino.dart';
import 'package:test_environtment/features/profile/widgets/profile_short_info_state.dart';


class ProfileShortInfo extends StatefulWidget {
  const ProfileShortInfo({
    super.key,
    required this.image,
    required this.imageUrls,
    required this.nameController,
  });

  final List<String> image;
  final List<String> imageUrls;
  final TextEditingController nameController;

  @override
  ProfileShortInfoState createState() => ProfileShortInfoState();
}