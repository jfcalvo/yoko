module Yoko
  class Image
    attr_reader :rect
    attr_accessor :x, :y, :width, :height, :angle

    def initialize(filename)
      @surface = SDL2::Video::Surface::load_img(filename)
      @texture = SDL2::Video::Texture.new(Yoko.renderer, @surface)
      @angle = 0.0
      @width, @height = @surface.clip_rect.w, @surface.clip_rect.h
      @rect = SDL2::Rect.new(0, 0, @width, @height)
    end

    def draw
      Yoko.renderer.copy_ex(@texture, nil, @rect, angle)
    end

    def destroy
      # TODO
    end

    # We should add pixel level collision detector
    def collides_with?(other_image)
      @rect.has_intersection? other_image.rect
    end

    def x
      @rect.x
    end

    def x=(new_x)
      @rect.x = new_x
    end

    def y
      @rect.y
    end

    def y=(new_y)
      @rect.y = new_y
    end

    def width
      @rect.w
    end

    def width=(new_width)
      @rect.w = new_width
    end

    def height
      @rect.h
    end

    def height=(new_height)
      @rect.h = new_height
    end
  end
end
