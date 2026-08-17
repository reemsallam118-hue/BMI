
import 'package:flutter/material.dart';
enum Gender { male, female }
class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});
  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();}
class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  static const Color bgColor = Color(0xFF0D0D1A);
  static const Color cardColor = Color(0xFF1B1B2F);
  static const Color accentPink = Color(0xFFE8195A);
  static const Color mutedText = Color(0xFF8C8CA1);
  Gender _selectedGender = Gender.male;
  double _height = 174; // cm
  int _weight = 60; // kg
  int _age = 29;
  double? _bmiResult;
  String _bmiCategory = '';
  void _selectGender(Gender gender) {
    setState(() => _selectedGender = gender);}
  void _incrementWeight() => setState(() => _weight++);
  void _decrementWeight() {
    if (_weight > 1) setState(() => _weight--);}
  void _incrementAge() => setState(() => _age++);
  void _decrementAge() {
    if (_age > 1) setState(() => _age--);}
  void _calculateBmi() {
    final heightInMeters = _height / 100;
    final bmi = _weight / (heightInMeters * heightInMeters);
    setState(() {
      _bmiResult = bmi;
      _bmiCategory = _categoryFor(bmi);});}
  String _categoryFor(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'BMI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,),),
              const SizedBox(height: 20),
              _buildGenderRow(),
              const SizedBox(height: 16),
              _buildHeightCard(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildCounterCard(
                      label: 'WEIGHT',
                      value: _weight,
                      onIncrement: _incrementWeight,
                      onDecrement: _decrementWeight,),),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCounterCard(
                      label: 'AGE',
                      value: _age,
                      onIncrement: _incrementAge,
                      onDecrement: _decrementAge,),),],),
              if (_bmiResult != null) ...[
                const SizedBox(height: 16),
                _buildResultCard(),],
              const Spacer(),
              _buildCalculateButton(),],),),),);}
  Widget _buildGenderRow() {
    return Row(
      children: [
        Expanded(
          child: _GenderCard(
            icon: Icons.male,
            label: 'MALE',
            isSelected: _selectedGender == Gender.male,
            cardColor: cardColor,
            accentColor: accentPink,
            mutedText: mutedText,
            onTap: () => _selectGender(Gender.male),),),
        const SizedBox(width: 16),
        Expanded(
          child: _GenderCard(
            icon: Icons.female,
            label: 'FEMALE',
            isSelected: _selectedGender == Gender.female,
            cardColor: cardColor,
            accentColor: accentPink,
            mutedText: mutedText,
            onTap: () => _selectGender(Gender.female),),),],);}
  Widget _buildHeightCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),),
      child: Column(
        children: [
          Text(
            'HEIGHT',
            style: TextStyle(
              color: mutedText,
              fontSize: 13,
              letterSpacing: 1,),),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: _height.round().toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,),),
                TextSpan(
                  text: ' cm',
                  style: TextStyle(
                    color: mutedText,
                    fontSize: 18,),),],),),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white24,
              thumbColor: accentPink,
              overlayColor: accentPink.withOpacity(0.2),
              trackHeight: 3,),
            child: Slider(
              min: 100,
              max: 220,
              value: _height,
              onChanged: (value) => setState(() => _height = value),),),],),);}
  Widget _buildCounterCard({
    required String label,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: mutedText,
              fontSize: 13,
              letterSpacing: 1,),),
          const SizedBox(height: 6),
          Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,),),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CircleButton(icon: Icons.remove, onTap: onDecrement),
              const SizedBox(width: 12),
              _CircleButton(icon: Icons.add, onTap: onIncrement),],),],),);}
  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentPink, width: 1),),
      child: Column(
        children: [
          Text(
            'YOUR BMI',
            style: TextStyle(color: mutedText, fontSize: 12, letterSpacing: 1),),
          const SizedBox(height: 4),
          Text(
            _bmiResult!.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,),),
          Text(
            _bmiCategory,
            style: const TextStyle(color: accentPink, fontWeight: FontWeight.w600),),],),);}
  Widget _buildCalculateButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _calculateBmi,
        style: ElevatedButton.styleFrom(
          backgroundColor: accentPink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),),),
        child: const Text(
          'CALCULATE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,),),),);}}
class _GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color cardColor;
  final Color accentColor;
  final Color mutedText;
  final VoidCallback onTap;
  const _GenderCard({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.cardColor,
    required this.accentColor,
    required this.mutedText,
    required this.onTap,});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? accentColor : Colors.transparent,
            width: 2,),),
        child: Column(
          children: [
            Icon(
              icon,
              size: 48,
              color: isSelected ? accentColor : Colors.white,),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? accentColor : mutedText,
                fontSize: 13,
                letterSpacing: 1,),),],),),);}}
class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleButton({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xFF3A3A50),
          shape: BoxShape.circle,),
        child: Icon(icon, color: Colors.white, size: 18),),);}}