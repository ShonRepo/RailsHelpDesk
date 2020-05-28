class AddDateCreateToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :createDate, :datetime
  end
end
