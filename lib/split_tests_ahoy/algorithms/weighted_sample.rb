# Code thanks to
# https://github.com/splitrb/split/blob/master/lib/split/algorithms/weighted_sample.rb
# Used under MIT licence

module SplitTestsAhoy
  module Algorithms
    class WeightedSample
      def choose_alternative(experiment)
        weights = experiment.alternatives.map do |alternative|
          alternative.weight || 1.0
        end

        total = weights.inject(:+)
        point = rand * total

        experiment.alternatives.zip(weights).each do |n,w|
          return n if w >= point
          point -= w
        end
      end
    end
  end
end