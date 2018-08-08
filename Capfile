# Load configuration for capistrano
CAP_CONFIG = YAML.load_file(File.expand_path('../config/capistrano.local.yml', __FILE__))

# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'

require 'capistrano/bundle_rsync/plugin'
install_plugin Capistrano::BundleRsync::Plugin

require_relative 'lib/capistrano/recipes/base'
require_relative 'lib/capistrano/recipes/config'
require_relative 'lib/capistrano/recipes/puma'
require_relative 'lib/capistrano/recipes/sidekiq'
require_relative 'lib/capistrano/recipes/app'
