namespace :provision do
  desc 'Provision a server from zero'
  task :cold do
    Rake::Task['provision:setup'].invoke
    Rake::Task['provision'].invoke
    Rake::Task['provision:reboot'].invoke
  end

  desc 'Setup server'
  task setup: :require_env do
    system "cd provision && ansible-playbook -i hosts.ini -l #{ENV['RAILS_ENV']} -u root -k setup.yml"
  end

  desc 'Reboot server'
  task reboot: [ :require_env, :get_user ] do
    system "cd provision && ansible #{ENV['RAILS_ENV']} -m command -s -u #{@user} -a '/sbin/reboot -t now' -i hosts.ini"
  end

  task :get_user do
    vars = YAML.load(File.read(File.join('provision/vars.yml')))
    @user = vars['user']
  end

  task provision: [ :require_env, :get_user ] do
    system "cd provision && ansible-playbook -i hosts.ini -l #{ENV['RAILS_ENV']} -u #{@user} -k setup.yml"
  end
end

desc 'Install/update and configure server'
task provision: 'provision:provision'
