include_recipe "apache2"

include_recipe "apt"

include_recipe "git"
include_recipe "subversion"

pkgs = value_for_platform(
    ["centos","redhat","fedora"] =>
        {"default" => %w{ bzip2-devel libc-client-devel curl-devel freetype-devel gmp-devel libjpeg-devel krb5-devel libmcrypt-devel libpng-devel openssl-devel t1lib-devel mhash-devel libxml2-dev libtidy-dev libxslt1-dev re2c lemon wget}},
    [ "debian", "ubuntu" ] =>
        {"default" => %w{ libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev libkrb5-dev libmcrypt-dev libpng12-dev libssl-dev libt1-dev libxml2-dev libtidy-dev libxslt1-dev re2c lemon wget}},
    "default" => %w{ libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev libkrb5-dev libmcrypt-dev libpng12-dev libssl-dev libt1-dev libxml2-dev libtidy-dev libxslt1-dev re2c lemon wget}
  )

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

site_name = "dev-site"
site = {
  :name => site_name,
  :host => "www.#{site_name}.com",
  :aliases => ["#{site_name}.com", "dev.#{site_name}-static.com"]
}

# Configure the development site
web_app site[:name] do
  template "sites.conf.erb"
  server_name site[:host]
  server_aliases site[:aliases]
  docroot "/vagrant/public/"
end

# Add site info in /etc/hosts
bash "info_in_etc_hosts" do
  code "echo 127.0.0.1 #{site[:host]} #{site[:aliases]} >> /etc/hosts"
end

#install php env
bash "install_phpenv" do
  user "vagrant"
  cwd "/vagrant/src/phpenv/bin"
  code <<-EOH
  PHPENV_ROOT=/home/vagrant/.phpenv CHECKOUT=yes ./phpenv-install.sh
  echo PATH=/home/vagrant/.phpenv/bin:$PATH >> /home/vagrant/.profile
  EOH
end

#install bats
bash "install_bats" do
  user "vagrant"
  cwd "/vagrant/src"
  code <<-EOH
  git clone http://github.com/sstephenson/bats
  cd bats
  ./install.sh /usr/local
  exit 0
  EOH
end

# Retrieve webgrind for xdebug trace analysis
subversion "Webgrind" do
  repository "http://webgrind.googlecode.com/svn/trunk/"
  revision "HEAD"
  destination "/var/www/webgrind"
  action :sync
end