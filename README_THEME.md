# Thème et Widgets - Démarches App

## 🎨 Thème Français

L'application utilise un thème inspiré des couleurs du drapeau français :

### Couleurs principales
- **Bleu français** : `#002395` - Couleur principale
- **Blanc français** : `#FFFFFF` - Couleur de surface
- **Rouge français** : `#ED2939` - Couleur secondaire

### Couleurs supplémentaires
- **Bleu clair** : `#E3F2FD` - Arrière-plans subtils
- **Bleu foncé** : `#001A5C` - Variante sombre
- **Rouge clair** : `#FFEBEE` - Arrière-plans d'erreur
- **Rouge foncé** : `#B71C1C` - Variante sombre
- **Gris clair** : `#F5F5F5` - Arrière-plan principal
- **Gris moyen** : `#9E9E9E` - Texte secondaire
- **Gris foncé** : `#424242` - Texte principal

## 📝 Styles de texte

### Headlines
- `headline1` : 32px, bold, bleu français
- `headline2` : 28px, bold, bleu français
- `headline3` : 24px, semi-bold, bleu français

### Titres
- `sectionTitle` : 20px, semi-bold, gris foncé
- `cardTitle` : 18px, semi-bold, gris foncé

### Corps de texte
- `bodyLarge` : 16px, normal, gris foncé
- `bodyMedium` : 14px, normal, gris foncé
- `bodySmall` : 12px, normal, gris moyen

### Labels et boutons
- `buttonLarge` : 16px, semi-bold, blanc
- `buttonMedium` : 14px, semi-bold, blanc
- `buttonSmall` : 12px, semi-bold, blanc

### Textes spéciaux
- `errorText` : 12px, normal, rouge français
- `successText` : 12px, normal, vert
- `warningText` : 12px, normal, orange
- `infoText` : 12px, normal, bleu

### Textes de statut
- `statusPending` : 12px, medium, orange
- `statusInProgress` : 12px, medium, bleu
- `statusCompleted` : 12px, medium, vert
- `statusCancelled` : 12px, medium, gris

## 🔘 Widgets de boutons

### AppButton
Bouton principal avec plusieurs variantes :

```dart
AppButton(
  text: 'Mon bouton',
  onPressed: () {},
  type: AppButtonType.primary, // primary, secondary, outline, text, danger
  size: AppButtonSize.medium,  // small, medium, large
  icon: Icons.add,
  isLoading: false,
  isFullWidth: false,
)
```

### AppIconButton
Bouton d'icône uniquement :

```dart
AppIconButton(
  icon: Icons.favorite,
  onPressed: () {},
  type: AppIconButtonType.primary, // primary, secondary, outline, text, danger
  size: AppIconButtonSize.medium,  // small, medium, large
  tooltip: 'Favoris',
  isLoading: false,
)
```

### AppFab
Bouton flottant :

```dart
AppFab(
  onPressed: () {},
  type: AppFabType.primary, // primary, secondary, extended
  icon: Icons.add,
  label: 'Ajouter', // Pour le type extended
  isLoading: false,
)
```

## 🌙 Mode sombre

L'application supporte le mode sombre avec des couleurs adaptées :
- Arrière-plan principal : Bleu foncé français
- Surface : Gris foncé
- Texte : Blanc
- Accents : Bleu clair et rouge clair

## 📱 Utilisation

### Importer le thème
```dart
import 'core/theme/app_theme.dart';

MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system,
  // ...
)
```

### Importer les styles de texte
```dart
import 'core/theme/app_text_styles.dart';

Text(
  'Mon texte',
  style: AppTextStyles.headline2,
)
```

### Importer les widgets de boutons
```dart
import 'presentation/widgets/buttons/buttons.dart';

AppButton(
  text: 'Mon bouton',
  onPressed: () {},
)
```

## 🎯 Bonnes pratiques

1. **Cohérence** : Utilisez toujours les styles prédéfinis
2. **Accessibilité** : Les couleurs respectent les contrastes recommandés
3. **Responsive** : Les widgets s'adaptent aux différentes tailles d'écran
4. **Thème** : Le mode sombre est automatiquement appliqué selon les préférences système
5. **Réutilisabilité** : Tous les widgets sont conçus pour être réutilisables

## 🔧 Personnalisation

Pour personnaliser le thème, modifiez les fichiers :
- `lib/core/theme/app_theme.dart` - Couleurs et thème principal
- `lib/core/theme/app_text_styles.dart` - Styles de texte
- `lib/presentation/widgets/buttons/` - Widgets de boutons
