# frozen_string_literal: true

module Bali
  module LocationsMap
    class Preview < ApplicationViewComponentPreview
      LOCATIONS = [
        { latitude: 32.52535328002182, longitude: -117.01662677673296 },
        { latitude: 32.528469988815075, longitude: -117.0197954175343, color: 'green' },
        { latitude: 32.53146597286308, longitude: -117.02884042070805, color: '#f98f00',
          glyph_color: '#feddae', border_color: '#ea6200' },
        { latitude: 32.52900375149942, longitude: -117.0356861180097, color: '#f98f00',
          glyph_color: 'white', border_color: '#ea6200', label: 1 },
        { latitude: 32.52284404972829, longitude: -117.0330700546029,
          icon_url: "https://maps.google.com/mapfiles/kml/paddle/blu-blank.png" }
      ].freeze

      # @param zoom number
      # @param clustered [Boolean]
      def default(zoom: 12, clustered: false)
        render Bali::LocationsMap::Component.new(zoom: zoom, clustered: clustered) do |c|
          LOCATIONS.each do |location_attrs|
            c.with_location(**location_attrs)
          end

          c.with_location(latitude: 32.516284591574724, longitude: -117.0129754500983) do |location|
            location.info_view { '<p>This is an info view</p>'.html_safe }
          end
        end
      end

      def with_cards(zoom: 12, clustered: false)
        render Bali::LocationsMap::Component.new(zoom: zoom, clustered: clustered) do |c|
          LOCATIONS.each_with_index do |location_attrs, index|
            c.with_card(**location_attrs) { "<p>Card #{index + 1}</p>".html_safe }

            c.with_location(**location_attrs)
          end

          c.with_card(latitude: 32.516284591574724, longitude: -117.0129754500983) do
            '<p>Card with info view</p>'.html_safe
          end

          c.with_location(latitude: 32.516284591574724, longitude: -117.0129754500983) do |location|
            location.info_view { '<p>This is an info view</p>'.html_safe }
          end
        end
      end
    end
  end
end
