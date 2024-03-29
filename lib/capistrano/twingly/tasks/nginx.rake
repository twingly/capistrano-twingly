namespace :deploy do
  namespace :nginx do
    desc 'Generate Nginx configuration'
    task :generate_config do
      Dir.mkdir('tmp') unless Dir.exist?('tmp')

      app_dir      = fetch(:deploy_to)
      app_name     = fetch(:app_name)
      server_names = fetch(:server_names)

      https_port = ":443" if fetch(:use_https)
      forwarded_protocol_is_https = fetch(:forwarded_protocol_is_https)

      conf = File.open('tmp/site.conf', 'w')
      conf << %Q{
        upstream #{app_name} {
          server unix:/tmp/#{app_name}.sock;
        }

        server {
          listen 80;
          server_name #{server_names.join(' ')};

          root #{app_dir}/current/public;

          try_files /system/maintenance.html $uri @app;

          location /assets {
            expires 1h;
          }
          location /favicon.ico {
            expires 1h;
          }
          location /robots.txt {
            expires 1h;
          }

          expires -1;
          location @app {
            expires off;
            proxy_pass         http://#{app_name};
            proxy_redirect     off;
            proxy_set_header   Host             $host#{https_port};
            proxy_set_header   X-Real-IP        $remote_addr;
            proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
            #{forwarded_protocol_is_https ? "proxy_set_header   X-Forwarded-Proto https;" : ""}
          }
        }\n}
        conf.close
    end

    desc 'Upload Nginx configuration'
    task :upload_config do
      on roles(:app) do
        app_name = fetch(:app_name)
        upload! 'tmp/site.conf', "/etc/nginx/sites-available/#{app_name}.conf"
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
