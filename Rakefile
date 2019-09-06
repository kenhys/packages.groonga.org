begin
  require "rspec/core/rake_task"
rescue LoadError
  puts("You need to install serverspec by 'gem install serverspec' for testing.")
else
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "spec/**/*_spec.rb"
  end

  task :default => :spec
end

desc "Apply the Ansible configurations"
task :deploy do
  sh("ansible-playbook",
     "--inventory-file", "hosts",
     "ansible/playbook.yml")
end

if ARGV != ["deploy"]
  packages_red_data_tools_org_repository =
    ENV["PACKAGES_RED_DATA_TOOLS_ORG_REPOSITORY"]
  if packages_red_data_tools_org_repository.nil?
    raise "Specify PACKAGES_RED_DATA_TOOLS_ORG_REPOSITORY environment variable"
  end
  require "#{packages_red_data_tools_org_repository}/repository-task"

  groonga_repository = ENV["GROONGA_REPOSITORY"]
  if groonga_repository.nil?
    raise "Specify GROONGA_REPOSITORY environment variable"
  end

  class GroongaRepositoryTask < RepositoryTask
    def initialize(groonga_repository)
      @groonga_repository = groonga_repository
    end

    def repository_name
      "groonga"
    end

    def repository_label
      "The Groonga Project"
    end

    def repository_description
      "Groonga related packages"
    end

    def repository_url
      "https://packages.groonga.org"
    end

    def rsync_base_path
      "packages@packages.groonga.org:public"
    end

    def gpg_uids
      [
        "2701F317CFCCCB975CADE9C2624CF77434839225", # new 4092bit
        "C97E4649A2051D0CEA1A73F972A7496B45499429", # old 1024bit
      ]
    end

    def all_products
      [
        "sentencepiece",
      ]
    end
  end

  repository_task = GroongaRepositoryTask.new(groonga_repository)
  repository_task.define
end
