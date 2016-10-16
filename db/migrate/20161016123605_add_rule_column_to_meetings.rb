class AddRuleColumnToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :rule, :string
  end
end
