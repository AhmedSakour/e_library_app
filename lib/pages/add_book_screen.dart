import 'package:flutter/material.dart';
import 'package:homework/models/author.dart';
import 'package:homework/models/publisher.dart';
import 'package:homework/server/admin_service.dart';
import 'package:homework/server/general_service.dart';
import 'package:homework/themes/app_colors.dart';
import 'package:homework/widgets/custom_primary_button.dart';
import 'package:homework/widgets/custom_text_form_field.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _titleController = TextEditingController();
  final _typeController = TextEditingController();
  final _priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final GeneralService _service = GeneralService();
  final AdminService _adminservice = AdminService();

  List<Author> _authors = [];
  List<Publisher> _publishers = [];

  Author? _selectedAuthor;
  Publisher? _selectedPublisher;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    setState(() => _isLoading = true);

    try {
      final authors = await _service.getAllAuthors();
      final publishers = await _service.getAllPublishers();

      setState(() {
        _authors = authors;
        _publishers = publishers;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(" error in get data:  $e")),
      );
    }

    setState(() => _isLoading = false);
  }

  Future<void> _submitBook() async {
    if (_selectedAuthor == null || _selectedPublisher == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("please select auhtor and publisher")),
      );
      return;
    }

    final title = _titleController.text.trim();
    final type = _typeController.text.trim();
    final price = double.tryParse(_priceController.text) ?? 0.0;

    if (title.isEmpty || type.isEmpty || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("please fill all the fields")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await _adminservice.addBook(
        title: title,
        type: type,
        price: price,
        authorId: _selectedAuthor!.id!,
        pubId: _selectedPublisher!.id!,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("add book successfully")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("field adding book  : $e")),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Book',
          style: TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _titleController,
                      textInputType: TextInputType.text,
                      prefixIcon: Icons.title,
                      hint: 'Title',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter the title';
                        }
                        return null;
                      },
                      label: 'Title',
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      controller: _typeController,
                      textInputType: TextInputType.text,
                      prefixIcon: Icons.type_specimen_outlined,
                      hint: 'Type',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter type of book';
                        }
                        return null;
                      },
                      label: 'Type',
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      controller: _priceController,
                      textInputType: TextInputType.text,
                      prefixIcon: Icons.price_change_outlined,
                      hint: 'Price',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter price';
                        }
                        return null;
                      },
                      label: 'Price',
                    ),
                    const SizedBox(height: 25),
                    DropdownButtonFormField<Author>(
                      decoration: InputDecoration(
                        labelText: 'Select Author',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: AppColors.primaryColor)),
                      ),
                      value: _selectedAuthor,
                      items: _authors.map((a) {
                        return DropdownMenuItem(
                          value: a,
                          child: Text("${a.fname} ${a.lname}"),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedAuthor = value);
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<Publisher>(
                      decoration: InputDecoration(
                        labelText: 'Select Publisher',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: AppColors.primaryColor)),
                      ),
                      value: _selectedPublisher,
                      items: _publishers.map((p) {
                        return DropdownMenuItem(
                          value: p,
                          child: Text(p.pname),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedPublisher = value);
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomPrimaryButton(
                      text: 'Save Book',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _submitBook();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
