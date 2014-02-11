namespace :deploy do
  desc 'Export upstart script'
  task :export_upstart do
    on roles(:app) do
      within current_path do
        sudo fetch(:chruby_exec), "#{fetch(:chruby_ruby)} -- #{fetch(:bundle_binstubs)}/foreman export upstart /etc/init -a #{fetch(:application)} -u \`whoami\` -l #{shared_path}/log"
      end
    end
  end

  namespace :foreman do
    desc 'Upload Procfile to server'
    task :upload_procfile do
      on roles(:app) do
        upload! 'config/foreman/Procfile', "#{fetch(:deploy_to)}/current/Procfile"
      end
    end

    desc 'Generate Procfile'
    task  :generate_procfile do
      Dir.mkdir('config/foreman') unless Dir.exist?('config/foreman')
      conf = File.open('config/foreman/Procfile', 'w')
      conf << "#{fetch(:procfile_contents)}\n"
      conf.close
    end
  end

  before 'deploy:export_upstart', 'deploy:foreman:upload_procfile'
  before 'deploy:foreman:upload_procfile', 'deploy:foreman:generate_procfile'
end
