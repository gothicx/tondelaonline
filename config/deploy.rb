set :user, "kmos"
set :application, "tondela"
set :local_repository, "."
set :domain, "tondela.org"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/#{user}/#{domain}"

# SCM:
set :scm_username, "gothicx"
set :scm_password, "h4lld0n3"
set :repository,  "http://svn.tondela.org/#{application}"
#set :checkout, "export"

ssh_options[:paranoid] = false

set :use_sudo, false

server domain, :app, :web
role :db, domain, :primary => true

# Restart (override deploy:restart)
namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
end
