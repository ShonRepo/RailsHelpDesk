class AddUuidToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :uuid, :string
  end
end
