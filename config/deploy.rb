set :application, "SiRASS"
set :repository,  "git@cocoadev.com.mx:devel/cocoasirass.git"
set :deploy_to, '/home/web/cocoa/sirass.cocoadev.com.mx/'

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "nginx"                          # Your HTTP server, Apache/etc
role :app, "cocoadev.com.mx"                          # This may be the same as your `Web` server
role :db,  "sirass_production", :primary => true # This is where Rails migrations will run
role :db,  "cocoadev.com.mx"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do
  	run "rails server -e production -p 8082"
  end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  after :deploy, 'bundle exec rake db:uacm:all'
end