class AddTypeToTicket < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :type, foreign_key: true
  end
end
