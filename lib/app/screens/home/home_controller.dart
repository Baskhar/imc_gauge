class IMCController {
  double weight = 0.0;
  double height = 0.0;
  double result = 0.0;

  void calculateIMC() {
    if (weight > 0 && height > 0) {
      result = weight / (height * height);
    } else {
      result = 0.0;
    }
  }

  String getIMCClassification() {
    if (result < 16.0) {
      return "Muito abaixo do peso";
    } else if (result >= 16.0 && result < 16.9) {
      return "Abaixo do peso";
    } else if (result >= 17.0 && result < 18.4) {
      return "Peso abaixo do normal";
    } else if (result >= 18.5 && result < 24.9) {
      return "Peso normal";
    } else if (result >= 25.0 && result < 29.9) {
      return "Acima do peso";
    } else if (result >= 30.0 && result < 34.9) {
      return "Obesidade Grau 1";
    } else if (result >= 35.0 && result < 39.9) {
      return "Obesidade Grau 2";
    } else {
      return "Obesidade Grau 3";
    }
  }
  String calculateWeightChangeToNormal() {
    double normalBMI = 24.9;
    double targetWeight = normalBMI * (height * height);

    if (result < 18.5 || result > 24.9) {
      double weightChange = targetWeight - weight;
      if (weightChange > 0) {
        return "Você precisa ganhar ${weightChange.toStringAsFixed(2).toUpperCase()} kg para atingir o peso normal";
      } else {
        return "Você precisa perder ${(-weightChange).toStringAsFixed(2).toUpperCase()} kg para atingir o peso normal";
      }
    } else {
      return "Você está dentro do peso normal";
    }
  }
}
