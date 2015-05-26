module Spine
  module Routing
    module Engine
      module Loader
        extend self

        def call(app)
          require app.root.join('config', 'routes')
          app.builder.run(app.router)
        end
      end
    end
  end
end
