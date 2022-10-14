# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bali::Link::Component, type: :component do
  let(:component) { Bali::Link::Component.new(**@options) }

  before { @options = { name: 'Click me!', href: '#' } }

  context 'default' do
    it 'renders' do
      render_inline(component)

      expect(page).to have_css 'a', text: 'Click me!'
      expect(page).to have_css 'a[href="#"]'
    end
  end

  %i[primary secondary success danger warning].each do |button_type|
    context "#{button_type} button type" do
      before { @options.merge!(type: button_type) }

      it 'renders' do
        render_inline(component)

        expect(page).to have_css "a.button.is-#{button_type}", text: 'Click me!'
        expect(page).to have_css 'a[href="#"]'
      end
    end
  end

  context 'with icon' do
    it 'renders a link without class button' do
      render_inline(component) do |c|
        c.icon('poo')
      end

      expect(page).to have_css 'a', text: 'Click me!'
      expect(page).to have_css 'a[href="#"]'
      expect(page).to have_css 'span.icon'
    end

    it 'renders a link with class button' do
      @options.merge!(class: 'button')

      render_inline(component) do |c|
        c.icon('poo')
      end

      expect(page).to have_css 'a.button', text: 'Click me!'
      expect(page).to have_css 'a[href="#"]'
      expect(page).to have_css 'span.icon'
    end
  end

  context 'active indicator' do
    context 'when current path is active' do
      before { @options.merge!(href: '/items', active_path: '/items') }

      it 'does not add the is-active class when active is false' do
        @options.merge!(active: false)
        render_inline(component)

        expect(page).not_to have_css 'a.is-active'
      end

      it 'adds the is-active class when active is true' do
        @options.merge!(active: true)
        render_inline(component)

        expect(page).to have_css 'a.is-active'
      end

      it 'adds the is-active class when active is nil' do
        render_inline(component)

        expect(page).to have_css 'a.is-active'
      end
    end

    context 'when current path is not active' do
      before { @options.merge!(href: '/items', active_path: '/movies') }

      it 'adds the is-active class when active is true' do
        @options.merge!(active: true)
        render_inline(component)

        expect(page).to have_css 'a.is-active'
      end

      it 'does not add the is-active class when active is false' do
        @options.merge!(active: false)
        render_inline(component)

        expect(page).not_to have_css 'a.is-active'
      end

      it 'does not add the is-active class when active is nil' do
        render_inline(component)

        expect(page).not_to have_css 'a.is-active'
      end
    end
  end

  context 'with the method parameter' do
    context 'when the method is not get' do
      it 'renders a link with turbo method' do
        @options.merge!(method: :post)

        render_inline(component)

        expect(page).to have_css 'a[data-turbo-method="post"]', text: 'Click me!'
      end
    end

    context 'when the method is get' do
      it 'renders a link without turbo method' do
        @options.merge!(method: :get)

        render_inline(component)

        expect(page).to have_css 'a.link-component', text: 'Click me!'
        expect(page).not_to have_css 'a[data-turbo-method="get"]'
        expect(page).to have_css 'a[data-method="get"]'
      end
    end
  end
end
