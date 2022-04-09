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
puts tree.root.data


# array = (Array.new(15) { rand(1..100) }).uniq!

# initialize start = 0
# end = array.length - 1
# mid = (start + end) / 2
# create a tree node with middle root as A
# recursively do these two steps
#     calculate mid of left subarray and make it root of left subtree of a
#     calculate mid of right subarray and make it root of right subtree of a