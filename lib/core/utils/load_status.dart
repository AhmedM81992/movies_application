/// Single source of truth for all load status enums across the entire app.
/// No other file should define a LoadStatus enum.
enum LoadStatus {
  initial,
  loading,
  success,
  error,
}
