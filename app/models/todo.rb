class Todo < ActiveRecord::Base
    has_and_belongs_to_many :children, class_name: "Todo", join_table: "todos_todos", foreign_key: "parent_id", association_foreign_key: :child_id
    has_and_belongs_to_many :parents, class_name: "Todo", join_table: "todos_todos", foreign_key: "child_id", association_foreign_key: :parent_id
end
