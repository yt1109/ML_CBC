%{
for idx = 1:numel(y)
    disp(emolab2str(y(idx)));
end
function y = MAJORITYVALUE(binary_targets)




function y = CHOOSEBESTDECISIONATTRIBUTE(examples,attributes, binary_targets)



function y = DECISIONTREELEARNING(examples,attributes,binary_targets)
    if then
        //sth
    else if
            // sth
        else
                //
                
       return tree



cleandata = load('cleandata_students.mat');
%}
leaf.class= 0;
leaf.kids = cell(0);
%leaf.op = '';
leaf2.class= 0;
leaf2.kids = cell(0);
%leaf2.op = '';
%treeL = struct('op',[],'kids',[],'class',0); % a leaf
%treeR = struct('op',[],'kids',[],'class',1); % a leaf
tree.op = 'node';
tree.kids = {leaf, leaf2}; %a node with two leaves
%tree.class = ;
DrawDecisionTree(tree,'sample');