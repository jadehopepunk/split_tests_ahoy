module SplitTestsAhoy
  module ParticipationScopes
    def self.included(base)
      base.extend ClassMethods
    end


    module ClassMethods
      def participation_scopes(options)
        participant_id = options[:participant_id] || :user_id

        scope :participating_in_at_creation, -> (alternative) {
          where("1 = 1")
        }
      end
    end
  end

end

ActiveRecord::Base.include(SplitTestsAhoy::ParticipationScopes)
