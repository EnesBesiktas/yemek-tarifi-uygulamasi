import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../models/recipe.dart';
import '../services/firestore_service.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _preparationTimeController = TextEditingController();
  final _categoryController = TextEditingController();
  final _starsController = TextEditingController(text: '0');
  bool _isFavorite = false;
  bool _isLoading = false;
  File? _selectedImage;
  String? _uploadedImageUrl;

  final FirestoreService _firestoreService = FirestoreService();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    _preparationTimeController.dispose();
    _categoryController.dispose();
    _starsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resim seçilirken hata oluştu: $e')),
      );
    }
  }

  Future<String?> _uploadImage() async {
    if (_selectedImage == null) return null;

    try {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference storageRef = FirebaseStorage.instance.ref().child('recipe_images/$fileName.jpg');
      
      final UploadTask uploadTask = storageRef.putFile(_selectedImage!);
      final TaskSnapshot taskSnapshot = await uploadTask;
      
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resim yüklenirken hata oluştu: $e')),
      );
      return null;
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen önce giriş yapın')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      String? imageUrl;
      if (_selectedImage != null) {
        imageUrl = await _uploadImage();
        if (imageUrl == null) {
          throw Exception('Resim yüklenemedi');
        }
      }

      final recipe = Recipe(
        id: '', // Firestore otomatik oluşturacak
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: imageUrl ?? '',
        ingredients: _ingredientsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        instructions: _instructionsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        preparationTime: _preparationTimeController.text.trim(),
        category: _categoryController.text.trim(),
        userId: user.uid,
        stars: int.tryParse(_starsController.text.trim()) ?? 0,
        isFavorite: _isFavorite,
      );
      await _firestoreService.addRecipe(recipe);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tarif başarıyla eklendi!')));
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarif Ekle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Tarif Adı'),
                validator: (v) => v == null || v.isEmpty ? 'Zorunlu alan' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Açıklama'),
                validator: (v) => v == null || v.isEmpty ? 'Zorunlu alan' : null,
              ),
              const SizedBox(height: 16),
              if (_selectedImage != null)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: Text(_selectedImage == null ? 'Resim Seç' : 'Resmi Değiştir'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(labelText: 'Malzemeler (virgülle ayır)'),
                validator: (v) => v == null || v.isEmpty ? 'Zorunlu alan' : null,
              ),
              TextFormField(
                controller: _instructionsController,
                decoration: const InputDecoration(labelText: 'Yapılış (virgülle ayır)'),
                validator: (v) => v == null || v.isEmpty ? 'Zorunlu alan' : null,
              ),
              TextFormField(
                controller: _preparationTimeController,
                decoration: const InputDecoration(labelText: 'Hazırlama Süresi'),
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextFormField(
                controller: _starsController,
                decoration: const InputDecoration(labelText: 'Yıldız (0-5)'),
                keyboardType: TextInputType.number,
              ),
              SwitchListTile(
                value: _isFavorite,
                onChanged: (v) => setState(() => _isFavorite = v),
                title: const Text('Favori'),
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Tarifi Kaydet'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
} 