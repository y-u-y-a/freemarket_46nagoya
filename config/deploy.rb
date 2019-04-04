# config valid for current version and patch releases of Capistrano

set :linked_files, %w{ config/secrets.yml }

set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
  AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
  AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"],
  BASIC_AUTH_USER: ENV["BASIC_AUTH_USER"],
  BASIC_AUTH_PASSWORD: ENV["BASIC_AUTH_PASSWORD"],
  RECAPTCHA_SITE_KEY: ENV["RECAPTCHA_SITE_KEY"],
  RECAPTCHA_SECRET_KEY: ENV["RECAPTCHA_SECRET_KEY"],
  PAYJP_PRIVATE_KEY: ENV["PAYJP_PRIVATE_KEY"],
  FACEBOOK_APP_ID: ENV["FACEBOOK_APP_ID"],
  FACEBOOK_APP_SECRET: ENV["FACEBOOK_APP_SECRET"],
  GOOGLE_CLIENT_ID: ENV["GOOGLE_CLIENT_ID"],
  GOOGLE_CLIENT_SECRET: ENV["GOOGLE_CLIENT_SECRET"],
}

set :application, "my_app_name"
set :repo_url, "git@example.com:me/my_repo.git"

# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'freemarket_46nagoya'
set :repo_url,  'git@github.com:tsurutadesu/freemarket_46nagoya.git'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'

set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/iamtsuruta.pem']

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'upload secrets.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/secrets.yml', "#{shared_path}/config/secrets.yml")
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end

namespace :deploy do
  desc 'db_seed'
  task :db_seed do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
end
