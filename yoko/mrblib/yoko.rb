module Yoko
  class << self
    def loop
      SDL2::init(SDL2::SDL_INIT_VIDEO|SDL2::SDL_INIT_EVENTS|SDL2::SDL_INIT_TIMER)

      if Yoko::Config::Graphics.scale_quality
        SDL2::Hints.set(
          SDL2::Hints::SDL_HINT_RENDER_SCALE_QUALITY,
          Yoko::Config::Graphics.scale_quality
        )
      end

      if Yoko::Config::Window.fullscreen == :desktop
        Yoko::Renderer.instance.set_logical_size(
          Yoko::Config::Window.width,
          Yoko::Config::Window.height
        )
      end

      @load_proc.call if @load_proc

      # Constant speed implementation
      skip_ticks = 1000 / Yoko::Config::Graphics.fps
      next_tick = SDL2::Timer.ticks
      sleep_time = 0

      until @quit
        Yoko::Input.poll

        Yoko::Renderer.instance.clear

        @update_proc.call if @update_proc # Update callback

        @draw_proc.call if @draw_proc # Draw callback

        Yoko::Input::Mouse.draw # Drawing mouse in front of every other graphic

        Yoko::Renderer.instance.present

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
