module Spine
  module Routing
    module Engine
      autoload :Configuration, 'spine/routing/engine/configuration'
      autoload :Loader, 'spine/routing/engine/loader'

      extend self

      def configuration
        Configuration
      end

      def loader
        Loader
      end
    end
  end
end
