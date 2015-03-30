require 'spec_helper'
require 'split_tests_ahoy/helper'

describe SplitTestsAhoy::Helper, :type => :controller  do
  include SplitTestsAhoy::Helper

  describe "split_test" do
    it "ensures that a visitor has been created" do
      expect(self).to receive(:track_ahoy_visit)

      ahoy_split_test('first_experiment', 'foo', 'bar')
    end

    # it "creates an experiment record if none exists" do
    #   ahoy_split_test('first_experiment', 'foo', 'bar')
    #
    # end
  end
end