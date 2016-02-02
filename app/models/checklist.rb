class Checklist < ActiveRecord::Base
    has_and_belongs_to_many :children, class_name: "Checklist", join_table: "checklists_checklists", foreign_key: "parent_id", association_foreign_key: :child_id
    has_and_belongs_to_many :parents, class_name: "Checklist", join_table: "checklists_checklists", foreign_key: "child_id", association_foreign_key: :parent_id
    
    validates :title, presence: true, length: { in: 5..35, message: "must be 5 to 35 characters long!" }, format: { with: /\A[A-Z][\w\!\,\. ]+\z/, message: "must be alphanumeric, begin with a capital letter and can include white space or these characters: !,." } 
    
    validates :description, length: { in: 10..255, message: "must be 10 to 255 characters long!" }, format: { with: /\A[\w\!\,\.\(\)\&\^\@\#\$\{\}\"\'\\\/\|\;\:\+\-\%\<\>\*\?\=\~\`\s]+\z/, message: "must be alphanumeric and can include white space or these characters: w!,.()&^@#${}\"'\/|;:+-%<>*?=s~`" }
    
    validate :disallow_self_referential_child
    validate :disallow_self_referential_parent
    
    validate :disallow_identical_parent_child_reference
    
    def disallow_self_referential_child
        if child_ids.include? id 
            errors.add(:children, 'cannot include self!')
        end 
    end 
    
    def disallow_self_referential_parent
        if parent_ids.include? id 
            errors.add(:parents, "cannot include self!")
        end 
    end 
    
    def disallow_identical_parent_child_reference
        parent_ids.each do |parent_id|
            if child_ids.include? parent_id 
                errors.add(:parents, 'cannot include a child!')
                return 
            end 
        end 
    end 
end
