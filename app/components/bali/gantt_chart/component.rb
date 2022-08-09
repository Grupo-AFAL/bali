# frozen_string_literal: true

module Bali
  module GanttChart
    class Component < ApplicationViewComponent
      attr_reader :tasks, :options

      COLUMN_WIDTH = 25

      def initialize(tasks: [], **options)
        @tasks = tasks.map { |task| Task.new(**task) }
        tasks_by_parent_id = @tasks.group_by(&:parent_id)

        @tasks.each do |task|
          task.chart_start_date = start_date
          task.chart_end_date = end_date
        end

        @tasks.each { |task| task.children = tasks_by_parent_id[task.id] || [] }
        @tasks.filter! { |task| task.parent_id.blank? }

        @options = prepend_class_name(options, 'gantt-chart-component')
        @options = prepend_controller(options, 'gantt-chart')
        @options = prepend_action(options, 'sortable-list:onEnd->gantt-chart#onItemReordered')
        @options = prepend_action(options, 'interact:onResizeEnd->gantt-chart#onItemResized')
        @options = prepend_action(options, 'interact:onDragEnd->gantt-chart#onItemDragged')
        @options = prepend_values(options, 'gantt-chart', { today_offset: today_offset })

        @default_start_date = Date.current.beginning_of_month - 1.month
        @default_end_date = Date.current.end_of_month + 2.months
      end

      def start_date
        min_date.beginning_of_month - 1.month
      end

      def end_date
        max_date.end_of_month + 1.month
      end

      def duration
        (end_date - start_date).to_i + 1
      end

      def min_date
        @min_date ||= earliest_task&.start_date || @default_start_date
      end

      def max_date
        @max_date ||= latest_task&.end_date || @default_end_date
      end

      def days_by_month
        (start_date..end_date).group_by(&:month)
      end

      def earliest_task
        tasks.min { |a, b| a.start_date <=> b.start_date }
      end

      def latest_task
        tasks.max { |a, b| a.end_date <=> b.end_date }
      end

      def today_offset
        (start_date - Date.current).to_i.abs * COLUMN_WIDTH
      end
    end
  end
end
