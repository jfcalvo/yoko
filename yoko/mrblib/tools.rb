module Yoko
  module Tools
    def self.expand_path(filename)
      File.expand_path(filename, File.dirname($0))
    end
  end
end
