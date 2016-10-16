class AddIntervalColumnToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :interval, :integer
  end
end
