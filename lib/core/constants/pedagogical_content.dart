import '../../features/courses/domain/course.dart';
import '../../features/exercises/domain/exercise.dart';
import '../../features/quiz/domain/quiz.dart';
import '../../features/subjects/domain/subject.dart';

class PedagogicalContent {
  static const List<Subject> subjects = [
    Subject(
      id: 'maths',
      name: 'Mathématiques',
      description: 'Analyse, algèbre, géométrie et probabilités.',
      icon: 'calculate',
    ),
    Subject(
      id: 'francais',
      name: 'Français & Littérature',
      description: 'Grammaire, analyse textuelle, syntaxe et figures de style.',
      icon: 'menu_book',
    ),
    Subject(
      id: 'sciences',
      name: 'Sciences & SVT',
      description: 'Génétique, immunologie, géologie et écologie.',
      icon: 'science',
    ),
    Subject(
      id: 'histoire_geo',
      name: 'Histoire & Géographie',
      description: 'Relations internationales, mondialisation et géopolitique.',
      icon: 'public',
    ),
    Subject(
      id: 'anglais',
      name: 'Anglais',
      description: 'Grammaire anglaise, expression écrite et vocabulaire.',
      icon: 'translate',
    ),
  ];

  static const List<Course> courses = [
    Course(
      id: 'course-math-1',
      subjectId: 'maths',
      title: 'Limites et Continuité',
      chapter: 'Chapitre 1 : Analyse réelle',
      level: 'Terminale Scientifique',
      objectives: [
        'Comprendre la notion intuitive et formelle de limite.',
        'Lever les formes indéterminées usuelles (0/0, ∞/∞, 0×∞, +∞-∞).',
        'Appliquer le théorème des valeurs intermédiaires (TVI).',
      ],
      summary:
          'La continuité d’une fonction en un point a signifie que la limite de f(x) quand x tend vers a est égale à f(a). Le théorème des valeurs intermédiaires garantit que toute fonction continue sur un intervalle [a, b] prend toutes les valeurs comprises entre f(a) et f(b).',
      keyConcepts: [
        'Continuité : lim(x->a) f(x) = f(a)',
        'Formes indéterminées : 0/0, ∞/∞, +∞-∞, 0×∞',
        'Théorème de bijection : si f est continue et strictement monotone sur [a, b], pour tout k entre f(a) et f(b), l\'équation f(x)=k admet une unique solution.',
      ],
      examples: [
        'Exemple 1 : lim(x->+∞) (2x² + 3)/(x² - 1) = lim(x->+∞) 2x²/x² = 2.',
        'Exemple 2 : Pour f(x) = x³ + x - 1 sur [0, 1], f(0) = -1 < 0 et f(1) = 1 > 0. Comme f est continue et strictement croissante, f(x)=0 admet une unique solution sur [0, 1].',
      ],
      associatedExerciseIds: ['math-1', 'math-2'],
    ),
    Course(
      id: 'course-math-2',
      subjectId: 'maths',
      title: 'Dérivation et Fonctions Exponentielles',
      chapter: 'Chapitre 2 : Fonctions transcendantes',
      level: 'Terminale Scientifique',
      objectives: [
        'Calculer la dérivée de fonctions composées.',
        'Étudier le sens de variation et les extremums d\'une fonction.',
        'Manipuler les propriétés fondamentales de la fonction exponentielle.',
      ],
      summary:
          'La fonction exponentielle notée exp ou x -> e^x est l\'unique fonction dérivable sur R égale à sa propre dérivée telle que exp(0) = 1. Elle est strictement positive et strictement croissante sur R.',
      keyConcepts: [
        '(e^u)\' = u\' × e^u',
        'e^(a+b) = e^a × e^b et e^(-a) = 1/e^a',
        'Croissances comparées : lim(x->+∞) e^x / x^n = +∞',
      ],
      examples: [
        'Exemple : Dérivée de f(x) = e^(3x² + 1) -> f\'(x) = 6x e^(3x² + 1).',
      ],
      associatedExerciseIds: ['math-3', 'math-4'],
    ),
    Course(
      id: 'course-fr-1',
      subjectId: 'francais',
      title: 'L’accord du participe passé',
      chapter: 'Grammaire et Orthographe avancée',
      level: 'Lycée',
      objectives: [
        'Maîtriser l\'accord avec l\'auxiliaire être et avoir.',
        'Identifier la place du Complément d\'Objet Direct (COD).',
        'Résoudre les cas particuliers des verbes pronominaux.',
      ],
      summary:
          'Avec l\'auxiliaire être, le participe passé s\'accorde toujours avec le sujet. Avec l\'auxiliaire avoir, il s\'accorde uniquement avec le COD si celui-ci est placé AVANT le verbe.',
      keyConcepts: [
        'Auxiliaire être : accord avec le sujet (ex: Elles sont parties).',
        'Auxiliaire avoir : accord avec le COD s\'il précède le verbe (ex: Les fleurs que j\'ai cueillies).',
        'Verbes pronominaux : accord avec le COD antéposé (ex: Elles se sont lavé les mains -> COD après -> pas d\'accord).',
      ],
      examples: [
        '« La lettre que j\'ai écrite » -> COD « que » (mis pour la lettre) placé avant -> accord au féminin singulier.',
      ],
      associatedExerciseIds: ['fr-1', 'fr-2', 'fr-3'],
    ),
    Course(
      id: 'course-sci-1',
      subjectId: 'sciences',
      title: 'Génétique et Brassage Chromosomique',
      chapter: 'Chapitre 1 : Transmission du patrimoine génétique',
      level: 'Terminale',
      objectives: [
        'Distinguer le brassage interchromosomique et intrachromosomique.',
        'Expliquer le mécanisme du crossing-over en méiose.',
      ],
      summary:
          'La reproduction sexuée assure la diversité génétique des individus grâce aux brassages chromosomiques lors de la méiose (prophase I et anaphase I) et à la fécondation qui associe au hasard deux gamètes uniques.',
      keyConcepts: [
        'Méiose : succession de deux divisions cellulaires réduisant le nombre de chromosomes de 2n à n.',
        'Brassage intrachromosomique : crossing-over en prophase I entre chromatides non-sœurs.',
        'Brassage interchromosomique : séparation aléatoire des paires en anaphase I.',
      ],
      examples: [
        'Chez l\'être humain (2n = 46), le brassage interchromosomique seul génère 2^23 combinaisons de gamètes possibles.',
      ],
      associatedExerciseIds: ['sci-1', 'sci-2', 'sci-3'],
    ),
  ];

  static const List<Exercise> exercises = [
    Exercise(
      id: 'math-1',
      subjectId: 'maths',
      question: 'Quelle est la limite quand x tend vers +∞ de f(x) = (3x² - 5)/(x² + 2) ?',
      answers: ['0', '3', '+∞', '5'],
      correctAnswer: '3',
      explanation:
          'Pour une fonction rationnelle en +∞, la limite est égale au quotient des termes de plus haut degré : lim (3x²/x²) = 3.',
    ),
    Exercise(
      id: 'math-2',
      subjectId: 'maths',
      question: 'Si f est continue et strictement croissante sur [1, 4] avec f(1) = -2 et f(4) = 5, combien de solutions possède l\'équation f(x) = 0 sur cet intervalle ?',
      answers: ['0 solution', 'Exactement 1 solution', '2 solutions', 'Une infinité'],
      correctAnswer: 'Exactement 1 solution',
      explanation:
          'D\'après le corollaire du Théorème des Valeurs Intermédiaires (théorème de la bijection), comme 0 est strictement compris entre f(1)=-2 et f(4)=5 et que f est continue et strictement monotone, il existe une unique solution.',
    ),
    Exercise(
      id: 'math-3',
      subjectId: 'maths',
      question: 'Quelle est la dérivée de la fonction f(x) = e^(2x + 1) ?',
      answers: ['e^(2x + 1)', '2 e^(2x + 1)', '(2x + 1) e^(2x)', '2x e^(2x + 1)'],
      correctAnswer: '2 e^(2x + 1)',
      explanation:
          'La formule de dérivation d\'une fonction composée (e^u)\' est u\' × e^u. Ici u(x) = 2x + 1 donc u\'(x) = 2. Ainsi f\'(x) = 2 e^(2x + 1).',
    ),
    Exercise(
      id: 'math-4',
      subjectId: 'maths',
      question: 'Pour tout réel x, simplifiez l\'expression E = (e^x)² × e^(-x).',
      answers: ['e^(2x)', 'e^x', 'e^0', '1'],
      correctAnswer: 'e^x',
      explanation:
          '(e^x)² = e^(2x). Donc E = e^(2x) × e^(-x) = e^(2x - x) = e^x.',
    ),
    Exercise(
      id: 'fr-1',
      subjectId: 'francais',
      question: 'Quelle est la phrase correctement accordée ?',
      answers: [
        'Les erreurs qu\'il a commis sont graves.',
        'Les erreurs qu\'il a commises sont graves.',
        'Les erreurs qu\'il a commit sont graves.',
        'Les erreurs qu\'il a commise sont graves.'
      ],
      correctAnswer: 'Les erreurs qu\'il a commises sont graves.',
      explanation:
          'Le COD « qu\' » (qui remplace « les erreurs », féminin pluriel) est placé avant l\'auxiliaire avoir. Le participe passé s\'accorde donc au féminin pluriel : « commises ».',
    ),
    Exercise(
      id: 'fr-2',
      subjectId: 'francais',
      question: 'Dans la phrase « Elles se sont téléphoné », pourquoi « téléphoné » est-il invariable ?',
      answers: [
        'Parce que le verbe est toujours invariable.',
        'Parce que téléphoner est intransitif direct.',
        'Parce que le pronom « se » est un COI (téléphoner À quelqu\'un).',
        'Parce qu\'il y a l\'auxiliaire être.'
      ],
      correctAnswer: 'Parce que le pronom « se » est un COI (téléphoner À quelqu\'un).',
      explanation:
          'On dit « téléphoner À quelqu\'un ». Le pronom « se » est donc un Complément d\'Objet Indirect (COI). Avec un verbe pronominal sans COD antéposé, le participe ne s\'accorde pas.',
    ),
    Exercise(
      id: 'fr-3',
      subjectId: 'francais',
      question: 'Quel est le mode verbal exprimant le doute, le souhait ou l\'obligation ?',
      answers: ['L\'indicatif', 'Le subjonctif', 'Le conditionnel', 'L\'impératif'],
      correctAnswer: 'Le subjonctif',
      explanation:
          'Le subjonctif est le mode de l\'irréel, de l\'incertitude, du souhait et des actions envisagées dans la pensée mais non encore réalisées.',
    ),
    Exercise(
      id: 'sci-1',
      subjectId: 'sciences',
      question: 'À quel stade de la méiose se produit le brassage intrachromosomique (crossing-over) ?',
      answers: ['Prophase I', 'Métaphase II', 'Anaphase I', 'Télophase II'],
      correctAnswer: 'Prophase I',
      explanation:
          'Le crossing-over (échange de portions de chromatides non-sœurs entre chromosomes homologues appariés) se déroule spécifiquement en Prophase I de méiose.',
    ),
    Exercise(
      id: 'sci-2',
      subjectId: 'sciences',
      question: 'Quelle molécule constitue le support universel de l\'information génétique chez tous les êtres vivants ?',
      answers: ['L\'ARN messager', 'L\'ADN', 'Les protéines', 'Les lipides'],
      correctAnswer: 'L\'ADN',
      explanation:
          'L\'Acide Désoxyribonucléique (ADN) en double hélice contient le code génétique universel sous forme de séquences nucléotidiques (A, T, C, G).',
    ),
    Exercise(
      id: 'sci-3',
      subjectId: 'sciences',
      question: 'Quelle est la réaction globale de la photosynthèse chez les végétaux chlorophylliens ?',
      answers: [
        '6 CO2 + 6 H2O + lumière -> C6H12O6 + 6 O2',
        'C6H12O6 + 6 O2 -> 6 CO2 + 6 H2O + énergie',
        'CO2 + O2 -> 2 CO',
        '2 H2O -> 2 H2 + O2'
      ],
      correctAnswer: '6 CO2 + 6 H2O + lumière -> C6H12O6 + 6 O2',
      explanation:
          'La photosynthèse convertit l\'énergie lumineuse en énergie chimique pour produire du glucose (C6H12O6) et rejette de l\'oxygène (O2) à partir d\'eau et de dioxyde de carbone.',
    ),
  ];

  static const List<Quiz> quizzes = [
    Quiz(
      id: 'quiz-maths',
      title: 'Grand Quiz : Analyse & Fonctions',
      subjectId: 'maths',
      exerciseIds: ['math-1', 'math-2', 'math-3', 'math-4'],
      durationMinutes: 5,
    ),
    Quiz(
      id: 'quiz-fr',
      title: 'Quiz Express : Orthographe & Syntaxe',
      subjectId: 'francais',
      exerciseIds: ['fr-1', 'fr-2', 'fr-3'],
      durationMinutes: 3,
    ),
    Quiz(
      id: 'quiz-sci',
      title: 'Quiz SVT : Génétique & Biologie',
      subjectId: 'sciences',
      exerciseIds: ['sci-1', 'sci-2', 'sci-3'],
      durationMinutes: 4,
    ),
  ];
}
