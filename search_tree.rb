# frozen_string_literal: true

require './tree_traversal'

# module container for removing child nodes via delete method
module RemoveChildNode
  def remove_leaf_node(previous_node, current_node)
    if previous_node.left == current_node
      previous_node.left = nil
    else
      previous_node.right = nil
    end
  end

  # deletes a node from Tree that has only one child node
  def remove_one_child(current_node)
    if current_node.left.nil?
      current_node.data = current_node.right.data
      current_node.right = nil
    else
      current_node.data = current_node.left.data
      current_node.left = nil
    end
  end

  # deletes a node from Tree that has two children
  def remove_two_child(current_node)
    original_node = current_node
    current_node = current_node.right
    current_node = current_node.left until current_node.left.nil?

    new_node = current_node.data
    delete(current_node.data)
    original_node.data = new_node
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

# takes an array and converts it into a binary search tree data structure
class Tree
  include RemoveChildNode
  include TreeTraversal
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
    root_node.right = build_tree(array[(middle + 1)..])

    root_node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(data)
    new_node = Node.new(data)
    current_node = @root

    until current_node.left.nil? || current_node.right.nil?
      current_node =
        new_node.data > current_node.data ? current_node.right : current_node.left
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
      previous_node = current_node
      current_node =
        data > current_node.data ? current_node.right : current_node.left
    end

    if current_node.right.nil? && current_node.left.nil?
      remove_leaf_node(previous_node, current_node)
    elsif current_node.right.nil? || current_node.left.nil?
      remove_one_child(current_node)
    else
      remove_two_child(current_node)
    end
  end

  def find(data)
    current_node = @root

    until current_node.data == data
      current_node =
        data > current_node.data ? current_node.right : current_node.left
      raise 'Node not found' if current_node.nil?
    end
    current_node
  end
end
