module Spine
  module Routing
    module Syntax
      module Verbs
        def get(pattern, options)
          match(pattern, options.merge(verb: :get))
        end

        def post(pattern, options)
          match(pattern, options.merge(verb: :post))
        end

        def put(pattern, options)
          match(pattern, options.merge(verb: :put))
        end

        def patch(pattern, options)
          match(pattern, options.merge(verb: :patch))
        end

        def delete(pattern, options)
          match(pattern, options.merge(verb: :delete))
        end
      end
    end
  end
end
