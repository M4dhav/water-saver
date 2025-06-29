class AdjustmentsPageData {
  double motorOffThresholdTank = 0.5;
  double motorOnThresholdTank = 0.2;

  double motorOffThresholdReservoir = 0.5;
  double motorOnThresholdReservoir = 0.2;
  bool autoDataLog = false;
  bool isThresholdError = false; // Add observable for error state

  bool isReservoirMotorOnRequired = false;

  AdjustmentsPageData({
    this.motorOffThresholdTank = 0.5,
    this.motorOnThresholdTank = 0.2,
    this.motorOffThresholdReservoir = 0.5,
    this.motorOnThresholdReservoir = 0.2,
    this.autoDataLog = false,
    this.isThresholdError = false,
    this.isReservoirMotorOnRequired = false,
  });

  AdjustmentsPageData copyWith({
    double? motorOffThresholdTank,
    double? motorOnThresholdTank,
    double? motorOffThresholdReservoir,
    double? motorOnThresholdReservoir,
    bool? autoDataLog,
    bool? isThresholdError,
    bool? isReservoirMotorOnRequired,
  }) {
    return AdjustmentsPageData(
      motorOffThresholdTank:
          motorOffThresholdTank ?? this.motorOffThresholdTank,
      motorOnThresholdTank: motorOnThresholdTank ?? this.motorOnThresholdTank,
      motorOffThresholdReservoir:
          motorOffThresholdReservoir ?? this.motorOffThresholdReservoir,
      motorOnThresholdReservoir:
          motorOnThresholdReservoir ?? this.motorOnThresholdReservoir,
      autoDataLog: autoDataLog ?? this.autoDataLog,
      isThresholdError: isThresholdError ?? this.isThresholdError,
      isReservoirMotorOnRequired:
          isReservoirMotorOnRequired ?? this.isReservoirMotorOnRequired,
    );
  }
}
