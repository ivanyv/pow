%I[development test staging production].each do |environment|
  desc "Set environment to #{environment}"
  task environment do
    ENV['RAILS_ENV'] = environment.to_s
  end
end

desc 'Fail if RAILS_ENV is not defined'
task :require_env do
  raise 'No RAILS_ENV defined' if ENV['RAILS_ENV'].to_s.strip == ''
end
