require 'spec_helper'

class DummyController < ActionController::Base
  include Ahoy::Controller
  include SplitTestsAhoy::ControllerExtensions
end

class DummyAlternativeSelector
  attr_accessor :alternative

  def choose_alternative(experiment)
    if alternative
      experiment.alternatives.detect {|a| a.name == alternative}
    else
      SplitTestsAhoy::Alternative.new(name: 'default')
    end
  end
end

describe DummyController, :type => :controller  do
  let(:selector) { DummyAlternativeSelector.new }

  before do
    SplitTestsAhoy.alternative_selector = selector
  end

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

    it "asks the alternative selector to pick an alternative" do
      selector.alternative = 'bar'

      expect{|b| subject.ahoy_split_test('first_experiment', 'foo', 'bar', &b)}.to yield_with_args('bar')
    end

    it "doesn't change alternative on second try" do
      selector.alternative = 'foo'
      subject.ahoy_split_test('first_experiment', 'foo', 'bar')
      selector.alternative = 'bar'

      expect{|b| subject.ahoy_split_test('first_experiment', 'foo', 'bar', &b)}.to yield_with_args('foo')
    end

  end
end