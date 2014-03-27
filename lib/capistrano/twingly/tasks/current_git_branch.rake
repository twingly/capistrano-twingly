after :deploy, :echo_current_git_branch_after do
  run_locally do
    info "Deployed #{Twingly::Git.info}"
  end
end
