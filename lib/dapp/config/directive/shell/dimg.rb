module Dapp
  module Config
    module Directive
      module Shell
        class Dimg < Directive::Base
          attr_reader :_version
          attr_reader :_before_install, :_before_setup, :_install, :_setup

          def version(value)
            @_version = value
          end

          [:before_install, :before_setup, :install, :setup].each do |stage|
            define_method stage do |&blk|
              unless instance_variable_get("@_#{stage}")
                instance_variable_set("@_#{stage}", StageCommand.new(&blk))
              end
              instance_variable_get("@_#{stage}")
            end

            define_method "_#{stage}_command" do
              return [] if (variable = instance_variable_get("@_#{stage}")).nil?
              variable._command
            end

            define_method "_#{stage}_version" do
              return [] if (variable = instance_variable_get("@_#{stage}")).nil?
              variable._version || _version
            end
          end

          protected

          class StageCommand < Directive::Base
            attr_reader :_version
            attr_reader :_command

            def initialize
              @_command = []
              super
            end

            def command(*args)
              @_command.concat(args)
            end

            def version(value)
              @_version = value
            end
          end
        end
      end
    end
  end
end