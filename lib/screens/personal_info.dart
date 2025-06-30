import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/personal_info_controller.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  late PersonalInfoController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersonalInfoController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildInputField(String field) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller.controllers[field],
            decoration: InputDecoration(
              hintText: 'Enter your $field',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
            ),
            keyboardType: _controller.getKeyboardType(field),
            onChanged: (value) {
              setState(() {}); // Trigger rebuild to update validation
            },
          ),
          if (_controller.controllers[field]!.text.isNotEmpty)
            Builder(
              builder: (context) {
                final error = _controller.validateField(
                    field, _controller.controllers[field]!.text);
                if (error != null) {
                  return Padding(
                    padding: EdgeInsets.only(top: 0.5.h, left: 1.w),
                    child: Text(
                      error,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _controller.cancelFieldEdit();
                  setState(() {});
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              ElevatedButton(
                onPressed: () async {
                  final error = await _controller.handleFieldSave(field);
                  if (error == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$field updated successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.opacity, color: Colors.blue),
          onPressed: () {},
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        _buildProfileOption(
                          icon: Icons.person_outline,
                          title: 'Name',
                          onTap: () => _controller.toggleField('Name'),
                        ),
                        if (_controller.expandedField == 'Name')
                          _buildInputField('Name'),
                        _buildDivider(),
                        _buildProfileOption(
                          icon: Icons.person_outline,
                          title: 'Surname',
                          onTap: () => _controller.toggleField('Surname'),
                        ),
                        if (_controller.expandedField == 'Surname')
                          _buildInputField('Surname'),
                        _buildDivider(),
                        _buildProfileOption(
                          icon: Icons.mail_outline,
                          title: 'Email',
                          onTap: () => _controller.toggleField('Email'),
                        ),
                        if (_controller.expandedField == 'Email')
                          _buildInputField('Email'),
                        _buildDivider(),
                        _buildProfileOption(
                          icon: Icons.phone_outlined,
                          title: 'Contact',
                          onTap: () => _controller.toggleField('Contact'),
                        ),
                        if (_controller.expandedField == 'Contact')
                          _buildInputField('Contact'),
                        _buildDivider(),
                        _buildProfileOption(
                          icon: Icons.flag_outlined,
                          title: 'Country',
                          onTap: () => _controller.toggleField('Country'),
                        ),
                        if (_controller.expandedField == 'Country')
                          _buildInputField('Country'),
                        _buildDivider(),
                        _buildProfileOption(
                          icon: Icons.location_city_outlined,
                          title: 'State',
                          onTap: () => _controller.toggleField('State'),
                        ),
                        if (_controller.expandedField == 'State')
                          _buildInputField('State'),
                        _buildDivider(),
                        _buildProfileOption(
                          icon: Icons.pin_drop_outlined,
                          title: 'Pin',
                          onTap: () => _controller.toggleField('Pin'),
                        ),
                        if (_controller.expandedField == 'Pin')
                          _buildInputField('Pin'),
                        _buildDivider(),
                        _buildProfileOption(
                          icon: Icons.location_on_outlined,
                          title: 'Address',
                          onTap: () => _controller.toggleField('Address'),
                        ),
                        if (_controller.expandedField == 'Address')
                          _buildInputField('Address'),
                        _buildDivider(),
                        _buildProfileOption(
                          icon: Icons.date_range_outlined,
                          title: 'Date of Purchase',
                          onTap: () {},
                          isReadOnly: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
    bool isReadOnly = false,
  }) {
    return InkWell(
      onTap: isReadOnly ? null : onTap,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: isLogout
                  ? Colors.red
                  : (isReadOnly ? Colors.grey[400] : Colors.grey[600]),
              size: 6.w,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: isLogout
                          ? Colors.red
                          : (isReadOnly ? Colors.grey[600] : Colors.black),
                    ),
                  ),
                  if (_controller.hasFieldValue(title))
                    Padding(
                      padding: EdgeInsets.only(top: 0.5.h),
                      child: Text(
                        _controller.getFieldDisplayValue(title),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (!isLogout && !isReadOnly)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 4.w,
              ),
            if (isReadOnly)
              Icon(
                Icons.lock_outline,
                color: Colors.grey[400],
                size: 4.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade200,
      indent: 4.w,
      endIndent: 4.w,
    );
  }
}
