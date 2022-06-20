# frozen_string_literal: true

module Bali
  module Notification
    class Component < ApplicationViewComponent
      attr_reader :options

      #
      # Notification Component with different type of notification.
      #
      # @param [<Symbol>] type This adds a class for the notification: :success, :danger
      # @param [<Integer>] miliseconds_to_close How long the notification will be shown.
      # @param [<Hash>] options This adds a custom attributes to the component.

      def initialize(type: :success, miliseconds_to_close: 3000, **options)
        @options = options

        @options = prepend_class_name(@options, "notification is-#{type}")
        @options = prepend_class_name(@options, 'notification-component notification')
        @options = prepend_controller(@options, 'notification')
        @options = prepend_data_attribute(@options, 'notification-delay-value',
                                          miliseconds_to_close)
        @options = prepend_data_attribute(@options, 'turbo-cache', false)
      end
    end
  end
end
