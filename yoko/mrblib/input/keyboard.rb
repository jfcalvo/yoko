module Yoko
  module Input
    class Keyboard
      class << self
        def key_pressed(key_name)
          keyboard_state[key_name.to_s] = true
        end

        def key_released(key_name)
          keyboard_state[key_name.to_s] = false
        end

        def key_pressed?(key_name)
          keyboard_state[key_name.to_s] == true
        end

        def keyboard_state
          @keyboard_state ||= {}
        end
      end
    end
  end
end
