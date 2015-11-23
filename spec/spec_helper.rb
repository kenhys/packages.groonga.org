require "serverspec"
require "net/ssh"
require "tempfile"

set :backend, :ssh

if ENV["ASK_SUDO_PASSWORD"]
  require "highline/import"
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV["SUDO_PASSWORD"]
end

host = "packages.groonga.org"

system("vagrant", "up", host)
system("vagrant", "provision", host)

config = Tempfile.new('', Dir.tmpdir)
config.write(`vagrant ssh-config #{host}`)
config.close

options = Net::SSH::Config.for(host, [config.path])
options[:user] ||= Etc.getlogin
set :host,        options[:host_name] || host
set :ssh_options, options

# Disable sudo
# set :disable_sudo, true

# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
