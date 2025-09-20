import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/buttons/buttons.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/services/user_preferences_service.dart';
import '../../../domain/entities/user_profile.dart';
import '../../pages/guides_home_page.dart';

class ProfileSetupPage extends ConsumerStatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  ConsumerState<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _countryController = TextEditingController();
  final _universityController = TextEditingController();
  final _phoneController = TextEditingController();
  
  UserLevel _selectedLevel = UserLevel.bachelor;
  bool _isLoading = false;

  final List<String> _countries = [
    'Allemagne', 'Belgique', 'Canada', 'Espagne', 'États-Unis',
    'Italie', 'Maroc', 'Portugal', 'Royaume-Uni', 'Suisse',
    'Tunisie', 'Autre'
  ];

  final List<String> _universities = [
    'Université de Paris', 'Sorbonne Université', 'Université de Lyon',
    'Université de Toulouse', 'Université de Lille', 'Université de Bordeaux',
    'Université de Strasbourg', 'Université de Montpellier', 'Autre'
  ];

  @override
  void dispose() {
    _countryController.dispose();
    _universityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authState = ref.read(authNotifierProvider);
      if (authState.hasValue && authState.value != null) {
        final currentProfile = authState.value!;
        
        final updatedProfile = currentProfile.copyWith(
          countryOfOrigin: _countryController.text,
          university: _universityController.text,
          level: _selectedLevel,
          phoneNumber: _phoneController.text.isNotEmpty ? _phoneController.text : null,
          updatedAt: DateTime.now(),
          isFirstTime: false,
        );

        // Sauvegarder dans Firebase
        await ref.read(authNotifierProvider.notifier).updateProfile(updatedProfile);
        
        // Sauvegarder localement
        await UserPreferencesService.saveUserProfile(updatedProfile);

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const GuidesHomePage(),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la sauvegarde: $e'),
            backgroundColor: Colors.red,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuration du profil'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        Icons.person_add,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Complétez votre profil',
                      style: AppTextStyles.headline3,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ces informations nous aideront à personnaliser\nexpérience pour vous',
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Formulaire
              _buildFormField(
                controller: _countryController,
                label: 'Pays d\'origine',
                hint: 'Sélectionnez votre pays d\'origine',
                icon: Icons.public,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner votre pays d\'origine';
                  }
                  return null;
                },
                onTap: () => _showCountryPicker(),
              ),
              
              const SizedBox(height: 20),
              
              _buildFormField(
                controller: _universityController,
                label: 'Université',
                hint: 'Sélectionnez votre université',
                icon: Icons.school,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner votre université';
                  }
                  return null;
                },
                onTap: () => _showUniversityPicker(),
              ),
              
              const SizedBox(height: 20),
              
              // Niveau d'expérience
              Text(
                'Niveau d\'expérience en France',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              
              ...UserLevel.values.map((level) => _buildLevelOption(level)).toList(),
              
              const SizedBox(height: 20),
              
              _buildFormField(
                controller: _phoneController,
                label: 'Numéro de téléphone (optionnel)',
                hint: 'Votre numéro de téléphone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              
              const SizedBox(height: 32),
              
              // Bouton de sauvegarde
              AppButton(
                text: 'Terminer la configuration',
                icon: Icons.check,
                onPressed: _isLoading ? null : _saveProfile,
                isFullWidth: true,
                size: AppButtonSize.large,
                isLoading: _isLoading,
              ),
              
              const SizedBox(height: 16),
              
              // Bouton de passage
              AppButton(
                text: 'Passer cette étape',
                type: AppButtonType.text,
                onPressed: _isLoading ? null : () async {
                  // Sauvegarder un profil minimal
                  final authState = ref.read(authNotifierProvider);
                  if (authState.hasValue && authState.value != null) {
                    final currentProfile = authState.value!;
                    final minimalProfile = currentProfile.copyWith(
                      countryOfOrigin: 'Non spécifié',
                      university: 'Non spécifié',
                      level: UserLevel.bachelor,
                      isFirstTime: false,
                      updatedAt: DateTime.now(),
                    );
                    
                    await ref.read(authNotifierProvider.notifier).updateProfile(minimalProfile);
                    await UserPreferencesService.saveUserProfile(minimalProfile);
                    
                    if (mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const GuidesHomePage(),
                        ),
                      );
                    }
                  }
                },
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    VoidCallback? onTap,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          onTap: onTap,
          keyboardType: keyboardType,
          readOnly: onTap != null,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: onTap != null ? const Icon(Icons.arrow_drop_down) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildLevelOption(UserLevel level) {
    final isSelected = _selectedLevel == level;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedLevel = level;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected 
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected 
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Radio<UserLevel>(
                value: level,
                groupValue: _selectedLevel,
                onChanged: (value) {
                  setState(() {
                    _selectedLevel = value!;
                  });
                },
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.displayName,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isSelected 
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    ),
                    Text(
                      level.description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isSelected 
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Sélectionnez votre pays',
              style: AppTextStyles.headline3,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _countries.length,
                itemBuilder: (context, index) {
                  final country = _countries[index];
                  return ListTile(
                    title: Text(country),
                    onTap: () {
                      _countryController.text = country;
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUniversityPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Sélectionnez votre université',
              style: AppTextStyles.headline3,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  final university = _universities[index];
                  return ListTile(
                    title: Text(university),
                    onTap: () {
                      _universityController.text = university;
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
