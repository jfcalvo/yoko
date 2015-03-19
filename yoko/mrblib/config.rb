module Yoko
  module Config
    class << self
      def graphics
        Yoko::Config::Graphics
      end

      def window
        Yoko::Config::Window
      end

      def audio
        Yoko::Config::Audio
      end
    end
  end
end
