module SplitTestsAhoy
  class Experiment < ActiveRecord::Base
    has_many :participants, dependent: :delete_all

    def self.ensure_started(name)
      find_or_create_by(name: name)
    end

    def existing_alternative_for(visit)
      participant = participants.for_visit(visit).last
      participant.alternative_name if participant
    end

    def start_visit_participation(visit, alternative)
      participants.for_visit(visit).create!(alternative_name: alternative)
    end
  end
end