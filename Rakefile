require 'rake/testtask'

task default: %w[test:all]

namespace :test do
  Rake::TestTask.new(:controllers) do |t|
    t.pattern = 'tests/controllers/*_test.rb'
  end

  Rake::TestTask.new(:models) do |t|
    t.pattern = 'tests/models/*_test.rb'
  end

  Rake::TestTask.new(:integration) do |t|
    t.pattern = 'tests/integration/*_test.rb'
  end

  Rake::TestTask.new(:all) do |t|
    t.pattern = 'tests/*/*_test.rb'
  end
end

namespace :db do
  task :open do
    sh 'psql -d spending-tracker-4567'
  end

  task :build do
    sh 'psql -d spending-tracker-4567 -f db/spending-tracker.sql'
  end

  task :seed do
    sh 'ruby db/seeds.rb'
  end
end
