Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. For a detailed explanation
  # and listing of configuration options, please view the documentation
  # online.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "lucid32"
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  # Pass custom arguments to VBoxManage before booting VM
  config.vm.customize [
    # 'modifyvm', :id, '--chipset', 'ich9', # solves kernel panic issue on some host machines
    # '--uartmode1', 'file', 'C:\\base6-console.log' # uncomment to change log location on Windows
    "setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"
  ]

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("vagrant_main")
    chef.json.merge!({
    :mysql => {
      :server_root_password => "root"
    }
  })
  end

  config.vm.forward_port(80, 8080)
end
