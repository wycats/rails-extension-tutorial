# These should be dependencies
require "active_support/concern"

module Themes
  module Awesomeness
    extend ActiveSupport::Concern

    included do
      view_paths.unshift(File.dirname(__FILE__) + "/views")
    end
  end
end