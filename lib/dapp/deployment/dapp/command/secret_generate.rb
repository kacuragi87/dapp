module Dapp
  module Deployment
    module Dapp
      module Command
        module SecretGenerate
          def deployment_secret_generate
            raise Error::Command, code: :secret_key_not_found if secret.nil?
            unless (data = $stdin.gets(nil)).nil?
              puts unless data.end_with?("\n")
              puts secret.generate(data)
            end
          end
        end
      end
    end
  end
end
