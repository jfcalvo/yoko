module Yoko
  class << self
    def window
      @window ||= SDL2::Video::Window.new(
        Yoko::Config::Window.title,
        SDL2::Video::Window::SDL_WINDOWPOS_CENTERED,
        SDL2::Video::Window::SDL_WINDOWPOS_CENTERED,
        Yoko::Config::Window.width,
        Yoko::Config::Window.height,
        SDL2::Video::Window::SDL_WINDOW_SHOWN
      )
    end

    def renderer
      @renderer ||= SDL2::Video::Renderer.new(
        window,
        -1,
        SDL2::Video::Renderer::SDL_RENDERER_ACCELERATED |
        SDL2::Video::Renderer::SDL_RENDERER_PRESENTVSYNC
      )
    end

    def loop
      SDL2::init(SDL2::SDL_INIT_VIDEO|SDL2::SDL_INIT_EVENTS|SDL2::SDL_INIT_TIMER)

      @load_proc.call if @load_proc

      # Constant speed implementation
      skip_ticks = 1000 / Yoko::Config::Graphics.fps
      next_tick = SDL2::Timer.ticks
      sleep_time = 0

      until @quit
        Yoko::Input.poll

        Yoko.renderer.clear

        @update_proc.call if @update_proc # Update callback

        @draw_proc.call if @draw_proc # Draw callback

        Yoko::Input::Mouse.draw # Drawing mouse in front of every other graphic

        Yoko.renderer.present

        # Constant speed implementation
        next_tick += skip_ticks
        sleep_time = next_tick - SDL2::Timer.ticks

        SDL2::Timer.delay(sleep_time) if sleep_time > 0
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
