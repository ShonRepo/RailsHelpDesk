class CreateConfirmeds < ActiveRecord::Migration[5.2]
  def change
    create_table :confirmeds do |t|
      t.string :email
      t.boolean :enable

      t.timestamps
    end
  end
end
