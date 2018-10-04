namespace :deploy do
  set :bundle_binstubs, -> { shared_path.join('bin') }

  desc 'Export upstart script'
  task :export_upstart do
    on roles(:app) do
      within current_path do
        sudo fetch(:chruby_exec), "#{fetch(:chruby_ruby)} -- #{fetch(:bundle_binstubs)}/foreman export upstart /etc/init -a #{fetch(:application)} -u \`whoami\` -l #{shared_path}/log"
      end
    end
  end

  task :disable_autostart do
    on roles(:app) do
      execute "/bin/echo manual | sudo /usr/bin/tee /etc/init/#{fetch(:application)}.override"
    end
  end

  task :enable_autostart do
    on roles(:app) do
      execute "/bin/echo | sudo /usr/bin/tee /etc/init/#{fetch(:application)}.override"
    end
  end

  namespace :foreman do
    desc 'Upload Procfile to server'
    task :upload_procfile do
      on roles(:app) do |host|
        upload! "tmp/Procfile_#{host.name}", "#{fetch(:deploy_to)}/current/Procfile"
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

  before 'deploy:export_upstart', 'deploy:foreman:upload_procfile'
  before 'deploy:foreman:upload_procfile', 'deploy:foreman:generate_procfile'
end
