require 'simplecov'
SimpleCov.start do
  add_filter "/test/"  # Exclude test files from coverage report
  track_files "lib/**/*.rb"  # Track all Ruby files in lib directory
  enable_coverage :branch  # Track branch coverage as well as line coverage
end