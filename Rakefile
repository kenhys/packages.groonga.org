require "rake"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
end

task :default => :spec

desc "Apply the Ansible configurations"
task :deploy do
  sh("ansible-playbook",
     "--inventory-file", "hosts",
     "ansible/playbook.yml")
end
