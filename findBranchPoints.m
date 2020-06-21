function parents = findBranchPoints(parents)

for i=1:length(parents)
    if length(find(parents == parents(i))) == 1
        parents(i) = 0;
%     elseif length(find(parents == parents(i))) > 1
%             disp('HI!');
    end
end