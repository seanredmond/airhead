module Hydra
  module Header
  class Header

    @@nav = ERB.new(<<erb, nil, '>')
<ul>
  <% menu.each do |item| %>
    <% if item['menu'].nil? %>
      <li>
    <% else %>
      <li class="dropDown">
    <% end %>
      <%= link_label(item) %>
      <%if ! item['menu'].nil? %>
        <div class="dropDownContent">
          <%= second_level(item['menu']) %>
        </div>
      <% end %>
    </li>
  <% end %>
</ul>
erb

  @@second_level = ERB.new(<<erb, nil, '>')
<ul>
  <% item.each do |i| %>
    <% if i['menu'].nil? %>
      <li><%= link_label(i) %></li>
    <% else %>
      <li>
        <h5><%= h(i['label']) %></h5>
        <%= second_level(i['menu']) %>
      </li>
    <% end %>
  <% end %>
  </ul>
erb

    @@link = ERB.new(
      %Q|<a href="<%= h(item['link']) %>"><%= h(item['label']) %></a>|
    )

    def initialize(cfg)
      @cfg = cfg
      @template = load_erb('header-full.erb')
      @@header_search = load_erb('header-search.erb').result
    end

    def nav_menu(menu)
      @@nav.result binding
    end

    def second_level(item)
      @@second_level.result binding
    end

    def link_label(item)
      @@link.result binding
    end

    def search_form
      @search.result binding
    end

    def result
      @template.result binding
    end

    def load_erb(file)
      ERB.new(
        File.read(File.join(File.dirname(__FILE__), 'templates', file))
      )
    end
  end
end
end
