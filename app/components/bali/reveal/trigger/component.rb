# frozen_string_literal: true

module Bali
  module Reveal
    module Trigger
      class Component < ApplicationViewComponent
        attr_reader :title, :options

        def initialize(title:, show_border: true, **options)
          @title = title
          @title_class = options.delete(:title_class)
          @icon_class = options.delete(:icon_class)

          @options = prepend_class_name(options, 'reveal-trigger')
          @options = prepend_action(@options, 'click->reveal#toggle')

          @options = prepend_class_name(options, 'is-border-bottom') if show_border
        end
      end
    end
  end
end
