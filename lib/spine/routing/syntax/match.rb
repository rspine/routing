module Spine
  module Routing
    module Syntax
      module Match
        def match(pattern, options)
          add(build(pattern.to_s, options))
        end
      end
    end
  end
end
