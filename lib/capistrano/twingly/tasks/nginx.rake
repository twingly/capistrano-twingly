namespace :deploy do
  namespace :nginx do
    desc 'Generate Nginx configuration'
    task :generate_config do
      Dir.mkdir('config/nginx') unless Dir.exist?('config/nginx')

      server_names = Array(fetch(:server_names))
      server_names << "#{APP_NAME}.live.lkp.primelabs.se"

      conf = File.open('config/nginx/site.conf', 'w')
      conf << "
        upstream #{APP_NAME} {
          server unix:/tmp/#{APP_NAME}.thin-1.sock;
        }

        server {
          listen 80;
          server_name #{server_names.join(' ')};

          root /home/deploy/#{APP_NAME_WITH_PREFIX}/current/public;
          try_files $uri @app;

          expires 1h;
          location @app {
            expires off;
            proxy_pass         http://#{APP_NAME};
            proxy_redirect     off;
            proxy_set_header   Host             $host;
            proxy_set_header   X-Real-IP        $remote_addr;
            proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
          }
        }\n"
        conf.close
    end

    desc 'Upload Nginx configuration'
    task :upload_config do
      on roles(:app) do
        upload! 'config/nginx/site.conf', "/etc/nginx/sites-available/#{APP_NAME}.conf"
      end
    end

    desc 'Symlink Nginx configuration'
    task :enable_config do
      on roles(:app) do
        execute :ln, '-nfs', "/etc/nginx/sites-available/#{APP_NAME}.conf", "/etc/nginx/sites-enabled/#{APP_NAME}.conf"
      end
    end

    desc 'Reload Nginx'
    task :reload do
      on roles(:app) do
        execute :sudo, 'service', 'nginx', 'reload'
      end
    end
  end
end
