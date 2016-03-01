class CreateDatafiles < ActiveRecord::Migration
  def change
    create_table :datafiles do |t|
      t.belongs_to :todo, index: true, foreign_key: true
      t.attachment :attachment

      t.timestamps null: false
    end
  end
end
