module Vagrant
  module NetworkAdapter
    class Config < Vagrant.plugin('2', :config)
      def initialize
        @__network_adapters = []
      end

      def add(**options)
        @__network_adapters << options.dup
      end

      def network_adapters
          @__network_adapters
      end

      def merge(other)
        super.tap do |result|
          result.instance_variable_set(:@__network_adapters, @__network_adapters + other.network_adapters)
        end
      end
    end
  end
end

