# frozen_string_literal: true

module Bali
  module Link
    class Component < ApplicationViewComponent
      attr_reader :name, :href, :type, :drawer, :modal, :options

      renders_one :icon, ->(name, **options) { Icon::Component.new(name, **options) }

      #  @param name [String] The name of the link.
      #  @param href [String] The href of the link.
      #  @param type [Symbol|String] This adds a class for the link: :primary, :secondary,
      #  :success, :danger, :warning also adds the button class.
      #  @param modal [Boolean] Link to open a modal.
      #  @param drawer [Boolean] Link to open a drawer.
      #  @param active_path [String] The path of the active page.
      #  @param match [Symbol] To check if the path is exact or cotains the path.
      #  @param method [Symbol|String] Adds a turbo method to the link.

      # rubocop:disable Metrics/ParameterLists
      # rubocop:disable Metrics/AbcSize
      def initialize(href:,
                     name: '',
                     type: nil,
                     modal: false,
                     drawer: false,
                     active_path: nil,
                     match: :exact,
                     method: nil,
                     **options)

        @name = name
        @href = href
        @type = type.present? ? type.to_sym : type
        @modal = modal
        @active_path = active_path
        @drawer = drawer
        @method = method
        @options = options
        active_link(href, active_path, match: match) if active_path.present?
        @options = prepend_class_name(@options, "button is-#{type}") if type.present?
        @options = prepend_action(@options, 'modal#open') if modal
        @options = prepend_action(@options, 'drawer#open') if drawer
        @options = prepend_turbo_method(@options, method.to_s) if method.present?
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/ParameterLists

      def active_link(href, current_path, match: :exact)
        @options = prepend_class_name(@options, 'is-active') if active_path?(href, current_path,
                                                                             match: match)
      end
    end
  end
end
