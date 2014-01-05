module Hydra
  module Header
    class Reduced < Header
      def initialize(cfg)
        @cfg = cfg
        @template = load_erb('header-reduced.erb')
        @search = load_erb('search-reduced.erb')
      end
    end
  end
end

