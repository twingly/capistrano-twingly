load File.expand_path("../tasks/current_git_branch.rake", __FILE__)

module Twingly
  module Git
    module_function

    # Colors are pretty!
    def red(str)
      "\e[31m#{str}\e[0m"
    end

    def info
      "branch #{red(fetch(:branch))} to stage #{red(fetch(:stage))}"
    end

    def current_branch
      `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(/^refs\/heads\//, '')
    end
  end
end
