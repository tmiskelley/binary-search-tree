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

  def insert(data)
    new_node = Node.new(data)
    current_node = @root

    until current_node.left.nil? || current_node.right.nil?
      if new_node.data > current_node.data
        current_node = current_node.right
      else
        current_node = current_node.left
      end
    end

    if new_node.data > current_node.data
      current_node.right = new_node
    else
      current_node.left = new_node
    end
  end

  def delete(data)
    current_node = @root
    previous_node = nil

    until current_node.data == data
      if data > current_node.data
        previous_node = current_node
        current_node = current_node.right
      else
        previous_node = current_node
        current_node = current_node.left
      end
    end

    # deletes a leaf node from the tree
    if previous_node.left == current_node
      previous_node.left = nil
    else
      previous_node.right = nil
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# binary tree node
class Node
  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end
