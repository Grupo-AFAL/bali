# frozen_string_literal: true

module Bali
  module Form
    module Radio
      class Preview < ApplicationViewComponentPreview
        VALUES = {
          Monday: [
            ['Sit-ups', 0],
            ['Push-ups', 1],
            ['Back Squats', 2]
          ],
          Tuesday: [
            ['Sit-ups', 3],
            ['Pull-ups', 4],
            ['Front-Squats', 5]
          ],
          Wednesday: [
            ['Hang cleans', 6],
            ['Runnning', 7],
            ['Clean & Jerks', 8]
          ]
        }.freeze

        # @param keep_selection toggle
        def radio_buttons_field_group(keep_selection: false)
          render_with_template(
            template: 'bali/form/radio/previews/field_group',
            locals: { model: Workout.new, values: VALUES, keep_selection: keep_selection }
          )
        end

        # @param keep_selection toggle
        def radio_buttons_field(keep_selection: false)
          render_with_template(
            template: 'bali/form/radio/previews/field',
            locals: { model: Workout.new, values: VALUES, keep_selection: keep_selection }
          )
        end
      end
    end
  end
end
