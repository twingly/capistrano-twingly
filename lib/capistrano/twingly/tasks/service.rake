namespace :deploy do
  set :bundle_binstubs, -> { shared_path.join('bin') }

  desc 'Lookup which service manager is used on each server'
  task :lookup_server_service_manager do
    on roles(:app) do |host|
      systemd_is_installed = execute "command -v systemctl",
                                     raise_on_non_zero_exit: false

      role = systemd_is_installed ? :systemd : :upstart

      server(host).add_role(role)
    end
  end

  desc 'Export service script'
  task :export_service do
    on roles(:upstart) do
      within current_path do
        sudo fetch(:chruby_exec), "#{fetch(:chruby_ruby)} -- #{fetch(:bundle_binstubs)}/foreman export upstart /etc/init -a #{fetch(:application)} -u \`whoami\` -l #{shared_path}/log"
      end
    end

    on roles(:systemd) do
      sudo :systemctl, "stop #{fetch(:application)}.target"

      within current_path do
        sudo fetch(:chruby_exec), "#{fetch(:chruby_ruby)} -- #{fetch(:bundle_binstubs)}/foreman export systemd /etc/systemd/system -a #{fetch(:application)} -u \`whoami\` -l #{shared_path}/log"
      end

      sudo :systemctl, "daemon-reload"
    end
  end

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

  task :disable_autostart do
    on roles(:upstart) do
      execute "/bin/echo manual | sudo /usr/bin/tee /etc/init/#{fetch(:application)}.override"
    end

    on roles(:systemd) do
      sudo :systemctl, "disable #{fetch(:application)}.target"
    end
  end

  task :enable_autostart do
    on roles(:upstart) do
      execute "/bin/echo | sudo /usr/bin/tee /etc/init/#{fetch(:application)}.override"
    end

    on roles(:systemd) do
      sudo :systemctl, "enable #{fetch(:application)}.target"
    end
  end

  namespace :foreman do
    desc 'Upload Procfile to server'
    task :upload_procfile do
      on roles(:app) do |host|
        upload! "tmp/Procfile_#{host.hostname}", "#{fetch(:deploy_to)}/current/Procfile"
      end
    end

    desc 'Generate Procfile'
    task  :generate_procfile do
      Dir.mkdir('tmp') unless Dir.exist?('tmp')

      procfile_contents = fetch(:procfile_contents)

      on roles(:app) do |host|
        procfile_contents_string =
          if procfile_contents.is_a?(Hash)
            procfile_contents.fetch(host.hostname)
          else
            procfile_contents
          end

        File.open("tmp/Procfile_#{host.hostname}", 'w') do |conf|
          procfile_contents_string.each_line do |line|
            conf.puts "#{line.chomp} 2>&1 | logger -t #{fetch(:app_name)}"
          end
        end
      end
    end
  end

  before 'deploy:export_service', 'deploy:lookup_server_service_manager'
  before 'deploy:start', 'deploy:lookup_server_service_manager'
  before 'deploy:restart', 'deploy:lookup_server_service_manager'
  before 'deploy:stop', 'deploy:lookup_server_service_manager'
  before 'deploy:disable_autostart', 'deploy:lookup_server_service_manager'
  before 'deploy:enable_autostart', 'deploy:lookup_server_service_manager'

  before 'deploy:export_service', 'deploy:foreman:upload_procfile'
  before 'deploy:foreman:upload_procfile', 'deploy:foreman:generate_procfile'
end
