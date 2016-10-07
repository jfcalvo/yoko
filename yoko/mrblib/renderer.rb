module Yoko
  class Renderer
    class << self
      def instance
        @renderer ||= SDL2::Video::Renderer.new(Yoko::Window.instance, -1, renderer_flags)
      end

      def set_draw_color(red, green, blue)
        instance.draw_color = SDL2::RGBA.new(red, green, blue, 255)
      end

      private

      def renderer_flags
        renderer_flags = SDL2::Video::Renderer::SDL_RENDERER_ACCELERATED

        if Yoko::Config::Graphics.vsync
          renderer_flags |= SDL2::Video::Renderer::SDL_RENDERER_PRESENTVSYNC
        end

        renderer_flags
      end
    end
  end
end
