require 'delegate'

module Spine
  module Routing
    class Route
      VARIABLES_PATTERN = /\:([a-zA-Z0-9_-]+)/.freeze
      WILDCARD_PATTERN = /\*([a-zA-Z0-9_-]+)/.freeze
      EMPTY_WILDCARD_PATTERN = /\*(\/|\Z)/.freeze

      attr_reader :name, :pattern, :app, :verb

      def initialize(name, pattern, app, verb)
        @name = name
        @pattern = pattern
        @app = app
        @verb = verb
      end

      def match(verb, path)
        return nil unless verb == self.verb

        matches = path.match(regex)
        return nil unless matches

        Match.new(self, Hash[matches.names.map(&:to_sym).zip(matches.captures)])
      end

      private

      def regex
        @regex ||= compile
      end

      def compile
        Regexp.new("\\A#{ prepare }\/?\\Z")
      end

      def prepare
        add_format(
          pattern
            .gsub(EMPTY_WILDCARD_PATTERN, '*paths\1')
            .gsub(WILDCARD_PATTERN,'(?<\1>[^.$]+)')
            .gsub(VARIABLES_PATTERN, '(?<\1>[^./$]+)')
        )
      end

      def add_format(path)
        path + '(?:\.(?<format>.*))?'
      end

      class Match < SimpleDelegator
        attr_reader :parameters

        def initialize(route, parameters)
          super(route)
          @parameters = parameters
        end
      end
    end
  end
end
