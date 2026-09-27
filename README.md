# Mon Répétiteur 🎓

[![CI/CD Pipeline](https://github.com/Levi20269/Repetiteur_/actions/workflows/ci.yml/badge.svg)](https://github.com/Levi20269/Repetiteur_/actions/workflows/ci.yml)
[![Flutter](https://img.shields.io/badge/Flutter-3.24.x-blue.svg)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Mon Répétiteur** est une application mobile éducative Flutter *production-ready* conçue pour accompagner les élèves du secondaire et du lycée dans leur apprentissage continu, leurs révisions de cours, leurs entraînements par exercices et l'évaluation de leurs compétences.

---

## 🚀 Fonctionnalités Clés

1. **📚 Fiches de Cours Détaillées :**
   - Organisation par matière et chapitre.
   - Objectifs pédagogiques clairs, résumés synthétiques, notions clés et exemples d'application concrets.
2. **✏️ Exercices & QCM Interactifs :**
   - Entraînements ciblés avec sélection ergonomique des réponses.
   - Calcul des scores instantané et sécurisé.
3. **📖 Corrections Détaillées Pas à Pas :**
   - Explications pédagogiques complètes pour comprendre les démarches de résolution.
4. **⏱️ Quiz d’Évaluation :**
   - Évaluations interactives par matière avec score final et récapitulatif détaillé des questions.
5. **📈 Suivi de la Progression & Gamification :**
   - Historique complet, score moyen global, taux de réussite et système de niveaux d'expérience (XP).
6. **🌐 Internationalisation Bilingue (Français & Anglais) :**
   - Prise en charge native du Français (FR) et de l'Anglais (EN) avec bascule instantanée dans le profil.
7. **💾 Cache Local & Mode Hors-ligne :**
   - Persistance locale Hive permettant une utilisation fluide même sans connexion Internet.
8. **♿ Accessibilité (A11y) & Performance :**
   - Balises `Semantics` pour lecteurs d'écran, widgets découpés, utilisation de `const` et listes optimisées (`ListView.builder`).

---

## 🏗️ Architecture du Projet

Le projet suit l'architecture **Feature-First** recommandée par Flutter, garantissant modularité, testabilité et maintenabilité :

```text
lib/
├── core/
│   ├── cache/            # Stockage local et cache Hive (HiveJsonCache & MemoryJsonCache)
│   ├── constants/        # Contenu pédagogique original et données de référence
│   ├── error/            # AppException et gestion unifiée des erreurs
│   ├── localization/     # Gestionnaire i18n AppLocalizations bilingue (FR / EN)
│   ├── network/          # Client Dio avec intercepteur d'authentification et NetworkInfo
│   ├── providers.dart    # Providers Riverpod (Auth, Courses, Exercises, Quiz, Progress, Locale)
│   ├── router/           # Navigation déclarative GoRouter
│   └── widgets/          # Widgets partagés (AsyncErrorView, EmptyView, ScoreBadge, etc.)
│
├── features/
│   ├── auth/             # Authentification (Firebase Auth & DemoAuthRepository)
│   ├── courses/          # Module Cours (modèles, repositories, fiches détaillées)
│   ├── exercises/        # Module Exercices & Corrections détaillées pas à pas
│   ├── profile/          # Profil élève, niveau XP, gestion du cache et sélecteur de langue
│   ├── progress/         # Statistiques de progression et historique d'activité
│   ├── quiz/             # Module d'évaluation interactive et résultats de quiz
│   └── subjects/         # Tableau de bord et catalogue des matières
│
├── l10n/                 # Fichiers de traduction ARB (app_fr.arb, app_en.arb)
└── main.dart             # Point d'entrée de l'application avec configuration du thème Material 3
```

---

## 🛠️ Technologies Utilisées

- **Framework :** Flutter 3.24+ & Dart 3.5+
- **Gestion d'état :** `flutter_riverpod` (v2.6.1)
- **Navigation :** `go_router` (v14.8.1)
- **Stockage Local :** `hive_flutter` (v1.1.0)
- **Réseau :** `dio` (v5.8.0)
- **Backend & Cloud :** Firebase Authentication, Cloud Firestore, Cloud Functions v2 (TypeScript)
- **Tests :** `flutter_test`, `mocktail`
- **CI/CD :** GitHub Actions

---

## 📦 Installation & Lancement

### Prérequis
- Flutter SDK (≥ 3.13.2)
- Dart SDK
- Node.js & Firebase CLI *(uniquement si déploiement Cloud Functions)*

### 1. Cloner le projet
```bash
git clone https://github.com/Levi20269/Repetiteur_.git
cd Repetiteur_
```

### 2. Installer les dépendances
```bash
flutter pub get
```

### 3. Lancer l'application en mode local / démo
```bash
flutter run
```

### 4. Lancer l'application avec le backend Firebase API
```bash
flutter run --dart-define=API_BASE_URL=https://europe-west1-VOTRE_PROJET.cloudfunctions.net/api
```

---

## 🧪 Tests & Qualité du Code

Le projet comporte une suite de **24 tests fonctionnels** :
- **16 tests unitaires :** Repositories, logique métier, calculs de progression, scores et XP.
- **6 tests de widgets :** Fiches de cours, formulaires d'exercices, dashboard, corrections et profil.
- **2 tests d'intégration :** Parcours d'apprentissage complet et parcours de quiz.

### Exécuter les tests :
```bash
flutter test
```

### Analyse statique :
```bash
flutter analyze
```

---

## 🔄 CI/CD & Déploiement

Le fichier `.github/workflows/ci.yml` automatise à chaque `push` et `pull request` :
1. L'installation de l'environnement Flutter.
2. La récupération des dépendances (`flutter pub get`).
3. La vérification du formatage du code (`dart format`).
4. L'analyse statique du code (`flutter analyze`).
5. L'exécution de la suite complète de tests avec couverture (`flutter test`).
6. La compilation de l'APK Android release (`flutter build apk --release`).

---

## 📖 Contenu Pédagogique & Droits d'Auteur

- Les cours, exercices, corrigés et quiz intégrés sont des **créations originales** inspirées des compétences du programme officiel du secondaire/lycée.
- Aucune reproduction intégrale de manuels sous droits (CIAM) n'est présente dans ce dépôt. Les documents de travail privés sont exclus via `.gitignore`.

---

## 📄 Licence

Ce projet est sous licence MIT. Consultez le fichier [LICENSE](LICENSE) pour plus d'informations.
