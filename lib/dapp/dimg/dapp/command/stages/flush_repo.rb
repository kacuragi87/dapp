module Dapp
  module Dimg
    module Dapp
      module Command
        module Stages
          module FlushRepo
            def stages_flush_repo(repo)
              lock_repo(repo) do
                log_step_with_indent(repo) do
                  registry = registry(repo)
                  repo_dimgs, repo_stages = repo_dimgs_and_cache(registry)
                  repo_dimgs.merge(repo_stages).keys.each { |image_tag| delete_repo_image(registry, image_tag) }
                end
              end
            end
          end
        end
      end
    end
  end # Dimg
end # Dapp
