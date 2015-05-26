module Spine
  module Routing
    module Engine
      module Configuration
        def router
          @router ||= Router.new
        end

        def routes(&block)
          router.configure &block if block_given?
          router
        end
      end
    end
  end
end
