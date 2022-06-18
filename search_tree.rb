# frozen_string_literal: true

class Tree
  attr_accessor :root, :data

  def initialize(arr)
    @data = arr.sort.uniq
    @root = build_tree(data)
  end

  def build_tree(array)
    return nil if array.empty?

    middle = (array.size - 1) / 2
    root_node = Node.new(array[middle])

    root_node.left = build_tree(array[0...middle])
    root_node.right = build_tree(array[(middle + 1)..-1])

    root_node
  end
end

# binary tree node
class Node
  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left_branch = nil
    @right_branch = nil
  end
end