namespace :app do
  desc 'Bootstrap the app'
  task :bootstrap do
    system 'bundle'
    Rake::Task['db:create'].invoke
    Rake::Task['db:create RAILS_ENV=test'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:clone'].invoke
    Rake::Task['db:seed'].invoke
  end
end
