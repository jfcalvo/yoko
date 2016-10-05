module Yoko
  module Config
    class Graphics
      class << self
        attr_accessor :fps, :vsync, :scale_quality

        def fps
          @fps || 60
        end

        def vsync
          @vsync.nil? ? true : @vsync
        end
      end
    end
  end
end
