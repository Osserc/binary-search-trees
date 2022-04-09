class Tree
    attr_accessor :root
    def initialize(array)
        @root = build_tree(array)
    end

    def build_tree(array)
        start = 0
        ending = array.length - 1
        mid = (start + ending) / 2
        if start > ending
            return
        else
            left_array = array.slice(0, mid)
            right_array = array.slice(mid + 1, ending)
        end
        Node.new(array[mid], build_tree(left_array), build_tree(right_array))
    end

    def insert(value)
        return if value == @root.data
        explorer = locate_node_for_insertion(@root, value)
        if value < explorer.data
            explorer.left_child = Node.new(value)
        else
            explorer.right_child = Node.new(value)
        end
    end

    def delete(value)
        marked = locate_node_for_deletion(@root, value)
        marked_parent = locate_parent_node(@root, marked)
        if marked.left_child.nil? && marked.right_child.nil?
            if marked_parent.left_child == marked
                marked_parent.left_child = nil
            else
                marked_parent.right_child = nil
            end
        elsif !marked.left_child.nil? && !marked.right_child.nil?

        else    
            if marked.left_child.nil? && !marked.right_child.nil?
                marked.data = marked.right_child.data
                marked.right_child = nil
            elsif !marked.left_child.nil? && marked.right_child.nil?
                marked.data = marked.left_child.data
                marked.left_child = nil
            end
        end
    end

    def find(value)
        explorer = @root
        if explorer.data == value
            return true
        else
            children_confront_find(explorer, value)
        end
    end

    def locate_node_for_insertion(explorer, value)
        until explorer.left_child.nil? && explorer.right_child.nil?
            if value < explorer.data
                explorer = explorer.left_child
            else
                explorer = explorer.right_child
            end
        end
        explorer
    end

    def locate_node_for_deletion(explorer, value)
        until explorer.data == value
            if value < explorer.data
                explorer = explorer.left_child
            else
                explorer = explorer.right_child
            end
        end
        explorer
    end


    def locate_parent_node(explorer, child)
        until explorer.left_child == child || explorer.right_child == child
            if child.data < explorer.data
                explorer = explorer.left_child
            else
                explorer = explorer.right_child
            end
        end
        explorer
    end

    def children_confront_find(explorer, value)
        if data_check(explorer, value)
            return true
        elsif data_check(explorer, value) == false
            return false
        elsif value < explorer.data
            explorer = explorer.left_child
            children_confront_find(explorer, value)
        elsif
            explorer = explorer.right_child
            children_confront_find(explorer, value)
        end
    end

    def data_check(explorer, value)
        if explorer.nil?
            return false
        elsif explorer.data == value
            return true
        end
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
    end

end

class Node
    attr_accessor :data, :left_child, :right_child
    def initialize(data = nil, left_child = nil, right_child = nil)
        @data = data
        @left_child = left_child
        @right_child = right_child
    end
end


array = [1, 4, 8, 12, 32, 56, 78, 97, 121, 135, 245, 321, 654, 786, 981]
tree = Tree.new(array)


tree.pretty_print
tree.insert(31)
tree.pretty_print
tree.delete(32)
tree.pretty_print

# array = (Array.new(15) { rand(1..100) }).uniq!