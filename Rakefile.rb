require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

desc "Run tests with coverage"
task :coverage do
  system "ruby test/studio_game/all_tests.rb"
  puts "\nCoverage report generated. Open coverage/index.html in your browser."
end

task default: :test