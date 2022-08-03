# frozen_string_literal: true

# module container for all tree traversal algorithims
module TreeTraversal
  # Returns an array of nodes in level order
  def level_order(current_node, queue = [current_node], array = [])
    return if queue.empty?

    array.push(current_node.data)
    unless current_node.nil?
      queue.push(current_node.left) unless current_node.left.nil?
      queue.push(current_node.right) unless current_node.right.nil?
    end
    queue.shift
    level_order(queue[0], queue, array)
    yield array if block_given?
    array
  end
end
