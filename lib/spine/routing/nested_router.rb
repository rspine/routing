module Spine
  module Routing
    class NestedRouter < Router
      attr_reader :parent

      def initialize(path, parent)
        @path = path
        @parent = parent
      end

      def add(route)
        parent.add(route)
      end

      def build(pattern, options)
        parent.build([@path, normalize_path(pattern)].join, options)
      end
    end
  end
end
