class TreeNode
  attr_reader :children, :parent, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    self.parent.children.delete(self) if self.parent
    new_parent.children << self if new_parent
    @parent = new_parent
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    raise "Child not present" if !children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if value == target_value

    children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end

    nil
  end

  def my_bfs(target)
    current_level = [self]

    until current_level.empty?
      found = current_level.select { |node| node.value == target }
      
      if !found.empty? # always truthy
        return found[0]
      else
        current_level = current_level.map { |node| node.children }.flatten
      end
    end
  end

  def bfs(target)
    queue = [self]

    until queue.length == 0
      node = queue.shift
      return node if node.value == target
      node.children.each { |child| queue.push(child) }
    end
  end

  def trace_path
    path = [self]
    current_node = self

    while current_node.parent
      path.unshift(current_node.parent)
      current_node = current_node.parent
    end

    path.map(&:value)
  end
end
