# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Console to the servers
require "capistrano/console"

# Gems
require "capistrano/chruby"
require "capistrano/bundler"

# Twingly tasks
require "capistrano/twingly/nginx"
require "capistrano/twingly/service"
require "capistrano/twingly/tag_deploy_in_git"
require "capistrano/twingly/current_git_branch"
require "capistrano/twingly/servers_from_srv_record"
