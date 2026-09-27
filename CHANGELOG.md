# Changelog

Toutes les modifications notables apportées à ce projet sont documentées dans ce fichier.

## [1.2.0] - 2026-09-27
### Ajouté
- **Module Cours (Courses) :** Liste des cours par matière et fiches de cours détaillées (objectifs, résumés pédagogiques, notions importantes, exemples d'application).
- **Module Corrections détaillées :** Vue dédiée aux corrections pas à pas avec démarches pédagogiques structurées.
- **Module Quiz :** Mode d'évaluation interactive chronométré avec récapitulatif des réponses et score final.
- **Internationalisation (i18n) bilingue :** Support complet du Français (FR) et de l'Anglais (EN) avec sélecteur de langue dynamique dans le profil.
- **Accessibilité (A11y) :** Ajout de balises `Semantics` sur les boutons, formulaires et éléments interactifs.
- **Suite de tests complète (24 tests) :**
  - 16 tests unitaires (repositories, logique métier, calculs de progression, scores, XP).
  - 6 tests de widgets (Dashboard, cours, exercices, corrections, profil).
  - 2 tests d'intégration (parcours d'apprentissage et parcours d'évaluation).
- **CI/CD :** Pipeline GitHub Actions (`.github/workflows/ci.yml`) automatisant l'analyse statique et les tests.

## [1.1.0] - 2026-09-06
### Ajouté
- **Exercices & QCM interactifs :** Sélection visuelle fluide et sécurisée des choix de réponse.
- **Calcul sécurisé des scores :** Évaluation des réponses côté serveur (Cloud Functions) et mode simulateur en local.
- **Cache hors-ligne Hive :** Sauvegarde locale des matières, exercices et progressions avec fonctionnement autonome.
- **Tableau de bord :** Salutation personnalisée, badges de réussite et suivi des scores.

## [1.0.0] - 2026-09-01
### Ajouté
- Initialisation du projet Flutter avec architecture Feature-First (`domain`, `data`, `presentation`).
- Gestion d'état avec `flutter_riverpod` et routage déclaratif avec `go_router`.
- Module d'authentification et gestion du profil utilisateur.
- Backend Cloud Functions v2 en TypeScript et règles de sécurité Firestore.
