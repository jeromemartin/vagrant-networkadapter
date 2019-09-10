begin
  require 'vagrant'
rescue LoadError
  raise 'The vagrant-networkadapter plugin must be run within vagrant.'
end


module Vagrant
  module NetworkAdapter
    class Plugin < Vagrant.plugin('2')

      name 'vagrant-networkadapter'

      description <<-DESC
      Provides the ability to add new Hyper-V network adapter at creation time.
      DESC

      config 'networkadapter' do
        require_relative 'vagrant-networkadapter/config'
        Config
      end

      action_hook(:networkadapter_add, :machine_action_up) do |hook|
        require_relative 'vagrant-networkadapter/actions'
        hook.after(VagrantPlugins::HyperV::Action::Configure, Action::NetworkAdapterAddHyperV)
      end
	  
      action_hook(:networkadapter_rename, :machine_action_up) do |hook|
        require_relative 'vagrant-networkadapter/actions'
		hook.before(Action::NetworkAdapterAddHyperV, Action::NetworkAdapterRenameHyperV)
      end

      action_hook(:networkadapter_change, :provisioner_run) do |hook|
        require_relative 'vagrant-networkadapter/actions'
        hook.after(:run_provisioner, Action::NetworkAdapterChangeHyperV)
      end

	  action_hook(:networkadapter_changelast, :machine_action_provision) do |hook|
        require_relative 'vagrant-networkadapter/actions'
        hook.after(VagrantPlugins::HyperV::Action::Configure, Action::NetworkAdapterChangeLastHyperV)
      end
    end
  end
end
