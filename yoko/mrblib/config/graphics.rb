module Yoko
  module Config
    class Graphics
      class << self
        attr_accessor :fps

        def fps
          @fps || 60
        end
      end
    end
  end
end
