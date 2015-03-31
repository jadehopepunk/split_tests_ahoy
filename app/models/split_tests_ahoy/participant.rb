module SplitTestsAhoy
  class Participant < ActiveRecord::Base
    belongs_to :experiment
    belongs_to :visit
  end
end