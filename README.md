# Capistrano::Twingly

Capistrano 3 tasks used for Twingly's Ruby deployment

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-twingly', github: 'twingly/capistrano-twingly'

And then execute:

    $ bundle

## Usage

If you want to require all dependencies ([capistrano], [capistrano-bundler], [capistrano-chruby]) and all task helpers, it is possible to do so with one line:

```Ruby
# Capfile
require 'capistrano/twingly'
```

[capistrano]: https://github.com/capistrano/capistrano
[capistrano-bundler]: https://github.com/capistrano/capistrano-bundler
[capistrano-chruby]: https://github.com/capistrano/capistrano-chruby

See below if you want to selectively require tasks. In any case, you need to set variables and specify tasks as demonstrated below.

### Deploy current git branch

```Ruby
# Capfile
require 'capistrano/twingly/current_git_branch'

# config/deploy/production.rb
set :branch, Twingly::Git.current_branch
```

### Nginx tasks

```Ruby
# Capfile
require 'capistrano/twingly/nginx'

# config/deploy.rb
set :app_name, 'contest-bamba'
set :server_names, %w(bamba.bloggportalen.se)
set :use_https, true # Optional

namespace :deploy do
  after :finishing, 'deploy:nginx:generate_config'
  after :finishing, 'deploy:nginx:upload_config'
  after :finishing, 'deploy:nginx:enable_config'
  after :finishing, 'deploy:nginx:reload'
end
```

### Upstart/Systemd

```Ruby
# Capfile
require 'capistrano/twingly/service'

# config/deploy.rb
set :procfile_contents, -> {
  contents = ''
  contents << "web: "
  contents << "chruby-exec #{fetch(:chruby_ruby)} -- "
  contents << "bundle exec "
  contents << "puma "
  contents << "-b unix:///tmp/#{fetch(:app_name)}.sock "
  contents << "-e #{fetch(:stage)}"
}

namespace :deploy do
  desc "Start application"
  task :start do
    invoke "deploy:export_service"

    on roles(:upstart) do
      sudo :start, fetch(:application)
    end

    on roles(:systemd) do
      sudo :systemctl, "start #{fetch(:application)}.target"
    end
  end

  desc "Restart application"
  task :restart do
    invoke "deploy:export_service"

    on roles(:upstart) do
      execute "sudo restart #{fetch(:application)} || sudo start #{fetch(:application)}"
    end

    on roles(:systemd) do
      application = fetch(:application)
      execute "sudo systemctl restart #{application}.target || sudo systemctl start #{application}.target"
    end
  end

  desc "Stop application"
  task :stop do
    on roles(:upstart) do
      sudo :stop, fetch(:application)
    end

    on roles(:systemd) do
      sudo :systemctl, "stop #{fetch(:application)}.target"
    end
  end

  after :stop, 'deploy:disable_autostart'
  after :start, 'deploy:enable_autostart'
  after :restart, 'deploy:enable_autostart'
end
```

It's also possible to use a different Procfile for each host by setting `procfile_contents` to a Hash:

```ruby
# config/deploy.rb
set :procfile_contents, -> {
  servers = fetch(:servers_from_srv_record)

  servers.each_with_object({}) do |hostname, procfiles_by_host|
    contents = "web: CURRENT_HOST=#{hostname} bundle exec puma"

    procfiles_by_host[hostname] = contents
  end
}
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

*Note: Each server needs to either have the `systemd` or `upstart` role (in addition to `app`) depending on which service management system is used on the server.*

```Ruby
# Capfile
require 'capistrano/twingly/servers_from_srv_record'

# config/deploy/production.rb
fetch(:servers_from_srv_record).each do |hostname|
  server hostname, user: 'deploy', roles: %w{app systemd}
end
```

## Release workflow

* Update the examples in this README if needed.

* Bump the version in `capistrano-twingly.gemspec` in a commit, no need to push (the release task does that).

* Build and [publish](http://guides.rubygems.org/publishing/) the gem. This will create the proper tag in git, push the commit and tag and upload to RubyGems.

        bundle exec rake release

    * If you are not logged in as [twingly][twingly-rubygems] with ruby gems, the rake task will fail and tell you to set credentials via `gem push`, do that and run the `release` task again. It will be okay.

* Update the changelog with [GitHub Changelog Generator](https://github.com/skywinder/github-changelog-generator/) (`gem install github_changelog_generator` if you don't have it, set `CHANGELOG_GITHUB_TOKEN` to a personal access token to avoid rate limiting by GitHub). This command will update `CHANGELOG.md`, commit and push manually.

        github_changelog_generator

## Note about `CHANGELOG.md`

The changelog is incorrect for some old versions, where the version was increased before the pull request was merged. This is due to how `github_changelog_generator` works.

[twingly-rubygems]: https://rubygems.org/profiles/twingly
