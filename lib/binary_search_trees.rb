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
        marked = locate_node(@root, value)
        if marked.left_child.nil? && marked.right_child.nil?
            delete_child(marked)
        elsif !marked.left_child.nil? && !marked.right_child.nil?
            delete_with_children(marked)
        else    
            delete_with_child(marked)
        end
    end

    def locate_minimum_right_sub_tree(marked)
        until marked.left_child.nil?
            marked = marked.right_child
        end
        marked
    end

    def delete_with_children(marked)
        successor = locate_minimum_right_sub_tree(marked)
        successor_parent = locate_parent_node(@root, successor)
        marked.data = successor.data
        successor_parent.right_child = nil
    end

    def delete_with_child(marked)
        if marked.left_child.nil? && !marked.right_child.nil?
            marked.data = marked.right_child.data
            marked.right_child = nil
        elsif !marked.left_child.nil? && marked.right_child.nil?
            marked.data = marked.left_child.data
            marked.left_child = nil
        end
    end

    def delete_child(marked)
        marked_parent = locate_parent_node(@root, marked)
        if marked_parent.left_child == marked
            marked_parent.left_child = nil
        else
            marked_parent.right_child = nil
        end
    end

    def find(value)
        return @root if @root.data == value
        children_confront_find(@root, value)
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

    def locate_node(explorer, value)
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
            return explorer
        elsif data_check(explorer, value) == false
            puts "There is no node with a value of #{value}"
            return
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

    def breadth_first
        queue = Array.new
        nodes = Array.new
        explorer = @root
        loop do
            queue.push(explorer.left_child).push(explorer.right_child).compact!
            nodes.push(explorer.data)
            explorer = queue[0]
            break if queue.empty?
            queue.shift
        end
        nodes
    end

    def level_order
        nodes = self.breadth_first
        if block_given?
            yield(nodes)
        else
            puts nodes.join(", ")
        end
    end

    def inorder
        nodes = Array.new
        explorer = @root
        dig_in(nodes, explorer)
        if block_given?
            yield(nodes)
        else
            puts nodes.join(", ")
        end
    end

    def dig_in(nodes, explorer)
        return if explorer.nil?
        dig_in(nodes, explorer.left_child)
        nodes.push(explorer.data)
        dig_in(nodes, explorer.right_child)
    end

    def preorder
        nodes = Array.new
        explorer = @root
        dig_pre(nodes, explorer)
        if block_given?
            yield(nodes)
        else
            puts nodes.join(", ")
        end
    end

    def dig_pre(nodes, explorer)
        return if explorer.nil?
        nodes.push(explorer.data)
        dig_pre(nodes, explorer.left_child)
        dig_pre(nodes, explorer.right_child)
    end

    def postorder
        nodes = Array.new
        explorer = @root
        dig_post(nodes, explorer)
        if block_given?
            yield(nodes)
        else
            puts nodes.join(", ")
        end
    end

    def dig_post(nodes, explorer)
        return if explorer.nil?
        dig_post(nodes, explorer.left_child)
        dig_post(nodes, explorer.right_child)
        nodes.push(explorer.data)
    end

    def depth(value)
        depth = 0
        explorer = @root
        return depth if explorer.data == value
        depth = depth_finding(explorer, value, depth)
    end

    def depth_finding(explorer, value, depth)
        if value == explorer.data
            return depth
        elsif value < explorer.data
            explorer = explorer.left_child
            depth += 1
            depth_finding(explorer, value, depth)
        elsif
            explorer = explorer.right_child
            depth += 1
            depth_finding(explorer, value, depth)
        end
    end

    def height(value)
        jumps_all = Array.new
        jumps = 0
        dig_height(jumps_all, find(value), jumps)
        height = jumps_all.max
    end

    def dig_height(jumps_all, explorer, jumps)
        if explorer.nil?
            return
        elsif explorer.left_child.nil? && explorer.right_child.nil?
            jumps_all.push(jumps)
        else
            jumps += 1
            dig_height(jumps_all, explorer.left_child, jumps)
            dig_height(jumps_all, explorer.right_child, jumps)
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
# double = Proc.new { | node |
#     node.map! do | element |
#         element *= 2
#     end
#     puts node.join(", ")
# }
# tree.pretty_print
# tree.level_order(&double)
# tree.level_order
tree.insert(31)
tree.insert(30)
tree.pretty_print
puts tree.height(12)


# array = (Array.new(15) { rand(1..100) }).uniq!