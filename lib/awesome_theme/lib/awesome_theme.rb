# These should be dependencies
require "active_support/concern"

module Themes
  class Resolver < ActionView::Resolver
    def find_templates(name, details, prefix, partial)
      cached([name, details, prefix, partial]) do
        scope = Template.scoped(:conditions => { :name => name, :prefix => prefix })

        if formats = details[:formats]
          formats = formats.map { |f| f.to_s }
          scope = scope.scoped(:conditions => { :format => formats })
        end

        if locales = details[:locales]
          locales = locales.map { |f| f.to_s }
          scope = scope.scoped(:conditions => { :locale => locales })
        end

        scope.all.map do |r|
          handler = ActionView::Template.handler_class_for_extension(r.handler)
          details = { :locale => r.locale, :format => r.format, :partial => r.partial }
          ActionView::Template.new(r.source, "record", handler, details)
        end
      end
    end
  end

  module Awesomeness
    extend ActiveSupport::Concern

    included do
      view_paths.unshift Resolver.new
    end
  end
end