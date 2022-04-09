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
        explorer == @root
        if value < explorer.data
            explorer = explorer.left_child
        else
            explorer = explorer.right_child
        end
    end

    def delete()

    end

    def find(value)
        explorer = @root
        if explorer.data == value
            return true
        else
            children_confront(explorer, value)
        end
    end

    def children_confront(explorer, value)
        if data_check(explorer, value)
            return true
        elsif data_check(explorer, value) == false
            return false
        elsif value < explorer.data
            explorer = explorer.left_child
            children_confront(explorer, value)
        elsif
            explorer = explorer.right_child
            children_confront(explorer, value)
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
puts tree.find(18)

# array = (Array.new(15) { rand(1..100) }).uniq!