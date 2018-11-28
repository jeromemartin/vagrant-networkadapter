module Vagrant
  module NetworkAdapter
    class Config < Vagrant.plugin('2', :config)
      attr_accessor :switchname
      attr_accessor :name

      def initialize
        @switchname = UNSET_VALUE
        @name = UNSET_VALUE
      end

      def is_set?
        @switchname != UNSET_VALUE 
        @name != UNSET_VALUE 
      end
    end
  end
end

