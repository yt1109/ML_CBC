function [node] = ClassNode(class, level)
   node.kids = cell(0);
   node.level = level;
   node.class = class;
end

