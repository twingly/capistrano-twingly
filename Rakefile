require "bundler/gem_tasks"

begin
  require "rspec/core/rake_task"

  task default: "spec"

  desc "Run all tests"
  RSpec::Core::RakeTask.new(:spec) do |task|
    task.pattern = "spec/**/*_spec.rb"
  end
rescue LoadError => error
  warn error.message
end
