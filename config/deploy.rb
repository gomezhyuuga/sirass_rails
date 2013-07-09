require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, "cocoasirass"
set :repository,  "git@github.com:gomezhyuuga/sirass_rails.git"
set :deploy_to, "/home/sirass/app"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "sirass"
set :use_sudo, false

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "sirass.uacm.edu.mx"                          # Your HTTP server, Apache/etc
role :app, "sirass.uacm.edu.mx"                          # This may be the same as your `Web` server
role :db,  "sirass.uacm.edu.mx", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"
server "sirass.uacm.edu.mx", :app, :web, :db, :primary => true
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do
  	run "cd #{current_path} && thin start -e production -d"
  end
  task :stop do
  	run "cd #{current_path} && thin stop"
  end
  task :restart do
    run "cd #{current_path} && thin stop && thin start -e production -d"
  end
end