module Spine
  module Routing
    autoload :Route, 'spine/routing/route'
    autoload :Router, 'spine/routing/router'
    autoload :NestedRouter, 'spine/routing/nested_router'

    module Syntax
      autoload :Match, 'spine/routing/syntax/match'
      autoload :Verbs, 'spine/routing/syntax/verbs'
      autoload :Namespacing, 'spine/routing/syntax/namespacing'
    end

    autoload :Parameters, 'spine/routing/parameters'
    autoload :Engine, 'spine/routing/engine'
  end
end
