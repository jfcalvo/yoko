module Yoko
  module Input
    class << self
      def poll
        while event = SDL2::Input.poll
          case event.type
          when SDL2::Input::SDL_KEYDOWN
            Yoko::Input::Keyboard.keyboard_state[SDL2::Input::Keyboard::scancode_name(event.keysym.scancode).downcase] = true
          when SDL2::Input::SDL_KEYUP
            Yoko::Input::Keyboard.keyboard_state[SDL2::Input::Keyboard::scancode_name(event.keysym.scancode).downcase] = false
          when SDL2::Input::SDL_MOUSEMOTION
            Yoko::Input::Mouse.x = event.x
            Yoko::Input::Mouse.y = event.y
          when SDL2::Input::SDL_QUIT
            Yoko.quit
          end
        end
      end
    end
  end
end
