class CreateFaq < ActiveRecord::Migration[6.0]
  def change
    create_table :faqs do |t|
      t.timestamps

      t.string :title

      t.string :text

      t.references(:author,
                   type: :integer,
                   index: false,
                   null: false,
                   dependent: :destroy,
                   foreign_key: { to_table: :admins })
    end
  end
end
