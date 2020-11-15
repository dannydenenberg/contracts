class CreateParties < ActiveRecord::Migration[6.0]
  def change
    create_table :parties do |t|
      t.references :account, null: false, foreign_key: true
      t.references :contract, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
