dep 'core software' do
  requires [ 
    'sudo.bin',
    'vim.bin',
    'htop.bin',
    'traceroute.bin',
    'libxml.lib',
    'libxslt.lib',
    'monit.bin'
  ]
end

dep "vim.bin"

dep "htop.bin"

dep "traceroute.bin"

dep "libxml.lib" do
  installs { via :apt, 'libxml2-dev'}
end

dep "libxslt.lib" do
  installs { via :apt, 'libxslt1-dev' }
end

dep "monit.bin"
