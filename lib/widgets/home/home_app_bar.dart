import 'package:flutter/material.dart';

import '../../core/colors/app_colors.dart';
import '../../core/fonts/app_fonts.dart';
import '../cine_stream_logo.dart';

class HomeAppBar extends StatelessWidget {
  final bool isSearchOpen;
  final VoidCallback onOpenSearch;

  const HomeAppBar({
    super.key,
    required this.isSearchOpen,
    required this.onOpenSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CineStreamLogo(
          fontSize: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: isSearchOpen
              ? Container(
                  height: 36,
                  padding: const .symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.softDarkBlue,
                    borderRadius: .circular(18),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: AppColors.mediumGray,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          style: AppFonts.roboto(
                            color: AppColors.nougat,
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Pesquisar filme',
                            hintStyle: AppFonts.roboto(
                              color: AppColors.transparentNougat60,
                              fontSize: 12,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Align(
                  alignment: .centerRight,
                  child: IconButton(
                    onPressed: onOpenSearch,
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.mediumGray,
                      size: 20,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
