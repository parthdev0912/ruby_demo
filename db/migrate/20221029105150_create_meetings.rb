class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.string   :subject
      t.string   :description
      t.datetime :starts
      t.datetime :complete
      t.string :metting_with
      t.timestamps
    end
  end
end
