module Herakles
  module Output
    class Simple
      include Herakles::Erbable

      def initialize(files)
        @files = files
        @tpl_dir = File.join(File.dirname(__FILE__), 'templates')
        @html_t = self.load_erb(@tpl_dir, 'simple-html.erb')
      end

      def render

        @header = YAML.load_file('header.yml')
        @h = Herakles::Header::Header.new(@header)

        puts @html_t

        @files[:html].puts @html_t.result binding
      end
    end
  end
end
