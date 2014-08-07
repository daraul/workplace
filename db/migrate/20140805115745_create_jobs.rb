class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
        t.string :title
        t.string :description
        t.boolean :complete
        t.references :employee

      t.timestamps
    end
  end
end
