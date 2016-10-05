module Yoko
  class Window
    class << self
      def instance
        @window ||= SDL2::Video::Window.new(
          Yoko::Config::Window.title,
          SDL2::Video::Window::SDL_WINDOWPOS_CENTERED,
          SDL2::Video::Window::SDL_WINDOWPOS_CENTERED,
          Yoko::Config::Window.width,
          Yoko::Config::Window.height,
          window_flags
        )
      end

      def fullscreen=(mode)
        instance.fullscreen = fullscreen_flag(mode)

        case mode
        when :desktop
          Yoko::Renderer.instance.set_logical_size(
            Yoko::Config::Window.width,
            Yoko::Config::Window.height
          )
        when :windowed
          instance.size = SDL2::Size.new(
            Yoko::Config::Window.width,
            Yoko::Config::Window.height
          )
        end
      end

      private

      def window_flags
        SDL2::Video::Window::SDL_WINDOW_SHOWN | fullscreen_flag(Yoko::Config::Window.fullscreen)
      end

      def fullscreen_flag(mode)
        case mode
        when :desktop
          SDL2::Video::Window::SDL_WINDOW_FULLSCREEN_DESKTOP
        when :exclusive
          SDL2::Video::Window::SDL_WINDOW_FULLSCREEN
        when :windowed
          0
        else
          raise "Fullscreen mode `#{mode}` no valid."
        end
      end
    end
  end
end
