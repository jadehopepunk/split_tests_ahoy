# This migration comes from split_tests_ahoy (originally 20150330032831)
class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :split_tests_ahoy_experiments do |t|
      t.string :name
      t.datetime :created_at
    end

    add_index :split_tests_ahoy_experiments, :name
  end
end
