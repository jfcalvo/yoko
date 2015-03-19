module Yoko
  module Input
    class Mouse
      class << self
        attr_accessor :x, :y, :cursor

        # I don't like to have an image as a mouse cursor.
        # We should use some sprite class (image + position) so we can use
        # image class that should not have position.
        def x
          @cursor.x if @cursor
        end

        def y
          @cursor.y if @cursor
        end

        def x=(new_x)
          @cursor.x = new_x if @cursor # Not very good idea to modify a image position to change mouse
        end

        def y=(new_y)
          @cursor.y = new_y if @cursor # Not very good idea to modify a image position to change mouse
        end

        def cursor=(new_cursor)
          if new_cursor.is_a? Yoko::Image
            SDL2::Input::Mouse.cursor_hide
          end

          @cursor = new_cursor
        end

        def draw
          @cursor.draw if @cursor
        end
      end
    end
  end
end
