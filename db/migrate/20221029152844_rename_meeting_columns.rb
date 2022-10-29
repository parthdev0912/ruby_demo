class RenameMeetingColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :meetings, :starts, :start_time
  end
end
