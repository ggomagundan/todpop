# -*- encoding : utf-8 -*-
require "bundler/capistrano"

set :application, "todpop"
#set :repository,  "git@198.211.117.25:projects/salty.git"
#set :repository, "git@github.com:ggomagundan/todpop.git"
set :repository, "https://github.com/ggomagundan/todpop.git"
#set :repository,  "/home/git/projects/salty.git"
#set :repository,  "git://198.211.117.25/projects/salty.git"
set :user, "deployer"
set :password, "Xhemvkq4321"
set :deploy_to, "/todpop/todpop_app"
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server "14.63.160.137", :app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
ssh_options[:forward_agent] = true
default_run_options[:pty] = true


#after "deploy", "deploy:cleanup" # keep only the last 5 releases
after "deploy", "image:symbolic_link"

namespace :deploy do
    %w[start stop restart].each do |command|
      desc "#{command} unicorn server"
      task command, roles: :app, except: {no_release: true} do
       # run "#{deploy_to}/current/config/unicorn_init.sh #{command}"
        run "/etc/init.d/unicorn_#{application} #{command}"
       # run "cd #{deploy_to}/current ; bundle exec unicorn -D -c config/unicorn.rb -E production"
      end
    end

    task :setup_config, roles: :app do
     # sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
      sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
      run "mkdir -p #{shared_path}/config"
      put File.read("config/database.yml.sample"), "#{shared_path}/config/database.yml"
      puts "Now edit the config files in #{shared_path}."
    end
    after "deploy:setup", "deploy:setup_config"
    
    task :symlink_config, roles: :app do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
    after "deploy:finalize_update", "deploy:symlink_config"

    desc "Make sure local git is in sync with remote."
    task :check_revision, roles: :web do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
    before "deploy", "deploy:check_revision"
    after "deploy:update_code", "deploy:migrate"
end

namespace :image do

  task :symbolic_link do
    run "ln -s /todpop/todpop_data /todpop/todpop_app/current/public/uploads"
  end
end
