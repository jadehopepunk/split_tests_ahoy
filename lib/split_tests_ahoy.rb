require "split_tests_ahoy/engine"
require 'split_tests_ahoy/algorithms/weighted_sample'

module SplitTestsAhoy
  mattr_accessor :alternative_selector
  mattr_accessor :experiments
end

SplitTestsAhoy.alternative_selector = SplitTestsAhoy::Algorithms::WeightedSample.new
