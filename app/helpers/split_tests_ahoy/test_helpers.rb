require 'split_tests_ahoy/visit'

module SplitTestsAhoy
  module TestHelpers
    def ahoy_split_test(experiment_name, *alternatives)
      raise ArgumentError.new("Invalid name #{experiment_name.inspect}") if experiment_name.blank?

      track_ahoy_visit_immediately
      experiment = Experiment.ensure_started(experiment_name)
      experiment.track_visit(current_visit)
    end

    private

    def track_ahoy_visit_immediately
      if ahoy.new_visit?
        ahoy.track_visit(defer: false)
      end
    end
  end
end