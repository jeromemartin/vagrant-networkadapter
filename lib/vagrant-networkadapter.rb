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

      action_hook(:networkadapter, :machine_action_up) do |hook|
        require_relative 'vagrant-networkadapter/actions'
        hook.after(VagrantPlugins::HyperV::Action::Configure, Action::NetworkAdapterHyperV)
      end
    end
  end
end
