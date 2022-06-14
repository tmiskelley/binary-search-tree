# frozen_string_literal: true

class Tree
  def initialize(arr)
    @root = build_tree
  end

  def build_tree; end
end

# binary tree node
class Node
  def initialize(data)
    @data = data
    @left_branch = nil
    @right_branch = nil
  end
end