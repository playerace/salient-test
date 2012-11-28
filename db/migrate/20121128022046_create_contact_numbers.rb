class CreateContactNumbers < ActiveRecord::Migration
  def change
    create_table :contact_numbers do |t|
      t.string :number
      t.references :contact

      t.timestamps
    end
    add_index :contact_numbers, :contact_id
  end
end
