# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Console to the servers
require "capistrano/console"

# Gems
require "capistrano/chruby"
require "capistrano/bundler"

# Twingly tasks
require "capistrano/twingly/nginx"
require "capistrano/twingly/upstart"
require "capistrano/twingly/tag_deploy_in_git"
require "capistrano/twingly/current_git_branch"
require "capistrano/twingly/servers_from_srv_record"