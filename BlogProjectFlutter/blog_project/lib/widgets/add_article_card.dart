import 'package:flutter/material.dart';
import 'package:blog_project/widgets/upload_field.dart';

class AddArticleCard extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final String? selectedFileName;
  final VoidCallback onFileSelect;
  final VoidCallback onAddArticle;
  final bool isLoading;

  const AddArticleCard({
    Key? key,
    required this.titleController,
    required this.contentController,
    this.selectedFileName,
    required this.onFileSelect,
    required this.onAddArticle,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(
                  Icons.add_circle,
                  color: Color(0xFF1976D2),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Ajouter un article',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Title field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Titre',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Ex: Les tendances du design 2024',
                    hintStyle: const TextStyle(
                      color: Color(0xFFCCCCCC),
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF1976D2),
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF333333),
                  ),
                  cursorColor: const Color(0xFF1976D2),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Upload field
            UploadField(
              fileName: selectedFileName,
              onUploadTap: () {},
              onFileSelect: onFileSelect,
            ),

            const SizedBox(height: 20),

            // Content field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contenu',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: contentController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Écrivez votre article ici...',
                    hintStyle: const TextStyle(
                      color: Color(0xFFCCCCCC),
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF1976D2),
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF333333),
                  ),
                  cursorColor: const Color(0xFF1976D2),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Add button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : onAddArticle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: const Color(0x401976D2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.send, size: 20),
                          SizedBox(width: 8),
                          Text('Ajouter l\'article'),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
