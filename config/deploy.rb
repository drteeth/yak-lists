require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"

set :user, "deployer"
set :application, "ListBone"

set :scm, :git
set :repository,  "git://github.com/drteeth/yak-lists.git"
set :branch, "master"

set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

my_server = '198.74.57.254'
role :web, my_server
role :app, my_server
role :db,  my_server, :primary => true

after "deploy:restart", "deploy:cleanup"
