module Vagrant
  module NetworkAdapter
    class Action

      class NetworkAdapterHyperV
        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @config = @machine.config.networkadapter
          @enabled = true
          @ui = env[:ui]
          if @machine.provider.to_s !~ /Hyper-V/
            @enabled = false
            provider = @machine.provider.to_s
            env[:ui].error "vagrant-networkadapter: plugin only supports HyperV at present: current is #{provider}."
          end
        end

        def call(env)
          network_adapters = @config.network_adapters
          # Create the adapter
          if @enabled
            network_adapters.each do |adap|
              if !adap.has_key?(:switchname) or !adap.has_key?(:name)
                env[:ui].error "vagrant-networkadapter: invalid network adapters configuration: missing 'name' or 'swichname'."
              else
                switchname = adap[:switchname]
                name = adap[:name]
                env[:ui].info "vagrant-networkadapter: Creating network adapter '#{name}' attached to switch '#{switchname}''"
    
                new_networkadapter(env, switchname, name)
              end
            end
          else
            env[:ui].warn "vagrant-networkadapter: not enabled."
          end

          # Allow middleware chain to continue so VM is booted
          @app.call(env)
        end

        private

        def new_networkadapter(env, switchname, name)
          driver = @machine.provider.driver
          options = {
            "VMID" => @machine.id,
            "SwitchName" => switchname,
            "Name" => name
          }
          s = File.join(File.dirname(__FILE__), 'scripts', 'add_vmnetworkadapter.ps1')
          driver.execute(s, options)
        end
      end
	  end
  end
end
