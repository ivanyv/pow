# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

# Load all the tasks in lib/tasks
Dir[File.expand_path('../lib/tasks/', __FILE__) + '/*.rake'].each do |file|
  load file
end

# The original rails rakefile loading
def load_rails_environment
  require File.expand_path('../config/application', __FILE__)
  require 'rake'
  AppName::Application.load_tasks
end

# Catch task missing and try again
class Rake::Application
  private
  alias_method :invoke_task_without_catch, :invoke_task

  def invoke_task_with_catch(*args)
    begin
      invoke_task_without_catch(*args)
    rescue RuntimeError => e
      raise e unless /build task/.match(e.to_s)

      load_rails_environment
      invoke_task_without_catch(*args)
    end
  end
  alias_method :invoke_task, :invoke_task_with_catch
end

# Add a task to the top of the rake -T list, to explain how to get the full list
# of tasks including rails and gem tasks
if ENV['LOAD_RAILS'] == '1'
  load_rails_environment
else
  desc "!!! Rails and gem tasks are not listed, rerun with LOAD_RAILS=1 to reveal"
  task :_README
end
