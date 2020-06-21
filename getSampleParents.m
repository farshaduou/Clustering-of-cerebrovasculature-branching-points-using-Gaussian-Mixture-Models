function parentsList = getSampleParents(datasetArray)

temp = datasetArray.V;

parentsList = nan(1,length(temp));

for i=1:length(temp)
    parentsList(1,i)=temp(i).parent;
end

end