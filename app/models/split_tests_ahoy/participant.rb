module SplitTestsAhoy
  class Participant < ActiveRecord::Base
    belongs_to :experiment
    belongs_to :visit

    scope :for_visit, lambda {|visit| where(visit_id: visit.id) }

    validates :alternative_name, presence: true
  end
end