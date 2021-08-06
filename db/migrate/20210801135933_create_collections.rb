class CreateCollections < ActiveRecord::Migration[6.0]
  
  def change
    create_table :collections do |t|
      t.belongs_to :invoice
      
      t.datetime :collection_date, null: false
      t.integer :amount, null: false
      t.timestamps
    end
  end

end
