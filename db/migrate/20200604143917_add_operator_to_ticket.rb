class AddOperatorToTicket < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :operator, foreign_key: true, null: true
  end
end
