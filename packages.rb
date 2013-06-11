dep "htop.bin"

dep "libxml.lib" do
  installs { via :apt, 'libxml2-dev'}
end

dep "libxslt.lib" do
  installs { via :apt, 'libxslt1-dev' }
end

dep "monit.bin"

dep "nginx.bin"

dep "searchd.bin" do
  installs { via :apt, 'sphinxsearch' }
end

dep "traceroute.bin"

dep "vim.bin"
