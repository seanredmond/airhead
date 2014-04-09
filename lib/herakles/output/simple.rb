module Herakles
  module Output
    class Simple
      include Herakles::Erbable

      def initialize(header_style, files)
        @header_style = header_style
        @files = files
        @css_includes = css_includes(@files)
        @tpl_dir = File.join(File.dirname(__FILE__), 'templates')
        @html_t = self.load_erb(@tpl_dir, 'simple-html.erb')
      end

      def css_includes(files)
        if files[:css_include].nil?
          return nil
        end

        files[:css_include].map{|css|
          %Q|<link rel="stylesheet" href="#{css}">|
        }.join("\n")
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
