set :application, "helloworld"
set :repository,  "git://github.com/bryanl/helloworld.git"

role :app, "li36-28.members.linode.com"
role :web, "li36-28.members.linode.com"
role :db, "li36-28.members.linode.com", :primary => true

set :deploy_to, "/var/www/apps/#{application}"
set :scm, :git
ste :git_enable_submodules, 1
set :branch, "master"

namespace :deploy do
  desc "restart passenger" 
  task :restart, :roles => :app, :except => { :no_relase => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :after_symlink do
    c = "database.yml"
    %w[database.yml].each do |c|
      run "ln -nsf #{shared_path}/system/config/#{c} #{current_path}/config/#{c}"
    end
  end
  
  [:start, :stop].each do |t|
    desc "#{t} is a no-op with passenger"
    task t, :roles => :app do; end
  end
end