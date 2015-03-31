require 'spec_helper'

class DummyController < ActionController::Base
  include Ahoy::Controller
  include SplitTestsAhoy::TestHelpers

end

describe DummyController, :type => :controller  do
  describe "split_test" do
    it "creates an experiment record if none exists" do
      subject.ahoy_split_test('first_experiment', 'foo', 'bar')

      expect(SplitTestsAhoy::Experiment.where(name: 'first_experiment').count).to eq(1)
    end

    it "creates a participant record for the visit" do
      subject.ahoy_split_test('first_experiment', 'foo', 'bar')

      experiment = SplitTestsAhoy::Experiment.find_by_name('first_experiment')
      expect(experiment.participants.count).to eq(1)
      participant = experiment.participants.first
      expect(participant.visit.id).to eq(subject.current_visit.id)
    end
  end
end