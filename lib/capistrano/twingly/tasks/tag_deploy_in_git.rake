namespace :deploy do
  desc "Create a release tag and push it"
  task :push_deploy_tag do
    user     = `git config --get user.name`.chomp
    email    = `git config --get user.email`.chomp
    tag_name = "#{Time.now.strftime("%Y-%m-%d__%H_%M_%S")}__#{fetch(:stage)}"
    revision = fetch(:current_revision)

    message = "Deployed by #{user} <#{email}>"

    run_locally do
      execute "git tag #{tag_name} #{revision} -m \"#{message}\""
      execute "git push origin refs/tags/#{tag_name}"
    end
  end
end
