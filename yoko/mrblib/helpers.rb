def set_fullscreen(mode)
  Yoko::Window.fullscreen = mode
end

def key_pressed?(scancode_name)
  Yoko::Input::Keyboard.key_pressed? scancode_name
end

def load_sprite(filename)
  Yoko::Sprite.new(filename)
end

def window
  Yoko::Config::Window
end

def mouse
  Yoko::Input::Mouse
end

## Callbacks

def config(&block)
  Yoko.config(&block)
end

def load(&block)
  Yoko.load(&block)
end

def update(&block)
  Yoko.update(&block)
end

def draw(&block)
  Yoko.draw(&block)
end

def quit(&block)
  Yoko.quit(&block)
end
