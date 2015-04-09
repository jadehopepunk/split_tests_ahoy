module SplitTestsAhoy
  class Participant < ActiveRecord::Base
    belongs_to :experiment
    belongs_to :visit

    scope :for_visit, lambda {|visit| where(visit_id: visit.id) }
    scope :for_alternative_name, lambda {|alternative_name| where(alternative_name: alternative_name) }

    validates :alternative_name, presence: true
  end
end