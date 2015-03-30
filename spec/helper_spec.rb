require 'spec_helper'
require 'split_tests_ahoy/helper'

describe SplitTestsAhoy::Helper do
  include SplitTestsAhoy::Helper

  describe "split_test" do
    it "should ensure that a visitor has been created" do
      ahoy_split_test('first_experiment', 'foo', 'bar')

      visit = ahoy_split_visit
      expect(visit).to be_a(SplitTestsAhoy::Visit)
    end
  end
end