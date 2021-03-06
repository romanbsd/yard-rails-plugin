module YARD
  module Rails
    module Plugin
      class ControllerParamsHandler < YARD::Handlers::Ruby::Base
        handles(/params\[(:|')\w+'?\]/)
        def process
          return unless owner.is_a?(YARD::CodeObjects::MethodObject)
          return unless owner.parent.is_a?(YARD::CodeObjects::ClassObject)
          return unless owner.parent.to_s[/Controller/]
          matches = statement.source.scan(/params\[((:|')\w+'?)\]/)
          matches.each do |match|
            (owner[:params] ||= []) << match.first
          end
        end
      end
    end
  end
end
