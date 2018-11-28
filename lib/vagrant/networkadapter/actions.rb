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
            env[:ui].error "The vagrant-networkadapter plugin only supports HyperV at present: current is #{provider}."
          end
        end

        def call(env)
          # Create the adapter
          if @enabled and @config.is_set?
            switchname = @config.switchname
            name = @config.name
            env[:ui].info "call hyperv networkadapter: switch-name = #{switchname}/#{name}"

            new_networkadapter(env, switchname, name)
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
