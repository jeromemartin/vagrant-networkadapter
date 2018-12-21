module Vagrant
  module NetworkAdapter
    class Config < Vagrant.plugin('2', :config)
      def initialize
        @__network_adapters_added = []
        @__network_adapters_changed = []
      end

      def add(**options)
        @__network_adapters_added << options.dup
      end

      def change(**options)
        @__network_adapters_changed << options.dup
      end

      def network_adapters_added
          @__network_adapters_added
      end

      def network_adapters_changed
          @__network_adapters_changed
      end

      def merge(other)
        super.tap do |result|
          result.instance_variable_set(:@__network_adapters_added, @__network_adapters_added + other.network_adapters_added)
          result.instance_variable_set(:@__network_adapters_changed, @__network_adapters_changed + other.network_adapters_changed)
        end
      end
    end
  end
end

