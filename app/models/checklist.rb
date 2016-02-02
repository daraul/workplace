class Checklist < ActiveRecord::Base
    has_and_belongs_to_many :children, class_name: "Checklist", join_table: "checklists_checklists", foreign_key: "parent_id", association_foreign_key: :child_id
    has_and_belongs_to_many :parents, class_name: "Checklist", join_table: "checklists_checklists", foreign_key: "child_id", association_foreign_key: :parent_id
    
    validates :title, presence: true
    
    validate :disallow_self_referential_child
    validate :disallow_self_referential_parent
    
    def disallow_self_referential_child
        if child_ids.include? id 
            errors.add(:child_id, 'cannot self reference!')
        end 
    end 
    
    def disallow_self_referential_parent
        if parent_ids.include? id 
            errors.add(:parent_id, "cannot self reference!")
        end 
    end 
end
