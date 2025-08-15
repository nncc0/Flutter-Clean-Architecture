// 📱 Settings Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/l10n/language_cubit.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/settings_cubit.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/theme_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  
  static const String routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocProvider(
      create: (context) => SettingsCubit(
        themeCubit: context.read<ThemeCubit>(),
        languageCubit: context.read<LanguageCubit>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.settings),
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                                _buildSectionTitle(context, l10n.theme),
                _buildThemeOptions(context, state),
                SizedBox(height: 24.h),
                
                                _buildSectionTitle(context, l10n.language),
                _buildLanguageOptions(context, state),
                SizedBox(height: 24.h),
                
                _buildSectionTitle(context, 'About'),
                _buildAboutCard(context),
                SizedBox(height: 24.h),
                // حقل بريد إلكتروني جاهز


// حقل بحث مخصص
CustomTextField(
  hintText: 'البحث...',
),

// حقل متعدد الأسطر مع عداد
CustomTextField(
  labelText: 'الوصف',
  maxLines: 5,
),

// حقل مخصص بالكامل
CustomTextField(
  labelText: 'حقل مخصص',
  validator: (value) => value?.isEmpty == true ? 'مطلوب' : null,
)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

    Widget _buildThemeOptions(BuildContext context, SettingsState state) {
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      child: Column(
        children: [
          RadioListTile<AppTheme>(
            title: Text(l10n.lightTheme),
            value: AppTheme.light,
            groupValue: state.themeMode,
            onChanged: (value) {
              context.read<SettingsCubit>().setTheme(value!);
            },
          ),
          RadioListTile<AppTheme>(
            title: Text(l10n.darkTheme),
            value: AppTheme.dark,
            groupValue: state.themeMode,
            onChanged: (value) {
              context.read<SettingsCubit>().setTheme(value!);
            },
          ),
          RadioListTile<AppTheme>(
            title: Text(l10n.systemTheme),
            value: AppTheme.system,
            groupValue: state.themeMode,
            onChanged: (value) {
              context.read<SettingsCubit>().setTheme(value!);
            },
          ),
        ],
      ),
    );
  }

    Widget _buildLanguageOptions(BuildContext context, SettingsState state) {
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(l10n.english),
            trailing: Radio<String>(
              value: 'en',
              groupValue: state.locale?.languageCode,
              onChanged: (value) {
                context.read<SettingsCubit>().setLanguage(value!);
              },
            ),
            onTap: () {
              context.read<SettingsCubit>().setLanguage('en');
            },
          ),
          ListTile(
            title: Text(l10n.arabic),
            trailing: Radio<String>(
              value: 'ar',
              groupValue: state.locale?.languageCode,
              onChanged: (value) {
                context.read<SettingsCubit>().setLanguage(value!);
              },
            ),
            onTap: () {
              context.read<SettingsCubit>().setLanguage('ar');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Card(
      child: ListTile(
        title: Text(l10n.appName),
        subtitle: Text('Version 1.0.0'),
        trailing: Icon(Icons.info_outline),
      ),
    );
  }
}
