module Entrance
  module Version
    extend self

    def major
      0
    end

    def minor
      0
    end

    def patch
      0
    end

    def to_s
      "#{major}.#{minor}.#{patch}"
    end
  end
end