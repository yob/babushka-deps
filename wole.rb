dep 'provision wole' do
  requires [ 
    'sudo.bin',
    'vim.bin',
    'htop.bin',
    'traceroute.bin',
    'libxml.lib',
    'libxslt.lib',
    'monit.bin',
    'searchd.bin',
    'nginx.bin',

    'user exists'.with(:username => "rainbowbooks.com.au"),
    'app env vars set'.with(:username => "rainbowbooks.com.au", :env => 'production'),
    'clone repo'.with(:remote => "git@github.com:yob/rba.git", :path => '/srv/rainbowbooks.com.au/current', :username => "rainbowbooks.com.au")
  ]
end

dep 'clone repo', :remote, :path, :username do
  requires 'git.bin'
  met? {
    sudo("ls -l #{path} | wc -l", :as => username).to_i > 0
  }

  meet {
    sudo("git clone #{remote} \"#{path}\"", :as => username)
  }
end

dep 'admins can sudo' do
  requires 'admin group'
  met? {
    !'/etc/sudoers'.p.read.split("\n").grep(/^%admin\b/).empty?
  }
  meet {
    '/etc/sudoers'.p.append("%admin  ALL=(ALL) ALL\n")
  }
end

dep 'admin group' do
  met? { '/etc/group'.p.grep(/^admin\:/) }
  meet { sudo 'groupadd admin' }
end

dep 'user exists', :username, :home_dir_base do
  home_dir_base.default(username['.'] ? '/srv' : '/home')

  requires [ 'admin group', 'admins can sudo']
  met? {
    '/etc/passwd'.p.grep(/^#{username}:/)
  }
  meet {
    shell "mkdir -p #{home_dir_base}" and
    shell "useradd -m -s /bin/bash -b #{home_dir_base} -G admin #{username}" and
    shell "chmod 701 #{home_dir_base / username}"
  }
end
