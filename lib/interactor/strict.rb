module Interactor
  module Strict
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include Hooks

        # Public: Gets the Interactor::Context of the Interactor instance.
        attr_reader :context
      end
    end

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
