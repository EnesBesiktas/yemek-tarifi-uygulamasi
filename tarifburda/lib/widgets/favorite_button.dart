import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class FavoriteButton extends StatefulWidget {
  final String userId;
  final String recipeId;
  final double size;
  final Color? color;
  final Color? activeColor;

  const FavoriteButton({
    Key? key,
    required this.userId,
    required this.recipeId,
    this.size = 24.0,
    this.color,
    this.activeColor,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final FirestoreService _firestoreService = FirestoreService();
  bool _isFavorite = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    try {
      final isFavorite = await _firestoreService.isRecipeFavorite(
        widget.userId,
        widget.recipeId,
      );
      if (mounted) {
        setState(() {
          _isFavorite = isFavorite;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Favori durumu kontrol edilirken hata oluştu: $e')),
        );
      }
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isFavorite) {
        await _firestoreService.removeFavorite(widget.userId, widget.recipeId);
      } else {
        await _firestoreService.addFavorite(widget.userId, widget.recipeId);
      }

      if (mounted) {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isFavorite
                ? 'Favorilerden çıkarılırken hata oluştu: $e'
                : 'Favorilere eklenirken hata oluştu: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isLoading
          ? SizedBox(
              width: widget.size,
              height: widget.size,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.activeColor ?? Theme.of(context).primaryColor,
                ),
              ),
            )
          : Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              size: widget.size,
              color: _isFavorite
                  ? (widget.activeColor ?? Theme.of(context).primaryColor)
                  : (widget.color ?? Colors.grey),
            ),
      onPressed: _toggleFavorite,
    );
  }
} 