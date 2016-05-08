# Maybe we should call this file sdl methods or something similar

def set_fullscreen(mode)
  Yoko.set_fullscreen(mode)
end

def key_pressed?(scancode_name)
  Yoko::Input::Keyboard.key_pressed? scancode_name
end

def load_image(filename)
  Yoko::Image.new(filename)
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
