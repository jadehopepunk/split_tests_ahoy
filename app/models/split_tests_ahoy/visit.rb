module SplitTestsAhoy
  class Visit < ActiveRecord::Base
    self.table_name = 'visits'

    has_many :participants
  end
end