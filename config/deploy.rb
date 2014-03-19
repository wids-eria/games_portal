require "rvm/capistrano"

set :rvm_ruby_string, '1.9.3-p194'
set :rvm_type, :system
set :rvm_path, "/usr/local/rvm"

require 'bundler/capistrano'
load 'deploy/assets'

require 'capistrano/ext/multistage'
set :stages, %w(production development)
set :default_stage, "development"

set :application, "games_portal"
set :repository,  "git@github.com:wids-eria/games_portal.git"
set :branch, "master"
set :scm, :git

set :user, :deploy
ssh_options[:forward_agent] = true

set :deploy_to, "/home/deploy/applications/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :normalize_asset_timestamps, false


# CALLBACKS #########

after 'deploy:finalize_update', 'deploy:symlink_db'
after 'deploy:finalize_update', 'deploy:symlink_external_site_config'
after 'deploy:finalize_update', 'deploy:symlink_secret_token'
after 'deploy:finalize_update', 'deploy:symlink_application_yml'

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/shared/config/mongoid.yml #{release_path}/config/mongoid.yml"
  end

  desc "Symlink external site config"
  task :symlink_external_site_config do
    run "ln -nfs #{deploy_to}/shared/config/initializers/external_hosts.rb #{release_path}/config/initializers/external_hosts.rb"
  end

  desc "Symlink secret_token config"
  task :symlink_secret_token do
    run "ln -nfs #{deploy_to}/shared/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end

  desc "Symlink application config"
  task :symlink_application_yml do
    run "ln -nfs #{deploy_to}/shared/config/application.yml #{release_path}/config/application.yml"
  end

  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && touch tmp/restart.txt"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && touch tmp/restart.txt"
  end
end


# ==============================
# Paperclip Uploads proper capistrano symlink
# ==============================

namespace :uploads do

  desc <<-EOD
    Creates the upload folders unless they exist
    and sets the proper upload permissions.
  EOD
  task :setup, :except => { :no_release => true } do
    dirs = uploads_dirs.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
  end

  desc <<-EOD
    [internal] Creates the symlink to uploads shared folder
    for the most recently deployed version.
  EOD
  task :symlink, :except => { :no_release => true } do
    run "rm -rf #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/#{stage}/uploads #{release_path}/public/uploads"
  end

  desc <<-EOD
    [internal] Computes uploads directory paths
    and registers them in Capistrano environment.

    Note. I can't set value for directories directly in the code because
    I don't know in advance selected stage.
  EOD
  task :register_dirs do
    set :uploads_dirs,    %w(uploads uploads/partners).map { |d| "#{stage}/#{d}" }
    set :shared_children, fetch(:shared_children) + fetch(:uploads_dirs)
  end

  after       "deploy:finalize_update", "uploads:symlink"
  on :start,  "uploads:register_dirs",  :except => stages + ['multistage:prepare']

end