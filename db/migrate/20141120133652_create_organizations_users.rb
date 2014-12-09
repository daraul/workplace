class CreateOrganizationsUsers < ActiveRecord::Migration
    def change
        create_table :organizations_users, id: false  do |t|
            t.belongs_to :organization
            t.belongs_to :user
        end
    end
end
