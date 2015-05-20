module Spine
  module Routing
    module Syntax
      module Namespacing
        def scope(path, &block)
          nested = NestedRouter.new(normalize_path(path.to_s), self)
          nested.instance_eval &block
          self
        end
      end
    end
  end
end
