class Todo < ActiveRecord::Base
    after_save :complete_parents_if_siblings_completed
    after_save :uncomplete_parents_if_uncompleted
    
    has_and_belongs_to_many :children, class_name: "Todo", join_table: "todos_todos", foreign_key: "parent_id", association_foreign_key: :child_id, before_add: [:disallow_self_referential_child]
    has_and_belongs_to_many :parents, class_name: "Todo", join_table: "todos_todos", foreign_key: "child_id", association_foreign_key: :parent_id, before_add: [:disallow_self_referential_parent]
    
    belongs_to :user
    
    validates :user, presence: true 
    
    validates :title, presence: true, length: { in: 5..35, message: "must be 5 to 35 characters long!" }, format: { with: /\A[A-Z][\w\!\,\. ]+\z/, message: "must be alphanumeric, begin with a capital letter and can include white space or these characters: !,." } 
    
    validates :description, length: { in: 10..255, message: "must be 10 to 255 characters long!" }, format: { with: /\A[\w\!\,\.\(\)\&\^\@\#\$\{\}\"\'\\\/\|\;\:\+\-\%\<\>\*\?\=\~\`\s]+\z/, message: "must be alphanumeric and can include white space or these characters: w!,.()&^@#${}\"'\/|;:+-%<>*?=s~`" }
    
    validate :disallow_identical_parent_child_reference
    
    validate :disallow_completion_unless_all_children_completed
    
    def disallow_self_referential_child(children)
        if child_ids.include? id 
            errors.add(:children, 'cannot include self!')
        end 
    end 
    
    def disallow_self_referential_parent(parents)
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
    
    def disallow_completion_unless_all_children_completed
        if completed == true 
            children.each do |child|
                if child.completed != true 
                    errors.add(:completed, 'cannot be true unless all children are completed!')
                    return 
                end 
            end 
        end 
    end 
    
    private 
        def uncomplete_parents_if_uncompleted
            if completed == false 
                parents.each do |parent|
                    parent.completed = false 
                    parent.save 
                end 
            end 
        end 
        
        def complete_parents_if_siblings_completed
            if completed == true 
                completed_buffer = true 
                
                parents.each do |parent|
                    parent.children.each do |sibling|
                        if sibling.completed == false 
                            completed_buffer = false 
                        end 
                    end 
                    
                    parent.completed = true 
                    parent.save 
                end 
            end 
        end 
end
