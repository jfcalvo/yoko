module Yoko
  module Easings
    def linear(time, beginning, change, duration)
      change * (time / duration.to_f) + beginning
    end

    def ease_in_quad(time, beginning, change, duration)
      change * (time /= duration.to_f) * time + beginning
    end

    def ease_out_quad(time, beginning, change, duration)
      -change * (time /= duration.to_f) * (time - 2) + beginning
    end

    def ease_in_out_quad(time, beginning, change, duration)
      if (time /= duration / 2.0) < 1
        change / 2.0 * time * time + beginning
      else
        -change / 2.0 * ((time -= 1) * (time - 2) - 1) + beginning
      end
    end

    alias ease_in ease_in_quad
    alias ease_out ease_out_quad
    alias ease_in_out ease_in_out_quad
  end
end
