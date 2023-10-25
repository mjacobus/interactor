require "interactor"

module Interactor
  module Strict
    def self.included(base)
      base.class_eval do
        include Interactor
        extend ClassMethods
        include InstanceMethods
      end
    end

    module InstanceMethods
      def initialize(*args, **kargs)
        unless args.empty?
          raise ArgumentError, "wrong number of arguments (given #{args.size}, expected 0)"
        end

        @kargs = kargs
        @context = Context.build(*args)
      end

      def run!
        with_hooks do
          call(**@kargs)
          context.called!(self)
        end
      rescue
        context.rollback!
        raise
      end
    end

    module ClassMethods
      def call(*args, **kargs)
        new(*args, **kargs).tap(&:run).context
      end

      def call!(*args, **kargs)
        new(*args, **kargs).tap(&:run!).context
      end
    end
  end
end
