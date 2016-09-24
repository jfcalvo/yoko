module Yoko
  module Input
    class Mouse
      class << self
        attr_accessor :x, :y, :cursor

        def x
          @cursor.x if @cursor
        end

        def y
          @cursor.y if @cursor
        end

        def x=(new_x)
          @cursor.x = new_x if @cursor
        end

        def y=(new_y)
          @cursor.y = new_y if @cursor
        end

        def cursor=(new_cursor)
          if new_cursor.is_a? Yoko::Sprite
            SDL2::Input::Mouse.cursor_hide
          end

          @cursor = new_cursor
        end

        def draw
          @cursor.draw if @cursor
        end

        def button_pressed(button_name)
          mouse_state[button_name] = true
        end

        def button_released(button_name)
          mouse_state[button_name] = false
        end

        def button_pressed?(button_name)
          mouse_state[button_name] == true
        end

        def mouse_state
          @mouse_state ||= {}
        end
      end
    end
  end
end
