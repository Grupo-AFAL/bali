# frozen_string_literal: true

module Bali
  module Dropdown
    class Component < ApplicationViewComponent
      renders_one :trigger, Trigger::Component
      renders_many :items, Item::Component

      def initialize(hoverable: false, close_on_click: true, align: :right, **options)
        @hoverable = hoverable
        @close_on_click = close_on_click
        @options = options

        @options = prepend_class_name(@options, 'is-right') if align == :right
        @options = prepend_class_name(@options, 'is-centered') if align == :center
        @options = prepend_class_name(@options, 'dropdown-component dropdown')
        @options = prepend_controller(@options, 'dropdown')
      end
    end
  end
end
