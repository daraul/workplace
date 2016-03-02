class CreateDatafiles < ActiveRecord::Migration
  def change
    create_table :datafiles do |t|
      t.string      :filename 
      t.string      :url
      t.belongs_to  :todo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
