# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bali::FormBuilder, type: :form_builder do
  include_context 'form builder'

  describe '#submit' do
    let(:submit) { builder.submit('Save') } 

    it 'renders an inline div' do
      expect(submit).to have_css 'div.inline'
    end
     
    it 'renders a submit button' do
      expect(submit).to have_css 'button[type="submit"][class="button is-primary"]', text: 'Save'
    end
  end

  describe '#submit_actions' do
    let(:submit_actions) { builder.submit_actions('Save', cancel_path: '/', cancel_options: { label: 'Back' }) } 

    it 'renders buttons within a wrapper' do
      expect(submit_actions).to have_css 'div.field.is-grouped.is-grouped-right'
    end

    context 'when cancel path or cancel options is present' do
      it 'renders a cancel button' do
        expect(submit_actions).to have_css 'a[class="button is-secondary"][href="/"]', text: 'Back'
      end
    end

    it 'renders a submit button' do
      expect(submit_actions).to have_css 'button[type="submit"][class="button is-primary"]', text: 'Save'
    end
  end
end
