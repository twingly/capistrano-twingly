module Twingly
  module Git
    module_function

    # Colors are pretty!
    def red(str)
      "\e[31m#{str}\e[0m"
    end

    def current_branch
      branch = `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(/^refs\/heads\//, '')
      puts "Deploying branch #{red(branch)} to stage #{red(fetch(:stage))}"
      branch
    end
  end
end
