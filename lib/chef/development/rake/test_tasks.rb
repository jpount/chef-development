require 'rspec/core/rake_task'
require 'kitchen/rake_tasks'
require 'rubocop/rake_task'
require 'foodcritic'
require 'berkshelf'

module ChefDevelopment
  class TestTasks < Rake::TaskLib
    attr_reader :project_dir

    def initialize
      @project_dir   = Dir.pwd
      yield(self) if block_given?
      define
    end

    def define
      kitchen_config = Kitchen::Config.new
      Kitchen.logger = Kitchen.default_file_logger

      namespace "kitchen" do
        kitchen_config.instances.each do |instance|
          desc "Run #{instance.name} test instance"
          task instance.name do
            destroy = (ENV['KITCHEN_DESTROY'] || 'passing').to_sym
            instance.test(destroy)
          end
        end

        desc "Run all test instances"
        task :all do
          destroy = ENV['KITCHEN_DESTROY'] || 'passing'
          concurrency = ENV['KITCHEN_CONCURRENCY'] || '1'
          require 'kitchen/cli'
          Kitchen::CLI.new([], {concurrency: concurrency.to_i, destroy: destroy}).test()
        end
      end

      desc 'Runs Foodcritic linting'
      FoodCritic::Rake::LintTask.new do |task|
#        task.options = {
#          :search_gems => true,
#          :fail_tags => ['any'],
#          :tags => ['~FC003', '~FC015'],
#          :exclude_paths => ['vendor/**/*']
#        }
      end

      desc 'Run RuboCop on the lib directory'
      RuboCop::RakeTask.new(:rubocop) do |task|
        # only show the files with failures
        task.formatters = ['files']
        # don't abort rake on failure
        task.fail_on_error = false
      end

      desc 'Runs unit tests'
      RSpec::Core::RakeTask.new(:unit) do |task|
        task.pattern = FileList[File.join(project_dir, 'test', 'unit', '**/*_spec.rb')]
      end

      desc 'Runs integration tests'
      task :integration do
        Rake::Task['kitchen:all'].invoke
      end

      desc 'Run all tests and linting'
      task :test do
        Rake::Task['foodcritic'].invoke
        Rake::Task['rubocop'].invoke
        Rake::Task['unit'].invoke
        Rake::Task['integration'].invoke
      end

      task :unit_test_header do
        puts "-----> Running unit tests with chefspec".cyan
      end
      task :unit => :unit_test_header

      task :unit_test_qa_header do
        puts "-----> Running unit tests and quality checks".cyan
      end

      desc 'Run unit tests and QA'
      task :unit_and_qa do
        Rake::Task['unit_test_qa_header'].invoke
        Rake::Task['foodcritic'].invoke
        Rake::Task['rubocop'].invoke
        Rake::Task['unit'].invoke
      end

      task :foodcritic_header do
        puts "-----> Linting with foodcritic".cyan
      end
      task :foodcritic => :foodcritic_header

      task :rubocop_header do
        puts "-----> Checking Ruby code with rubocop".cyan
      end
      task :rubocop => :rubocop_header

      task :integration_header do
        puts "-----> Running integration tests with test-kitchen".cyan
      end
      task :integration => :integration_header
    end
  end
end
