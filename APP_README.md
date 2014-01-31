# AppName Readme

## Required Environment / Minimum Setup

* The provisioning scripts should work on any Ubuntu compatible Linux flavor.

## Getting Started

In development this will get you started:

    $ bundle
    $ rake db:create
    $ rake db:create RAILS_ENV=test
    $ rake db:migrate
    $ rake db:test:clone
    $ rake db:seed

`rake app:bootstrap` will run all steps.

Then to start the app:

    $ bundle exec guard start

## Provisioning

See doc/PROVISION.md

## Deployment

Before the first deploy you have to first SSH into the server, run the following command and accept the prompt:

    $ ssh <server> 'ssh <git@bitbucket.org|git@github.com>'

Then deployment can start:

    $ mina setup  # Only once, before the first deploy
    $ mina deploy

## Configuration

* `.env` - Configuration settings. deploy:setup will ask for values.

## Testing

    rake test
