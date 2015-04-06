class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :split_tests_ahoy_participants do |t|
      t.uuid :visit_id
      t.integer :experiment_id
      t.string :alternative_name
      t.datetime :created_at
      t.datetime :ended_at
    end
  end
end
