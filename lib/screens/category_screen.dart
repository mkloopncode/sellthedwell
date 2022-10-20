import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/models/category_model.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:sellthedwell/utils/styles.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:sellthedwell/widgets/custom_appbar.dart';
import 'package:sellthedwell/widgets/drawer.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<CategoryModel> categories = [];
  bool _isLoading = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Image.asset(
          Konstants.logoPath,
          height: 32,
        ),
        isBackShown: false,
      ),
      drawer: const DrawerMenu(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.categories,
              style: TextStyles.bigTitle,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressWidget())
                  : categories.isEmpty
                      ? Center(
                          child: Text(Strings.noData),
                        )
                      : ListView.separated(
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                final auth = Provider.of<AuthProvider>(context,
                                    listen: false);
                                auth.setNavBarIndex(0);
                                auth.setCategory(categories[index].name);
                              },
                              child: CategoryItem(
                                cat: categories[index],
                              ),
                            );
                          },
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: categories.length,
                          separatorBuilder: (_, __) => const Divider(
                            thickness: 1,
                            height: 24,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  void _getCategories() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final list = await NetworkService.getCategories();
      categories.clear();
      categories.addAll(list);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      toast(e.toString());
    }
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel cat;
  const CategoryItem({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.home,
                      color: ColorUtils.primaryLight,
                      size: 16,
                    ),
                    Text(
                      "${cat.name}",
                      style: TextStyles.heading1,
                    ),
                    Text(
                      "${cat.count} Properties",
                      style: TextStyles.labelTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            CachedNetworkImage(
              imageUrl: cat.image ?? Konstants.defaultHousePic,
              height: 64,
              width: 64,
              fit: BoxFit.cover,
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              errorWidget: (_, __, ___) => CachedNetworkImage(
                imageUrl: Konstants.defaultHousePic,
                height: 64,
                width: 64,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
