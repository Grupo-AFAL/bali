# frozen_string_literal: true

module Bali
  module GanttChart
    module TimelineCell
      class Component < ApplicationViewComponent
        attr_reader :task, :readonly, :zoom, :task_name_padding, :options

        def initialize(task:, readonly:, zoom:)
          @task = task
          @readonly = readonly
          @zoom = zoom
          @task_name_padding = 8

          @options = prepend_class_name(task.options, class_names(
            'gantt-chart-cell',
            milestone: task.milestone?,
            'has-children': task.children.any?
          ))
          @options[:style] = "left: #{task.position_left}px; width: #{task.width}px"

          @options = prepend_controller(@options, 'interact')
          @options = prepend_data_attribute(@options, 'task-id', task.id)
          @options = prepend_data_attribute(@options, 'parent-id', task.id)
          @options = prepend_values(@options, 'interact', { position: task.position_left, width: task.width, params: task.params })
          @options = prepend_data_attribute(@options, 'gantt-chart-target', 'timelineCell')
        end

        def resize_handle?
          @resize_handle ||= draggable? && !task.milestone?
        end

        def draggable?
          @draggable ||= task.children.empty? && !readonly && zoom == :day
        end
      end
    end
  end
end
