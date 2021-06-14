class AddCOountReadQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :faqs, :count_reads, :integer, null: false, default: 0
  end
end
