class AddSenderToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :sender, :string
  end
end
