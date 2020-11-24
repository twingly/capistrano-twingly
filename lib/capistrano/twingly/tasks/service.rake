namespace :deploy do
  desc 'Lookup which service manager is used on each server'
  task :lookup_server_service_manager do
    init_system_pid = 1

    on roles(:app) do |host|
      service_manager_name =
        capture "ps -p#{init_system_pid} co command | grep systemd || echo upstart"

      server(host).add_role(service_manager_name.to_sym)
    end
  end

  desc 'Export service script'
  task export_service: %w[lookup_server_service_manager foreman:upload_procfile] do
    set :bundle_binstubs, -> { shared_path.join('bin') }

    on roles(:upstart) do
      within current_path do
        sudo fetch(:chruby_exec), "#{fetch(:chruby_ruby)} -- #{fetch(:bundle_binstubs)}/foreman export upstart /etc/init -a #{fetch(:application)} -u \`whoami\` -l #{shared_path}/log"
      end
    end

    on roles(:systemd) do
      load_state =
        capture "systemctl show #{fetch(:application)}.target -p LoadState --value"

      if load_state == "loaded"
        sudo :systemctl, "stop #{fetch(:application)}.target"
      end

      within current_path do
        sudo fetch(:chruby_exec), "#{fetch(:chruby_ruby)} -- #{fetch(:bundle_binstubs)}/foreman export systemd /etc/systemd/system -a #{fetch(:application)} -u \`whoami\` -l #{shared_path}/log"
      end

      sudo :systemctl, "daemon-reload"
    end
  end

  desc "Start application"
  task start: :lookup_server_service_manager do
    invoke "deploy:export_service"

    on roles(:upstart) do
      sudo :start, fetch(:application)
    end

    on roles(:systemd) do
      sudo :systemctl, "start #{fetch(:application)}.target"
    end
  end

  desc "Restart application"
  task restart: :lookup_server_service_manager do
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
  task stop: :lookup_server_service_manager do
    on roles(:upstart) do
      sudo :stop, fetch(:application)
    end

    on roles(:systemd) do
      sudo :systemctl, "stop #{fetch(:application)}.target"
    end
  end

  task disable_autostart: :lookup_server_service_manager do
    on roles(:upstart) do
      execute "/bin/echo manual | sudo /usr/bin/tee /etc/init/#{fetch(:application)}.override"
    end

    on roles(:systemd) do
      sudo :systemctl, "disable #{fetch(:application)}.target"
    end
  end

  task enable_autostart: :lookup_server_service_manager do
    on roles(:upstart) do
      execute "/bin/echo | sudo /usr/bin/tee /etc/init/#{fetch(:application)}.override"
    end

    on roles(:systemd) do
      sudo :systemctl, "enable #{fetch(:application)}.target"
    end
  end

  namespace :foreman do
    desc 'Upload Procfile to server'
    task upload_procfile: :generate_procfile do
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
end
