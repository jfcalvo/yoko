module Yoko
  class << self
    # Should these methods be protected?
    def window
      @window ||= SDL2::Video::Window.new(
        Yoko::Config::Window.title,
        SDL2::Video::Window::SDL_WINDOWPOS_CENTERED,
        SDL2::Video::Window::SDL_WINDOWPOS_CENTERED,
        Yoko::Config::Window.width,
        Yoko::Config::Window.height,
        SDL2::Video::Window::SDL_WINDOW_SHOWN);
    end

    def renderer
      @renderer ||= SDL2::Video::Renderer.new(window)
    end

    # Should this method be named init instead of loop?
    def loop
      SDL2::init

      @load_proc.call if @load_proc

      while !@quit
        Yoko::Input.poll

        Yoko.renderer.clear

        @update_proc.call if @update_proc # Update callback

        @draw_proc.call if @draw_proc # Draw callback

        Yoko::Input::Mouse.draw # Drawing mouse in front of every other graphic

        Yoko.renderer.present
      end

      @quit_proc.call if @quit_proc
    end

    def config
      yield Yoko::Config
    end

    def load(&block)
      @load_proc = block
    end

    def update(&block)
      @update_proc = block
    end

    def draw(&block)
      @draw_proc = block
    end

    def quit(&block)
      if block_given?
        @quit_proc = block
      else
        @quit = true
      end
    end
  end
end
