require 'refinerycms-core'
require 'responders'
require 'rabl'

module Refinery
  autoload :ApiGenerator, 'generators/refinery/api/api_generator'

  module Api
    require 'refinery/api/engine'
    require 'refinery/api/configuration'

    autoload :Version, 'refinery/api/version'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end