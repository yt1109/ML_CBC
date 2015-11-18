function [node] = ClassNode(class, level)
   node.kids = cell(0);
   node.class = class;
   node.level = level;
end

