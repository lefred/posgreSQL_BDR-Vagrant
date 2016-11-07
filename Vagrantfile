Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = false
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.vm.define :pgsql1 do |pgsql1_config|
        pgsql1_config.vm.box = "lefred14/centos7_64"
        pgsql1_config.vm.hostname = "pgsql1"
        #pgsql1_config.ssh.max_tries = 100
        pgsql1_config.vm.provider :virtualbox do |pgsql1_vb|
                pgsql1_vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50", "--memory", "256", "--ioapic", "on"]
                #pgsql1_vb.gui = true
        end
        pgsql1_config.vm.network :private_network, ip: "192.168.91.2"
        pgsql1_config.vm.network :forwarded_port, guest: 22, host: 1234
        pgsql1_config.vm.provision :puppet do |pgsql1_puppet|
                #pgsql1_puppet.pp_path = "/tmp/vagrant-puppet"
                pgsql1_puppet.environment_path     = "puppet"
                pgsql1_puppet.environment          = "development"
                pgsql1_puppet.manifests_path = "puppet/environments/development/manifests"
                pgsql1_puppet.module_path = "puppet/environments/development/modules"
                pgsql1_puppet.hiera_config_path = "hiera.yaml"

                pgsql1_puppet.manifest_file = "site.pp"
                pgsql1_puppet.options = "--verbose --debug"
                #pgsql1_puppet.options = "--verbose"
        end
  end
  config.vm.define :pgsql2 do |pgsql2_config|
        pgsql2_config.vm.box = "lefred14/centos7_64"
        pgsql2_config.vm.hostname = "pgsql2"
        #pgsql2_config.ssh.max_tries = 100
        #pgsql1_config.vm.boot_mode = :gui
        pgsql2_config.vm.provider :virtualbox do |pgsql2_vb|
                pgsql2_vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50", "--memory", "256", "--ioapic", "on"]
        end
        pgsql2_config.vm.network :private_network, ip: "192.168.91.3"
        pgsql2_config.vm.provision :puppet do |pgsql2_puppet|
                #pgsql2_puppet.pp_path = "/tmp/vagrant-puppet"
                pgsql2_puppet.environment_path     = "puppet"
                pgsql2_puppet.environment          = "development"
                pgsql2_puppet.manifests_path = "puppet/environments/development/manifests"
                pgsql2_puppet.module_path = "puppet/environments/development/modules"
                pgsql2_puppet.manifest_file = "site.pp"
                #pgsql2_puppet.options = "--verbose"
                pgsql2_puppet.options = "--verbose --debug"
		pgsql2_puppet.hiera_config_path = "hiera.yaml"
        end
  end
  config.vm.define :pgsql3 do |pgsql3_config|
        pgsql3_config.vm.box = "lefred14/centos7_64"
        pgsql3_config.vm.hostname = "pgsql3"
        #pgsql3_config.ssh.max_tries = 100
        #pgsql1_config.vm.boot_mode = :gui
        pgsql3_config.vm.provider :virtualbox do |pgsql3_vb|
                pgsql3_vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50", "--memory", "256", "--ioapic", "on"]
        end
        pgsql3_config.vm.network :private_network, ip: "192.168.91.4"
        pgsql3_config.vm.provision :puppet do |pgsql3_puppet|
                #pgsql3_puppet.pp_path = "/tmp/vagrant-puppet"
                pgsql3_puppet.environment_path     = "puppet"
                pgsql3_puppet.environment          = "development"
                pgsql3_puppet.manifests_path = "puppet/environments/development/manifests"
                pgsql3_puppet.module_path = "puppet/environments/development/modules"
                pgsql3_puppet.manifest_file = "site.pp"
                pgsql3_puppet.options = "--verbose"
		pgsql3_puppet.hiera_config_path = "hiera.yaml"
        end
  end
  config.vm.define :pgsql4 do |pgsql4_config|
        pgsql4_config.vm.box = "lefred14/centos7_64"
        pgsql4_config.vm.hostname = "pgsql4"
        pgsql4_config.vm.provider :virtualbox do |pgsql4_vb|
                pgsql4_vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50", "--memory", "256", "--ioapic", "on"]
        end
        pgsql4_config.vm.network :private_network, ip: "192.168.91.5"
        pgsql4_config.vm.network :forwarded_port, guest: 80, host: 8080
        pgsql4_config.vm.provision :puppet do |pgsql4_puppet|
                pgsql4_puppet.environment_path     = "puppet"
                pgsql4_puppet.environment          = "development"
                pgsql4_puppet.manifests_path = "puppet/environments/development/manifests"
                pgsql4_puppet.module_path = "puppet/environments/development/modules"
                pgsql4_puppet.manifest_file = "site.pp"
                pgsql4_puppet.options = "--verbose"
		pgsql4_puppet.hiera_config_path = "hiera.yaml"
        end
  end
end

