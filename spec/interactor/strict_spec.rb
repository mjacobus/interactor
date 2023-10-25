# frozen_string_literal: true

require "interactor/strict"

RSpec.describe Interactor::Strict do
  describe "keyword arguments" do
    context "when they are defined" do
      let(:service_class) do
        Class.new do
          include Interactor
          include Interactor::Strict

          before :before_one
          before :before_two
          after :after_one
          after :after_two

          def call(foo:, bar:, with_default: 'default')
            context.args = [foo, bar, with_default]
          end

          def before_one
            context.hooks = ["before_one"]
          end

          def before_two
            context.hooks << "before_two"
          end

          def after_one
            context.hooks << "after_one"
          end

          def after_two
            context.hooks << "after_two"
          end
        end
      end

      it "works when all keyword arguments are passed" do
        context = service_class.call(foo: "the-foo", bar: "the-bar")

        expect(context.args).to eq(%w[the-foo the-bar default])
      end

      it "works with regular hooks" do
        context = service_class.call(foo: "the-foo", bar: "the-bar")

        expect(context.hooks).to eq(%w[before_one before_two after_two after_one])
      end

      it "raises when keyword arguments are not properly passed" do
        expect { service_class.call(foo: "the-foo") }.to raise_error(ArgumentError)
      end
    end
  end
end
