module Yoko
  class Image
    attr_reader :rect
    attr_accessor :x, :y, :width, :height, :angle, :center_x, :center_y

    def initialize(filename)
      @surface = SDL2::Video::Surface.load_img(Yoko::Tools.expand_path(filename))
      @texture = SDL2::Video::Texture.new(Yoko.renderer, @surface)
      @angle = 0.0
      @width = @surface.clip_rect.w
      @height = @surface.clip_rect.h
      @rect = SDL2::Rect.new(0, 0, @width, @height)
    end

    def draw
      Yoko.renderer.copy_ex(@texture, nil, @rect, angle, @angle_center)
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

    def center_x
      @angle_center.x if @angle_center
    end

    def center_x=(new_center_x)
      angle_center.x = new_center_x
    end

    def center_y
      @angle_center.y if @angle_center
    end

    def center_y=(new_center_y)
      angle_center.y = new_center_y
    end

    def alpha
      @texture.alpha_mod
    end

    def alpha=(new_alpha)
      @texture.alpha_mod = new_alpha
    end

    private

    def angle_center
      @angle_center ||= SDL2::Point.new
    end
  end
end
