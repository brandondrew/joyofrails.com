module Searches
  class Combobox < ApplicationComponent
    include Phlex::Rails::Helpers::TurboFrameTag
    include Phlex::Rails::Helpers::FormWith
    include PhlexConcerns::SvgTag

    attr_reader :pages, :query

    def initialize(query: "", pages: [])
      @pages = pages
      @query = query
    end

    def view_template
      div(
        class: "combobox grid gap-2",
        data: {
          controller: "search-combobox",
          action: "
            keydown->search-combobox#navigate
            search-listbox:connected->search-combobox#listboxOpen
          "
        }
      ) do
        form_with url: search_path,
          method: :post,
          data: {
            controller: "autosubmit-form",
            autosubmit_delay_value: 300,
            turbo_frame: :search
          } do |f|
          div(class: "flex items-center flex-row pl-2 col-gap-xs") do
            svg_tag "icons/search.svg", class: "w-[32px] fill-current text-theme"
            whitespace
            plain f.search_field :query,
              value: query,
              autofocus: true,
              role: "combobox",
              aria: {
                expanded: false,
                autocomplete: "none",
                controls: "search-listbox",
                activedescendant: nil
              },
              data: {
                action: "autosubmit-form#submit"
              },
              placeholder: "Search Joy of Rails",
              class: "w-full step-1"
          end
        end

        render Searches::Listbox.new(pages: pages, query: query)
      end
    end
  end
end
