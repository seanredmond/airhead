module Herakles
  module Output
    class Simple
      include Herakles::Erbable

      def initialize(header_style, files)
        @header_style = header_style
        @files = files
        @tpl_dir = File.join(File.dirname(__FILE__), 'templates')
        @html_t = self.load_erb(@tpl_dir, 'simple-html.erb')
      end

      def render
        @header = YAML.load_file('header.yml')
        if @header_style == 'reduced'
          @h = Herakles::Header::Reduced.new(@header)
        else
          @h = Herakles::Header::Header.new(@header)
        end

        puts @html_t

        @files[:html].puts @html_t.result binding
      end
    end
  end
end
