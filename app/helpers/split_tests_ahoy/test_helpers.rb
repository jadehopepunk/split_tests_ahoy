require 'split_tests_ahoy/visit'

module SplitTestsAhoy
  module TestHelpers
    def ahoy_split_test(experiment_name, *alternatives, &block)
      raise ArgumentError.new("Invalid name #{experiment_name.inspect}") if experiment_name.blank?

      track_ahoy_visit_immediately

      experiment = Experiment.ensure_started(experiment_name)
      visit = current_visit

      alternative = experiment.existing_alternative_for(visit)
      unless alternative
        alternative = SplitTestsAhoy.alternative_selector.alternative_for_new_visit(visit, *alternatives)
        experiment.start_visit_participation(visit, alternative) unless alternative.blank?
      end

      yield_and_capture(alternative, &block) if alternative
    end

    private

    def track_ahoy_visit_immediately
      if ahoy.new_visit?
        ahoy.track_visit(defer: false)
      end
    end

    def yield_and_capture(params)
      if block_given?
        if defined?(capture) && defined?(concat) # a block in a rails view
          block = Proc.new { yield(params) }
          concat(capture(params, &block))
          false
        else
          yield(params)
        end
      else
        params
      end
    end
  end
end