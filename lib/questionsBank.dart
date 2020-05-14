import 'dart:math';
import 'package:quizzler/question.dart';

class QuestionsBank {
  List<Question> _questions = [];
  int _questionNumber;

  QuestionsBank() {
    _questions.add(
        new Question('Sound travels faster through water than air.', true));
    _questions
        .add(new Question('An electron carries a positive charge.', false));
    _questions
        .add(new Question('K is the chemical symbol for krypton. ', false));
    _questions.add(new Question(
        'The primary source of energy for the Earth’s ecosystem is the sun.',
        true));
    _questions.add(
        new Question('There are more than 200 bones in the human body.', true));
    _questions.add(new Question(
        'The higher the ph level of a substance, the more acidic it is.',
        false));
    _questions.add(new Question(
        'Particles are packed tighter in solids than they are in liquids.',
        true));
    _questions.add(new Question('Jupiter has only one moon.', false));
    _questions.add(new Question(
        'Seventy degrees Fahrenheit is hotter than 70 degrees Celsius.',
        false));
    _questions
        .add(new Question('A magnet has 2 poles: north and south.', true));
    _questions.add(
        new Question('Hydrogen is the lightest of all known elements.', true));
    _questions.add(new Question(
        'The Three Laws of Motion were created by Isaac Newton. ', true));
    _questions.add(new Question('Our fingernails are made of enamel. ', false));
    _questions.add(new Question(
        'It takes the moon 30 days to make a full revolution around the earth.',
        false));
    _questions.add(new Question(
        'Your ears play an important role in keeping you balanced.', true));
    _questions.add(new Question(
        'When you mix oil and water, oil sinks because it is heavier.', false));
    _questions.add(new Question(
        'Volume is a measure of how much surface an object has.', false));
    _questions.add(new Question(
        'In the visible light spectrum, the color red has the longest wavelength.',
        true));
    _questions.add(new Question(
        'Water consists of two parts oxygen and one part hydrogen.', false));
    _questions.add(new Question(
        'An object that has kinetic energy must be in motion.', true));
    _questions.add(new Question('Some fish communicate by farting.', true));
    _questions.add(new Question(
        'Your hair and fingernails continue to grow after death.', false));
    _questions.add(new Question(
        'Woolly mammoths existed at the same time the Giza pyramids were built.',
        true));
    _questions.add(new Question('Electrons are larger than molecules.', false));
    _questions.add(new Question(
        'The Atlantic Ocean is the biggest ocean on Earth.', false));
    _questions.add(new Question(
        'The chemical make up food often changes when you cook it.', true));
    _questions.add(new Question('Sharks are mammals.', false));
    _questions.add(new Question('The human body has four lungs.', false));
    _questions.add(new Question(
        'Atoms are most stable when their outer shells are full.', false));
    _questions.add(new Question(
        'Filtration separates mixtures based upon their particle size.', true));
    _questions
        .add(new Question('Venus is the closest planet to the Sun.', false));
    _questions.add(new Question('Conductors have low resistance.', true));
    _questions.add(new Question(
        'Molecules can have atoms from more than one chemical element.', true));
    _questions
        .add(new Question('Water is an example of a chemical element.', false));
    _questions
        .add(new Question('The study of plants is known as botany.', true));
    _questions.add(new Question(
        'Mount Kilimanjaro is the tallest mountain in the world.', false));
    _questions.add(
        new Question('Floatation separates mixtures based on density.', true));
    _questions.add(new Question('Herbivores eat meat.', false));
    _questions.add(new Question('Atomic bombs work by atomic fission.', true));
    _questions.add(new Question('Molecules are chemically bonded.', true));
    _questions.add(new Question('Spiders have six legs.', false));
    _questions.add(new Question('Kelvin is a measure of temperature.', true));
    _questions.add(new Question(
        'The human skeleton is made up of less than 100 bones.', false));
    _questions.add(new Question(
        'You can lead a cow down stairs but not up stairs.', false));
    _questions.add(new Question(
        'Approximately one quarter of human bones are in the feet.', true));
    _questions.add(new Question('A slug\'s blood is green.', true));
  }

  void nextQuestion() {
    _questionNumber = Random().nextInt(_questions.length);
  }

  String getQuestionText() => _questions[_questionNumber].questionText;
  bool getQuestionAnswer() => _questions[_questionNumber].questionAnswer;
}
