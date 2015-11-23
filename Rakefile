require "rake"

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
