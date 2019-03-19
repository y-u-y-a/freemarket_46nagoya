# config valid for current version and patch releases of Capistrano
set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
  BASIC_AUTH_USER: ENV["BASIC_AUTH_USER"],
  BASIC_AUTH_PASSWORD: ENV["BASIC_AUTH_PASSWORD"]
}

set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
  AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
  AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"]
}

# set :default_env, {
#   rbenv_root: "/usr/local/rbenv",
#   path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
#   RECAPTCHA_SITE_KEY: ENV["RECAPTCHA_SITE_KEY"],
#   RECAPTCHA_SECRET_KEY: ENV["RECAPTCHA_SECRET_KEY"]
# }


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
end
