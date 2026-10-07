import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/responsive/responsive.dart';
class SubmitComplaintScreen extends StatefulWidget {
  const SubmitComplaintScreen({super.key});

  @override
  State<SubmitComplaintScreen> createState() => _SubmitComplaintScreenState();
}

class _SubmitComplaintScreenState extends State<SubmitComplaintScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedDepartment;
  String? _selectedCategory;
  String _selectedPriority = 'Medium';

  final List<String> _departments = [
    'IT Department',
    'Facilities Department',
    'Academic Department',
    'Library',
    'Transport',
    'Security',
    'Student Affairs',
  ];

  final List<String> _categories = [
    'IT & Equipment',
    'Maintenance',
    'Facilities',
    'Academic',
    'Library',
    'Transport',
    'Security',
    'Other',
  ];

  final List<String> _priorities = [
    'Low',
    'Medium',
    'High',
    'Urgent',
  ];

  String? _attachedFileName;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submitComplaint() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDepartment == null) {
      _showMessage('Please select a department.');
      return;
    }

    if (_selectedCategory == null) {
      _showMessage('Please select a complaint category.');
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Complaint Submitted',
            style: AppTextStyles.displayMedium.copyWith(
              color: AppColors.white,
              fontSize: 22,
            ),
          ),
          content: Text(
            'Your complaint has been submitted successfully. '
                'You can track its progress from My Complaints.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                'Done',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.surfaceVariant,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.white,
      ),
      prefixIcon: Icon(
        icon,
        color: AppColors.darkBackground,
      ),
      filled: true,
      fillColor: AppColors.primaryBright,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 17,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColors.darkBorder,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColors.secondary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColors.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildLabel(String text, {bool required = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (required)
            Text(
              ' *',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.darkBackground,
      ),
      dropdownColor: AppColors.surface,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.darkTextPrimary,
      ),
      decoration: _inputDecoration(
        hint: hint,
        icon: icon,
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
    );
  }

  Widget _buildAttachmentSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.darkBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.attach_file_rounded,
                  color: AppColors.secondary,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Attachments',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _attachedFileName = 'example_attachment.jpg';
                  });

                  _showMessage(
                    'Attachment selected for preview.',
                  );
                },
                icon: const Icon(
                  Icons.add_rounded,
                  size: 20,
                ),
                label: const Text('Add File'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Attach images or documents that can help explain your complaint.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 14),
          if (_attachedFileName != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.insert_drive_file_rounded,
                    color: AppColors.secondary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _attachedFileName!,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.darkTextPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _attachedFileName = null;
                      });
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.darkTextSecondary,
                      size: 20,
                    ),
                    tooltip: 'Remove',
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text('Submit Complaint'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.horizontalPadding(context),
              vertical: 24,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1000,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(
                  isDesktop ? 34 : 22,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.overlay,
                      blurRadius: 24,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Submit a Complaint',
                        style: AppTextStyles.displayMedium.copyWith(
                          color: AppColors.secondary,
                          fontSize: isDesktop ? 30 : 26,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tell us about the issue and provide enough '
                            'information so it can be handled efficiently.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 30),

                      _buildLabel('Complaint Title'),
                      TextFormField(
                        controller: _titleController,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.darkTextPrimary,
                        ),
                        decoration: _inputDecoration(
                          hint: 'Enter a short title for your complaint',
                          icon: Icons.title_rounded,
                        ),
                        validator: (value) {
                          final text = value?.trim() ?? '';

                          if (text.isEmpty) {
                            return 'Please enter a complaint title';
                          }

                          if (text.length < 5) {
                            return 'Title must be at least 5 characters';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 22),

                      if (isDesktop)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Department'),
                                  _buildDropdown(
                                    value: _selectedDepartment,
                                    hint: 'Select department',
                                    icon: Icons.account_balance_rounded,
                                    items: _departments,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedDepartment = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Category'),
                                  _buildDropdown(
                                    value: _selectedCategory,
                                    hint: 'Select category',
                                    icon: Icons.category_rounded,
                                    items: _categories,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCategory = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Department'),
                            _buildDropdown(
                              value: _selectedDepartment,
                              hint: 'Select department',
                              icon: Icons.account_balance_rounded,
                              items: _departments,
                              onChanged: (value) {
                                setState(() {
                                  _selectedDepartment = value;
                                });
                              },
                            ),
                            const SizedBox(height: 22),
                            _buildLabel('Category'),
                            _buildDropdown(
                              value: _selectedCategory,
                              hint: 'Select category',
                              icon: Icons.category_rounded,
                              items: _categories,
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value;
                                });
                              },
                            ),
                          ],
                        ),

                      const SizedBox(height: 22),

                      if (isDesktop)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Location'),
                                  TextFormField(
                                    controller: _locationController,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.darkTextPrimary,
                                    ),
                                    decoration: _inputDecoration(
                                      hint: 'e.g. Building A, Room 204',
                                      icon: Icons.location_on_outlined,
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please enter the location';
                                      }

                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Priority'),
                                  _buildDropdown(
                                    value: _selectedPriority,
                                    hint: 'Select priority',
                                    icon: Icons.flag_outlined,
                                    items: _priorities,
                                    onChanged: (value) {
                                      if (value == null) return;

                                      setState(() {
                                        _selectedPriority = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Location'),
                            TextFormField(
                              controller: _locationController,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.darkTextPrimary,
                              ),
                              decoration: _inputDecoration(
                                hint: 'e.g. Building A, Room 204',
                                icon: Icons.location_on_outlined,
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'Please enter the location';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 22),
                            _buildLabel('Priority'),
                            _buildDropdown(
                              value: _selectedPriority,
                              hint: 'Select priority',
                              icon: Icons.flag_outlined,
                              items: _priorities,
                              onChanged: (value) {
                                if (value == null) return;

                                setState(() {
                                  _selectedPriority = value;
                                });
                              },
                            ),
                          ],
                        ),

                      const SizedBox(height: 22),

                      _buildLabel('Description'),
                      TextFormField(
                        controller: _descriptionController,
                        minLines: 6,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.darkTextPrimary,
                        ),
                        decoration: _inputDecoration(
                          hint: 'Describe the issue in detail...',
                          icon: Icons.description_outlined,
                        ),
                        validator: (value) {
                          final text = value?.trim() ?? '';

                          if (text.isEmpty) {
                            return 'Please describe your complaint';
                          }

                          if (text.length < 20) {
                            return 'Description must be at least 20 characters';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 22),

                      _buildAttachmentSection(),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton.icon(
                          onPressed: _submitComplaint,
                          icon: const Icon(
                            Icons.send_rounded,
                          ),
                          label: Text(
                            'Submit Complaint',
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBright,
                            foregroundColor: AppColors.textPrimary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Center(
                        child: Text(
                          'Please provide accurate information to help us resolve the issue.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.darkTextTertiary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}