module Vagrant
  module NetworkAdapter
    class Config < Vagrant.plugin('2', :config)
      def initialize
        @__network_adapters_added = []
        @__network_adapters_changed = []
        @__network_adapters_changedlast = []
		@__network_adapters_renamed = []
      end

      def add(**options)
        @__network_adapters_added << options.dup
      end

	  def rename(**options)
        @__network_adapters_renamed << options.dup
      end

      def change(**options)
        @__network_adapters_changed << options.dup
      end

      def changelast(**options)
        @__network_adapters_changedlast << options.dup
      end

      def network_adapters_added
          @__network_adapters_added
      end

      def network_adapters_renamed
          @__network_adapters_renamed
      end

      def network_adapters_changed
          @__network_adapters_changed
      end

	  def network_adapters_changedlast
          @__network_adapters_changedlast
      end

      def merge(other)
        super.tap do |result|
          result.instance_variable_set(:@__network_adapters_added, @__network_adapters_added + other.network_adapters_added)
		  result.instance_variable_set(:@__network_adapters_renamed, @__network_adapters_renamed + other.network_adapters_renamed)
          result.instance_variable_set(:@__network_adapters_changed, @__network_adapters_changed + other.network_adapters_changed)
		  result.instance_variable_set(:@__network_adapters_changedlast, @__network_adapters_changedlast + other.network_adapters_changedlast)
        end
      end
    end
  end
end

