# frozen_string_literal: true

class Tree
  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
    root = (arr.length) / 2
    Node.new(arr[root])
  end
end

# binary tree node
class Node
  attr_reader :data
  attr_accessor :left_branch, :right_branch

  def initialize(data)
    @data = data
    @left_branch = nil
    @right_branch = nil
  end
end
