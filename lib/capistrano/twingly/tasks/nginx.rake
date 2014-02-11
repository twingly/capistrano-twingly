namespace :deploy do
  namespace :nginx do
    desc 'Generate Nginx configuration'
    task :generate_config do
      Dir.mkdir('config/nginx') unless Dir.exist?('config/nginx')

      app_dir      = fetch(:deploy_to)
      app_name     = fetch(:app_name)
      server_names = Array(fetch(:server_names))
      server_names << "#{app_name}.live.lkp.primelabs.se"

      https_port = ":443" if fetch(:use_https)

      conf = File.open('config/nginx/site.conf', 'w')
      conf << "
        upstream #{app_name} {
          server unix:/tmp/#{app_name}.thin-1.sock;
        }

        server {
          listen 80;
          server_name #{server_names.join(' ')};

          root #{app_dir}/current/public;
          try_files $uri @app;

          expires 1h;
          location @app {
            expires off;
            proxy_pass         http://#{app_name};
            proxy_redirect     off;
            proxy_set_header   Host             $host#{https_port};
            proxy_set_header   X-Real-IP        $remote_addr;
            proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
          }
        }\n"
        conf.close
    end

    desc 'Upload Nginx configuration'
    task :upload_config do
      on roles(:app) do
        app_name = fetch(:app_name)
        upload! 'config/nginx/site.conf', "/etc/nginx/sites-available/#{app_name}.conf"
      end
    end

    desc 'Symlink Nginx configuration'
    task :enable_config do
      on roles(:app) do
        app_name = fetch(:app_name)
        execute :ln, '-nfs', "/etc/nginx/sites-available/#{app_name}.conf", "/etc/nginx/sites-enabled/#{app_name}.conf"
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
