module Spine
  module Routing
    module Parameters
      def params
        env[Router::PARAMETERS]
      end
    end
  end
end
