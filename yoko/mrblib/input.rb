module Yoko
  module Input
    class << self
      def poll
        while event = SDL2::Input.poll
          case event.type
          when SDL2::Input::SDL_KEYDOWN
            Yoko::Input::Keyboard.key_pressed(keyboard_key_name(event))
          when SDL2::Input::SDL_KEYUP
            Yoko::Input::Keyboard.key_released(keyboard_key_name(event))
          when SDL2::Input::SDL_MOUSEMOTION
            Yoko::Input::Mouse.x = event.x
            Yoko::Input::Mouse.y = event.y
          when SDL2::Input::SDL_MOUSEBUTTONDOWN
            Yoko::Input::Mouse.button_pressed(mouse_button_name(event))
          when SDL2::Input::SDL_MOUSEBUTTONUP
            Yoko::Input::Mouse.button_released(mouse_button_name(event))
          when SDL2::Input::SDL_QUIT
            Yoko.quit
          end
        end
      end

      private

      def keyboard_key_name(event)
        SDL2::Input::Keyboard::scancode_name(event.keysym.scancode).downcase
      end

      def mouse_button_name(event)
        case event.button
        when SDL2::Input::SDL_BUTTON_LEFT then :left
        when SDL2::Input::SDL_BUTTON_RIGHT then :right
        when SDL2::Input::SDL_BUTTON_MIDDLE then :middle
        when SDL2::Input::SDL_BUTTON_X1 then :x1
        when SDL2::Input::SDL_BUTTON_X2 then :x2
        end
      end
    end
  end
end
