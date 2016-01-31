class Checklist < ActiveRecord::Base
    has_and_belongs_to_many :children, class_name: "Checklist", join_table: "checklists_checklists", foreign_key: "parent_id", association_foreign_key: :child_id
    has_and_belongs_to_many :parents, class_name: "Checklist", join_table: "checklists_checklists", foreign_key: "child_id", association_foreign_key: :parent_id
end
