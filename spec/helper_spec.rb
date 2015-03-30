require 'spec_helper'

describe SplitTestsAhoy::TestHelpers, :type => :controller  do
  include SplitTestsAhoy::TestHelpers

  describe "split_test" do
    it "ensures that a visitor has been created" do
      expect(self).to receive(:track_ahoy_visit)

      ahoy_split_test('first_experiment', 'foo', 'bar')
    end

    it "creates an experiment record if none exists" do
      allow(self).to receive(:track_ahoy_visit)

      ahoy_split_test('first_experiment', 'foo', 'bar')

      expect(SplitTestsAhoy::Experiment.where(name: 'first_experiment').count).to eq(1)
    end
  end
end