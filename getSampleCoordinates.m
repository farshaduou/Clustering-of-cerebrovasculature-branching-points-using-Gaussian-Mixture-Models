function coordinates = getSampleCoordinates(datasetArray)

temp = datasetArray.V;

coordinates = nan(3,length(temp));

for i=1:length(temp)
    coordinates(:,i)=temp(i).xyz;
end

end