function coordinates = branchPointCoordinates(datasetArray)

temp = datasetArray.branchPoints;
[tempVal, tempIndex] = unique(temp);
tempIndex(tempVal==0)=[];   % to remove the nonbranch point identifier, 0 value
tempCoord = getSampleCoordinates(datasetArray);
coordinates = [tempCoord(1,tempIndex); tempCoord(2,tempIndex); tempCoord(3,tempIndex)];
coordinates = coordinates';
% plot3(tempCoord(1,tempIndex),tempCoord(2,tempIndex),tempCoord(3,tempIndex),'*');

end