class RemoveDateCreateToTickets < ActiveRecord::Migration[5.2]
  def change
    remove_column :tickets, :createDate, :datetime
  end
end
