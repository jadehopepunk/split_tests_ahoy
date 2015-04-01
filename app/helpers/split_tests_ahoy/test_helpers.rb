require 'split_tests_ahoy/visit'

module SplitTestsAhoy
  module TestHelpers
    def ahoy_split_test(experiment_name, *alternatives, &block)
      raise ArgumentError.new("Invalid name #{experiment_name.inspect}") if experiment_name.blank?

      track_ahoy_visit_immediately

      experiment = Experiment.ensure_started(experiment_name)
      experiment.load_configuration(alternatives)
      visit = current_visit

      alternative_name = experiment.existing_alternative_for(visit)
      unless alternative_name
        alternative = SplitTestsAhoy.alternative_selector.choose_alternative(experiment)
        alternative_name = alternative.name if alternative
        experiment.start_visit_participation(visit, alternative_name) unless alternative_name.blank?
      end

      yield_and_capture(alternative_name, &block) if alternative_name
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