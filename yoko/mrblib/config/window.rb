module Yoko
  module Config
    class Window
      class << self
        attr_accessor :title, :width, :height, :fullscreen

        def title
          @title || 'Yoko'
        end

        def width
          @width || 640
        end

        def height
          @height || 480
        end

        def fullscreen
          @fullscreen || :windowed
        end
      end
    end
  end
end
