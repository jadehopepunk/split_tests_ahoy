require 'split_tests_ahoy/visit'

module SplitTestsAhoy
  module TestHelpers
    def ahoy_split_test(experiment_name, *alternatives)
      raise ArgumentError.new("Invalid name #{experiment_name.inspect}") if experiment_name.blank?

      track_ahoy_visit
      experiment = Experiment.find_or_create_by(name: experiment_name)
    end
  end
end