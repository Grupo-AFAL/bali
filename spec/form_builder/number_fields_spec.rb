# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bali::FormBuilder, type: :form_builder do
  include_context 'form builder'

  describe '#number_field_group' do
    let(:number_field_group) { builder.number_field_group(:budget) }

    it 'render a label an input within a wrapper' do
      expect(number_field_group).to have_css 'div.field.field-group-wrapper-component'
    end

    it 'renders a label' do
      expect(number_field_group).to have_css 'label[for="movie_budget"]', text: 'Budget'
    end

    it 'renders an input' do
      expect(number_field_group).to have_css 'input#movie_budget[name="movie[budget]"]'
    end
  end

  describe '#number_field' do
    let(:number_field) { builder.number_field(:budget) }

    it 'renders a div with control class' do
      expect(number_field).to have_css 'div.control'
    end

    it 'renders an input' do
      expect(number_field).to have_css 'input#movie_budget[name="movie[budget]"]'
    end
  end
end
