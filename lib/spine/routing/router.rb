module Spine
  module Routing
    class Router
      include Syntax::Match
      include Syntax::Verbs
      include Syntax::Namespacing

      VERB = 'REQUEST_METHOD'.freeze
      PATH = 'PATH_INFO'.freeze
      PATH_PARAMETERS = 'router.parameters'.freeze
      NOT_FOUND_RESPONSE = [404, {}, ['']].freeze


      def routes
        @routes ||= [] # TODO: use set instead of array
      end

      def build(pattern, options)
        Route.new(
          '',
          normalize_path(pattern),
          options.fetch(:to),
          options.fetch(:verb)
        )
      end

      def configure(&block)
        instance_eval &block
      end

      def add(route)
        routes << route
      end

      def recognise(verb, path)
        routes.each do |route|
          match = route.match(verb, path)
          return match if match
        end
        nil
      end

      def call(env)
        verb = env[VERB].downcase.gsub('head', 'get').to_sym
        route = recognise(verb, env[PATH])
        if route
          env[PATH_PARAMETERS] = route.parameters
          run(route.app, env)
        else
          NOT_FOUND_RESPONSE # TODO: set default app
        end
      end

      def run(app, env)
        app.call(env)
      end

      protected

      def normalize_path(path)
        '/' + path.split('/')
          .map(&:strip)
          .select { |part| part && part != '' }
          .join('/')
      end
    end
  end
end
