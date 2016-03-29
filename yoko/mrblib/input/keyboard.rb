module Yoko
  module Input
    class Keyboard
      class << self
        def key_pressed?(scancode_name)
          keyboard_state[scancode_name.to_s] == true
        end

        def keyboard_state
          @keyboard_state ||= {}
        end
      end
    end
  end
end
