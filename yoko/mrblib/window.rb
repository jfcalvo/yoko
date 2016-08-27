module Yoko
  class Window
    class << self
      def fullscreen=(mode)
        case mode
        when :desktop
          Yoko.window.fullscreen = SDL2::Video::Window::SDL_WINDOW_FULLSCREEN_DESKTOP
        when :exclusive
          Yoko.window.fullscreen = SDL2::Video::Window::SDL_WINDOW_FULLSCREEN
        when :windowed
          Yoko.window.fullscreen = 0
        else
          raise "Fullscreen mode `#{mode}` not valid."
        end
      end
    end
  end
end
