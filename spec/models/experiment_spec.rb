require 'spec_helper'
require 'split_tests_ahoy/experiment'

module SplitTestsAhoy
  describe Experiment do
    subject { Experiment.new(name: 'my_experiment')}

    before do
      SplitTestsAhoy.experiments = nil
    end

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

        context "with an array of alternative hashes" do
          it "handles names" do
            SplitTestsAhoy.experiments = {
              subject.name => {
                alternatives: [
                  {name: "a"},
                  {name: "b"}
                ]
              }
            }
            subject.load_configuration
            expect(subject.alternatives.map(&:name)).to eq(['a', 'b'])
          end

          it "handles percent" do
            SplitTestsAhoy.experiments = {
              subject.name => {
                alternatives: [
                  {name: "a", percent: 67},
                  {name: "b", percent: 33}
                ]
              }
            }
            subject.load_configuration
            expect(subject.alternatives.map(&:percent)).to eq([67, 33])
          end

          it "raises error if percentages are provided but don't add up to 100" do
            SplitTestsAhoy.experiments = {
              subject.name => {
                alternatives: [
                  {name: "a", percent: 67},
                  {name: "b", percent: 32}
                ]
              }
            }
            expect {subject.load_configuration}.to raise_error(ArgumentError)
          end
        end
      end
    end
  end
end