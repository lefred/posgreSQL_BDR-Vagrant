# PostgreSQL BDR from 2ndQuandrant Vagrant environement

run `make` to update the puppet modules

## setup

	$ make
	$ vagrant up pgsql1 --no-provision
	$ vagrant up pgsql2 --no-provision
	$ vagrant up pgsql3 --no-provision
	$ vagrant ssh pgsql1 -c "sudo iptables -F"
	$ vagrant ssh pgsql2 -c "sudo iptables -F"
	$ vagrant ssh pgsql3 -c "sudo iptables -F"
	$ vagrant provision

