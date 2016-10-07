module Yoko
  class Sprite
    include Yoko::Easings
    include Yoko::Animable

    attr_reader :rect
    attr_accessor(
      :x, :y,
      :width, :height,
      :scale, :scale_x, :scale_y,
      :angle,
      :center_x, :center_y,
      :alpha
    )

    def initialize(filename, options = {})
      @surface = SDL2::Video::Surface.load_img(Yoko::Tools.expand_path(filename))
      @texture = SDL2::Video::Texture.new(Yoko::Renderer.instance, @surface)
      @angle = options.fetch(:angle, 0.0)
      @scale = options.fetch(:scale, 1)
      @scale_x = options.fetch(:scale_x, 1)
      @scale_y = options.fetch(:scale_y, 1)
      @width = @surface.clip_rect.w * @scale
      @height = @surface.clip_rect.h * @scale
      @rect = SDL2::Rect.new(0, 0, @width, @height)
      @destroyed = false

      self.x = options[:x] if options[:x]
      self.y = options[:y] if options[:y]
      self.scale_x = options[:scale_x] if options[:scale_x]
      self.scale_y = options[:scale_y] if options[:scale_y]
      self.alpha = options[:alpha] if options[:alpha]
    end

    def draw
      return if @destroyed

      update_easings

      Yoko::Renderer.instance.copy_ex(@texture, nil, @rect, angle, @angle_center)
    end

    def destroy
      @surface.destroy
      @texture.destroy
      @destroyed = true
    end

    def destroyed?
      @destroyed
    end

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

    def scale=(new_scale)
      @scale = new_scale
      self.scale_x = @scale
      self.scale_y = @scale
    end

    def scale_x=(new_scale_x)
      @scale_x = new_scale_x
      self.width = @surface.clip_rect.w * @scale_x
    end

    def scale_y=(new_scale_y)
      @scale_y = new_scale_y
      self.height = @surface.clip_rect.h * @scale_y
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
