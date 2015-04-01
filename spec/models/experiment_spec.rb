require 'spec_helper'
require 'split_tests_ahoy/experiment'

module SplitTestsAhoy
  describe Experiment do
    subject { Experiment.new(name: 'my_experiment')}

    describe "#load_configuration" do
      it "raises an error if alternatives is called before loading configuration" do
        expect {subject.alternatives}.to raise_error
      end

      context "without named configuration" do
        it "loads alternative names from array of alternatives" do
          subject.load_configuration(['one', 'two'])
          expect(subject.alternatives.map(&:name)).to eq(['one', 'two'])
        end
      end

      context "with named configuration" do
        it "loads simple alternative names from config" do
          SplitTestsAhoy.experiments = {
            subject.name => {
              alternatives: ["a", "b"]
            }
          }
          subject.load_configuration
          expect(subject.alternatives.map(&:name)).to eq(['a', 'b'])
        end

        it "raises an exception if alternatives are specified in method call" do
          SplitTestsAhoy.experiments = {
            subject.name => {
              alternatives: ["a", "b"]
            }
          }
          expect { subject.load_configuration(['one', 'two']) }.to raise_error(ArgumentError)
        end
      end
    end
  end
end