module SplitTestsAhoy
  module ParticipationScopes
    def self.included(base)
      base.extend ClassMethods
    end


    module ClassMethods
      def participation_scopes(options)
        identity_id = options[:identity_id] || :user_id
        identity_table = options[:users] || :users

        participants_table = SplitTestsAhoy::Participant.table_name

        scope :participating_in_at_creation, lambda { |alternative|
          joins("INNER JOIN #{identity_table} ON #{table_name}.#{identity_id} = #{identity_table}.id").
          joins("INNER JOIN visits ON visits.user_id = #{identity_table}.id").
          joins("INNER JOIN #{participants_table} ON #{participants_table}.visit_id = visits.id").
          where("#{participants_table}.alternative_name" => alternative.name).
          where("#{participants_table}.experiment_id" => alternative.experiment_id).
          where("#{participants_table}.created_at <= #{table_name}.created_at")
        }
      end
    end
  end

end

ActiveRecord::Base.send(:include, SplitTestsAhoy::ParticipationScopes)
