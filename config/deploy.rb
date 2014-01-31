require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/scp'
require 'yaml'

vars = YAML.load(File.read('provision/vars.yml'))
hosts = File.read('provision/hosts.ini').gsub("\n", '')
env_to = ENV['to'].to_s.strip
env_to = 'staging' if env_to == ''
host = /\[#{env_to}\] ?(.+)/.match(hosts)[1].split(' ')[0]

set :user,          vars['user']
set :domain,        host
set :deploy_to,     vars['app_root'].sub('{{ user }}', vars['user'])
set :repository,    'YOUR_REPO_URL'
set :branch,        'master'
set :forward_agent, true

set :shared_paths, [ '.env.production', 'log', 'public/system' ]

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[mkdir -p "#{deploy_to}/shared/public/system"]
  queue! %[chmod -R g+rx,u+rwx "#{deploy_to}/shared/public"]

  require 'securerandom'
  key = SecureRandom.hex(64)
  template = File.read('.env.production.template').sub(':SECRET_KEY', key)
  File.open('tmp/env.production', 'w') { |f| f.puts template }
  scp_upload 'tmp/env.production', "#{deploy_to}/shared/.env.production"
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      queue "mkdir -p #{deploy_to}/current/tmp && touch #{deploy_to}/current/tmp/restart.txt"
      queue "#{rake} db:seed"
    end
  end
end
