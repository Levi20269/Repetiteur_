import '../../features/exercises/domain/exercise.dart';
import '../../features/subjects/domain/subject.dart';

class DemoData {
  static const List<Subject> subjects = [
    Subject(
      id: 'maths',
      name: 'Mathématiques',
      description: 'Calcul, algèbre, géométrie et raisonnement logique.',
      icon: 'calculate',
    ),
    Subject(
      id: 'francais',
      name: 'Français',
      description: 'Grammaire, conjugaison, orthographe et compréhension.',
      icon: 'menu_book',
    ),
    Subject(
      id: 'sciences',
      name: 'Sciences & SVT',
      description: 'Biologie, physique-chimie, environnement et astronomie.',
      icon: 'science',
    ),
    Subject(
      id: 'histoire_geo',
      name: 'Histoire & Géographie',
      description: 'Grandes époques historiques, cartes et repères géographiques.',
      icon: 'public',
    ),
    Subject(
      id: 'anglais',
      name: 'Anglais',
      description: 'Vocabulaire, expressions courantes et structures grammaticales.',
      icon: 'translate',
    ),
  ];

  static const List<Exercise> exercises = [
    // Mathématiques
    Exercise(
      id: 'math-1',
      subjectId: 'maths',
      question: 'Quel est le résultat de 7 × 8 ?',
      answers: ['48', '54', '56', '64'],
      correctAnswer: '56',
      explanation: '7 × 8 = 56. (Astuce : 7 × 7 = 49, et 49 + 7 = 56).',
    ),
    Exercise(
      id: 'math-2',
      subjectId: 'maths',
      question: 'Si un rectangle a une longueur de 8 cm et une largeur de 3 cm, quelle est son aire ?',
      answers: ['22 cm²', '24 cm²', '11 cm²', '26 cm²'],
      correctAnswer: '24 cm²',
      explanation: "L'aire d'un rectangle se calcule par Longueur × Largeur = 8 × 3 = 24 cm².",
    ),
    Exercise(
      id: 'math-3',
      subjectId: 'maths',
      question: 'Quelle est la racine carrée de 144 ?',
      answers: ['11', '12', '13', '14'],
      correctAnswer: '12',
      explanation: '12 × 12 = 144, donc √144 = 12.',
    ),
    Exercise(
      id: 'math-4',
      subjectId: 'maths',
      question: 'Combien font 3/4 + 1/2 ?',
      answers: ['4/6', '5/4', '1', '4/4'],
      correctAnswer: '5/4',
      explanation: 'Pour additionner ces fractions, on met au même dénominateur : 1/2 = 2/4. Alors 3/4 + 2/4 = 5/4.',
    ),

    // Français
    Exercise(
      id: 'fr-1',
      subjectId: 'francais',
      question: "Dans la phrase « Les oiseaux chantent dans les arbres », quel est le sujet du verbe « chantent » ?",
      answers: ['les arbres', 'dans', 'Les oiseaux', 'chantent'],
      correctAnswer: 'Les oiseaux',
      explanation: 'Qui est-ce qui chante ? « Les oiseaux ». C’est donc le groupe nominal sujet.',
    ),
    Exercise(
      id: 'fr-2',
      subjectId: 'francais',
      question: 'Quel est le participe passé du verbe « résoudre » ?',
      answers: ['résolu', 'résolvé', 'résout', 'résolué'],
      correctAnswer: 'résolu',
      explanation: 'Le participe passé de « résoudre » est « résolu » (ex: le problème est résolu).',
    ),
    Exercise(
      id: 'fr-3',
      subjectId: 'francais',
      question: 'Laquelle de ces phrases est correctement orthographiée ?',
      answers: [
        'Elles se sont lavé les mains.',
        'Elles se sont lavées les mains.',
        'Elles se sont lavés les mains.',
        'Elles se sont laver les mains.'
      ],
      correctAnswer: 'Elles se sont lavé les mains.',
      explanation: 'Le verbe pronominal a un COD (« les mains ») placé après le verbe : le participe passé reste donc invariable.',
    ),

    // Sciences
    Exercise(
      id: 'sci-1',
      subjectId: 'sciences',
      question: 'Quelle est la formule chimique de l’eau ?',
      answers: ['CO2', 'NaCl', 'H2O', 'O2'],
      correctAnswer: 'H2O',
      explanation: 'Une molécule d’eau est composée de 2 atomes d’hydrogène et de 1 atome d’oxygène (H2O).',
    ),
    Exercise(
      id: 'sci-2',
      subjectId: 'sciences',
      question: 'Quel organe humain est principalement responsable de la filtration du sang ?',
      answers: ['Les poumons', 'L’estomac', 'Les reins', 'Le pancréas'],
      correctAnswer: 'Les reins',
      explanation: 'Les reins filtrent les déchets et l’excès d’eau du sang pour former l’urine.',
    ),
    Exercise(
      id: 'sci-3',
      subjectId: 'sciences',
      question: 'Parmi ces planètes, laquelle est la plus proche du Soleil ?',
      answers: ['Vénus', 'Mars', 'Mercure', 'Terre'],
      correctAnswer: 'Mercure',
      explanation: 'L’ordre des planètes depuis le Soleil est : Mercure, Vénus, Terre, Mars, Jupiter, Saturne, Uranus, Neptune.',
    ),

    // Histoire & Géographie
    Exercise(
      id: 'hg-1',
      subjectId: 'histoire_geo',
      question: 'En quelle année a débuté la Révolution française ?',
      answers: ['1789', '1792', '1804', '1776'],
      correctAnswer: '1789',
      explanation: 'La Révolution française a commencé en 1789 avec la convocation des États généraux et la prise de la Bastille (14 juillet).',
    ),
    Exercise(
      id: 'hg-2',
      subjectId: 'histoire_geo',
      question: 'Quel est le plus long fleuve du monde ?',
      answers: ['L’Amazone', 'Le Nil', 'Le Yangzi Jiang', 'Le Mississippi'],
      correctAnswer: 'L’Amazone',
      explanation: 'L’Amazone (en Amérique du Sud) est reconnu comme le fleuve le plus long et au plus grand débit au monde.',
    ),

    // Anglais
    Exercise(
      id: 'ang-1',
      subjectId: 'anglais',
      question: 'Quelle est la forme passée (Past Simple) du verbe irrégulier « to go » ?',
      answers: ['goed', 'gone', 'went', 'going'],
      correctAnswer: 'went',
      explanation: 'Le verbe « to go » est irrégulier : go -> went -> gone.',
    ),
    Exercise(
      id: 'ang-2',
      subjectId: 'anglais',
      question: 'Complétez la phrase : « She ___ English very well. »',
      answers: ['speak', 'speaks', 'speaking', 'is speak'],
      correctAnswer: 'speaks',
      explanation: 'À la 3ème personne du singulier au présent simple (she/he/it), on ajoute un « s » au verbe.',
    ),
  ];
}

