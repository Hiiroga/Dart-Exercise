import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundWhite,
      elevation: AppDimensions.elevationSmall,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        color: AppColors.textBlue,
                        fontSize: AppDimensions.fontSizeLarge,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.marginSmall),
              Text(
                'Rp ${product.price}',
                style: const TextStyle(
                  fontSize: AppDimensions.fontSizeMedium,
                  color: AppColors.textGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (product.description != null &&
                  product.description!.isNotEmpty) ...[
                const SizedBox(height: AppDimensions.marginSmall),
                Text(
                  product.description!,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSizeSmall,
                    color: AppColors.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
