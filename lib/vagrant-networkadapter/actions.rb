module Vagrant
  module NetworkAdapter
    class Action

      class NetworkAdapterAddHyperV
        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @config = @machine.config.networkadapter
          @enabled = true
          @ui = env[:ui]
          if @machine.provider.to_s !~ /Hyper-V/
            @enabled = false
            provider = @machine.provider.to_s
            env[:ui].error "vagrant-networkadapter (add): plugin only supports HyperV at present: current is #{provider}."
          end
        end

        def call(env)
          network_adapters_added = @config.network_adapters_added
          # Create the adapter
          if @enabled
            network_adapters_added.each do |adap|
              if !adap.has_key?(:switchname) or !adap.has_key?(:name)
                env[:ui].error "vagrant-networkadapter (add): invalid network adapters configuration: missing 'name' or 'swichname'."
              else
                switchname = adap[:switchname].encode("ISO-8859-1")
                name = adap[:name].encode("ISO-8859-1")
                env[:ui].info "vagrant-networkadapter (add): Creating network adapter '#{name}' attached to switch '#{switchname}''"
    
                new_networkadapter(env, switchname, name)
              end
            end
          else
            env[:ui].warn "vagrant-networkadapter (add): not enabled."
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
	  
	  
	  class NetworkAdapterRenameHyperV
        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @config = @machine.config.networkadapter
          @enabled = true
          @ui = env[:ui]
          if @machine.provider.to_s !~ /Hyper-V/
            @enabled = false
            provider = @machine.provider.to_s
            env[:ui].error "vagrant-networkadapter (rename): plugin only supports HyperV at present: current is #{provider}."
          end
        end
		
        def call(env)
          network_adapters_renamed = @config.network_adapters_renamed
          # Create the adapter
          if @enabled
              network_adapters_renamed.each do |adap|
              if !adap.has_key?(:vmname) or !adap.has_key?(:newname)# or !adap.has_key?(:name)
                env[:ui].error "vagrant-networkadapter (rename): invalid network adapters configuration: missing 'vmname' or 'newname' or 'name'."
              else
                vmname = adap[:vmname].encode("ISO-8859-1")
                newname = adap[:newname].encode("ISO-8859-1")
				if adap.has_key?(:name) 
					name = adap[:name].encode("ISO-8859-1")
				else
					name = $false
				end
                env[:ui].info "vagrant-networkadapter (rename): Renaming network adapter '#{name}' to '#{newname}''"
    
                rename_networkadapter(env, vmname, newname, name)
              end
            end
          else
            env[:ui].warn "vagrant-networkadapter (rename): not enabled."
          end

          # Allow middleware chain to continue so VM is booted
          @app.call(env)
        end		
		
        private

        def rename_networkadapter(env, vmname, newname, name)
          driver = @machine.provider.driver
          options = {
            "VmName" => vmname,
            "NewName" => newname,
            "Name" => name
          }
          s = File.join(File.dirname(__FILE__), 'scripts', 'rename_vmnetworkadapter.ps1')
          driver.execute(s, options)
        end	
	  end
    
    
      class NetworkAdapterChangeHyperV
        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @config = @machine.config.networkadapter
          @enabled = true
          @ui = env[:ui]
          if @machine.provider.to_s !~ /Hyper-V/
            @enabled = false
            provider = @machine.provider.to_s
            env[:ui].error "vagrant-networkadapter (change): plugin only supports HyperV at present: current is #{provider}."
          end
        end

        def call(env)
          network_adapters_changed = @config.network_adapters_changed
          # Create the adapter
          if @enabled
              network_adapters_changed.each do |adap|
              if !adap.has_key?(:switchname)
                env[:ui].error "vagrant-networkadapter (change): invalid network adapters configuration: missing 'swichname'."
              else
                switchname = adap[:switchname].encode("ISO-8859-1")
				if adap.has_key?(:name) 
					name = adap[:name].encode("ISO-8859-1")
				else
					name = switchname
				end
                env[:ui].info "vagrant-networkadapter (change): Changing network adapter '#{name}' to switch '#{switchname}''"
    
                change_networkadapter(env, switchname, name)
              end
            end
          else
            env[:ui].warn "vagrant-networkadapter (change): not enabled."
          end

          # Allow middleware chain to continue so VM is booted
          @app.call(env)
        end

        private

        def change_networkadapter(env, switchname, name)
          driver = @machine.provider.driver
          options = {
            "VMID" => @machine.id,
            "SwitchName" => switchname,
            "Name" => name
          }
          s = File.join(File.dirname(__FILE__), 'scripts', 'change_vmnetworkadapter.ps1')
          driver.execute(s, options)
        end
      end
	  
	  
	  class NetworkAdapterChangeLastHyperV
        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @config = @machine.config.networkadapter
          @enabled = true
          @ui = env[:ui]
          if @machine.provider.to_s !~ /Hyper-V/
            @enabled = false
            provider = @machine.provider.to_s
            env[:ui].error "vagrant-networkadapter (changelast): plugin only supports HyperV at present: current is #{provider}."
          end
        end

        def call(env)
          network_adapters_changedlast = @config.network_adapters_changedlast
          # Create the adapter
          if @enabled
              network_adapters_changedlast.each do |adap|
              if !adap.has_key?(:switchname)
                env[:ui].error "vagrant-networkadapter (changelast): invalid network adapters configuration: missing 'swichname'."
              else
                switchname = adap[:switchname].encode("ISO-8859-1")
                name = adap[:name].encode("ISO-8859-1")
                env[:ui].info "vagrant-networkadapter (changelast): Changing network adapter '#{name}' to switch '#{switchname}''"
    
                changelast_networkadapter(env, switchname, name)
              end
            end
          else
            env[:ui].warn "vagrant-networkadapter (changelast): not enabled."
          end

          # Allow middleware chain to continue so VM is booted
          @app.call(env)
        end

        private

        def changelast_networkadapter(env, switchname, name)
          driver = @machine.provider.driver
          options = {
            "VMID" => @machine.id,
            "SwitchName" => switchname,
            "Name" => name
          }
          s = File.join(File.dirname(__FILE__), 'scripts', 'changelast_vmnetworkadapter.ps1')
          driver.execute(s, options)
        end
      end
    end
  end
end
