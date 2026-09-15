/// Thresholds and tunables for the on-device TFLite pipeline. Central
/// so Phase 5 (ML) changes don't require touching Scanner UseCases.
abstract final class InferenceConfig {
  static const double minConfidenceThreshold = 0.55;
  static const double nmsIouThreshold = 0.45;
  static const int maxDetectionsPerFrame = 20;
  static const int modelInputSize = 320; // square input, px

  static const String detectionModelAsset = 'assets/models/detection.tflite';
  static const String classificationModelAsset =
      'assets/models/classification.tflite';
  static const String labelsAsset = 'assets/models/labels.json';
}
