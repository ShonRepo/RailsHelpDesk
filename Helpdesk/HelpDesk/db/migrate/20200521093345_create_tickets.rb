class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :title
      t.string :email
      t.text :body

      t.timestamps
    end
  end
end
