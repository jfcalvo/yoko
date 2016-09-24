module Yoko
  module Animable
    def update_easings
      easings.each do |attribute, easing|
        easing.alive? ? easing.resume : easings.delete(attribute)
      end
    end

    def animate(attribute, final_position, duration, options = {}, &block)
      beginning = send(attribute)
      change = final_position - beginning
      initial_time = SDL2::Timer.ticks
      easing = options.fetch(:easing, :linear)

      easings[attribute] = Fiber.new do
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

        block.call(self) if block
      end
    end

    def animating?(attribute=nil)
      attribute ? easings.has_key?(attribute) : !easings.empty?
    end

    private

    def easings
      @easings ||= {}
    end
  end
end
