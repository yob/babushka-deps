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
    'nginx.bin'
  ]
end
