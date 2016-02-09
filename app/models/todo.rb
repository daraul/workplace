class Todo < ActiveRecord::Base
    after_save :complete_parents_if_siblings_completed
    after_save :uncomplete_parents_if_uncompleted
    
    has_and_belongs_to_many :children, class_name: "Todo", join_table: "todos_todos", foreign_key: "parent_id", association_foreign_key: :child_id
    has_and_belongs_to_many :parents, class_name: "Todo", join_table: "todos_todos", foreign_key: "child_id", association_foreign_key: :parent_id
    
    belongs_to :user
    
    validates :user, presence: true 
    
    validates :title, presence: true, length: { in: 5..50, message: "must be 5 to 35 characters long!" }, format: { with: /\A[A-Z][\w\!\,\.\'\ ]+\z/, message: "must be alphanumeric, begin with a capital letter and can include white space or these characters: !,." } 
    
    validates :description, length: { in: 0..255, message: "must be 10 to 255 characters long!" }, format: { with: /\A[\w\!\,\.\(\)\&\^\@\#\$\{\}\"\'\\\/\|\;\:\+\-\%\<\>\*\?\=\~\`\s]+\z/, message: "must be alphanumeric and can include white space or these characters: w!,.()&^@#${}\"'\/|;:+-%<>*?=s~`" }, allow_blank: true
    
    validates :due, presence: true#, format: { with: /\A(19[0-9]{2}|2[0-9]{3})-(0[1-9]|1[012])-([123]0|[012][1-9]|31) ([01][0-9]|2[0-3]):([0-5][0-9])\z/, message: "must follow this format: YYYY-MM-DD HH:MM" } 
    
    validate :disallow_identical_parent_child_reference, :disallow_completion_unless_all_children_completed, :parent_is_incompleted, :disallow_self_referential_child, :disallow_self_referential_parent, :parents_due_after_or_on_self, :child_due_before_or_on_self
    
    validate :due_is_now_or_later, on: :create
    
    def parents_due_after_or_on_self
        parents.each do |parent|
            if parent.due < self.due 
                errors.add(:parents, "should be due on or after children.")
                return 
            end 
        end 
    end 
    
    def child_due_before_or_on_self
        children.each do |child|
            if child.due > self.due 
                errors.add(:children, "should be due on or before parents.")
                return 
            end 
        end 
    end 
    
    def disallow_self_referential_child
        if child_ids.include? id 
            errors.add(:children, 'cannot include self!')
        end 
    end 
    
    def due_is_now_or_later
        if self.due < DateTime.now 
            errors.add(:due, "date should either be now or later.")
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
    
    def parent_is_incompleted
        parents.each do |parent|
            if parent.completed == true 
                errors.add(:parents, "cannot be completed when adding them.")
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
