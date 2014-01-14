# Capistrano::Twingly

Capistrano 3 tasks used for Twingly's Ruby deployment

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-twingly', git: 'git@github.com:twingly/capistrano-twingly'

And then execute:

    $ bundle

## Usage

### Nginx tasks

```Ruby
# Capfile
require 'capistrano/twingly/nginx'

# config/deploy.rb
namespace deploy do
  after :finishing, 'deploy:nginx:generate_config'
  after :finishing, 'deploy:nginx:upload_config'
  after :finishing, 'deploy:nginx:enable_config'
  after :finishing, 'deploy:nginx:reload'
end
```

### Upstart

```Ruby
# Capfile
require 'capistrano/twingly/upstart'

# config/deploy.rb
namespace :deploy do
  desc 'Start application'
  task :start do
    invoke 'deploy:export_upstart'
    on roles(:app) do
      sudo :start, fetch(:application)
    end
  end

  desc 'Restart application'
  task :restart do
    invoke 'deploy:export_upstart'
    on roles(:app) do
      execute "sudo restart #{fetch(:application)} || sudo start #{fetch(:application)}"
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:app) do
      sudo :stop, fetch(:application)
    end
  end
end
```

### Tag deploys in Git

```Ruby
# Capfile
require 'capistrano/twingly/tag_deploy_in_git'

# config/deploy.rb
namespace :deploy do
  after :finishing, 'deploy:push_deploy_tag'
end
```

### Fetch servers from SRV record

```Ruby
# Capfile
require 'capistrano/twingly/servers_from_srv_record'

# config/deploy/production.rb
fetch(:servers_from_srv_record).each do |hostname|
  server hostname, user: 'deploy', roles: %w{app}
end
```


## Contributing

1. Fork it ( http://github.com/twingly/capistrano-twingly/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
