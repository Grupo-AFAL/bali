# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bali::FormBuilder, type: :form_builder do
  include_context 'form builder'

  describe '#text_area_group' do
    let(:text_area_group) { builder.text_area_group(:synopsis) }

    it 'render a label an input within a wrapper' do
      expect(text_area_group).to have_css 'div.field.field-group-wrapper-component'
    end

    it 'renders a label' do
      expect(text_area_group).to have_css 'label[for="movie_synopsis"]', text: 'Synopsis'
    end

    it 'renders a text area' do
      expect(text_area_group).to have_css 'textarea#movie_synopsis[name="movie[synopsis]"]'
    end
  end

  describe '#text_area' do
    let(:text_area) { builder.text_area(:synopsis) }

    it 'renders a div with control class' do
      expect(text_area).to have_css 'div.control'
    end

    it 'renders a text area' do
      expect(text_area).to have_css 'textarea#movie_synopsis[name="movie[synopsis]"]'
    end
  end
end
