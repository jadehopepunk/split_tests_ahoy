require 'split_tests_ahoy/visit'

module SplitTestsAhoy
  module Helper
    def ahoy_split_test(experiment_name, *alternatives)
      track_ahoy_visit
    end
  end
end