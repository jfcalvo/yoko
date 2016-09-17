module Yoko
  class Sprite
    include Yoko::Easings

    attr_reader :rect
    attr_accessor :x, :y, :width, :height, :scale, :angle, :alpha, :center_x, :center_y

    def initialize(filename, options = {})
      @surface = SDL2::Video::Surface.load_img(Yoko::Tools.expand_path(filename))
      @texture = SDL2::Video::Texture.new(Yoko.renderer, @surface)
      @angle = options.fetch(:angle, 0.0)
      @scale = options.fetch(:scale, 1)
      @width = @surface.clip_rect.w * @scale
      @height = @surface.clip_rect.h * @scale
      @rect = SDL2::Rect.new(0, 0, @width, @height)
      @easings = {}

      self.alpha = options[:alpha] if options[:alpha]
    end

    def draw
      @easings.each do |attribute, easing|
        easing.alive? ? easing.resume : @easings.delete(attribute)
      end

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

    def scale
      @scale
    end

    def scale=(new_scale)
      @scale = new_scale
      self.width = @surface.clip_rect.w * @scale
      self.height = @surface.clip_rect.h * @scale
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

    def animate(attribute, final_position, duration, options = {})
      beginning = send(attribute)
      change = final_position - beginning
      initial_time = SDL2::Timer.ticks
      easing = options.fetch(:easing, :linear)

      @easings[attribute] = Fiber.new do
        while send(attribute) != final_position
          time = SDL2::Timer.ticks - initial_time

          if time > duration
            new_position = final_position
          else
            new_position = send(easing, time, beginning, change, duration)
          end

          send("#{attribute}=", new_position)

          Fiber.yield
        end
      end
    end

    private

    def angle_center
      @angle_center ||= SDL2::Point.new
    end
  end
end
