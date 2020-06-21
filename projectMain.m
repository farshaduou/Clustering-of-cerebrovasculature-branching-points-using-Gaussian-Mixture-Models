% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Probabilistic Modeling Class Project
%  Farshad Mogharrabi
%  u1074636
%  Fall 2019
%  Cerebral Vasculature Tree Structure Inferece Project
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc; clearvars -except dataset; close all;

%% read dataset

subjectCount= 50 ; % for shorter run time set 50, set 108 as input here for reading the full dataset

dataset = readDataset(subjectCount); 


%% preprocess data: find branching points
progress = waitbar(0,'Finding branching points:');
for i = 1:length(dataset)
    waitbar(i/subjectCount);
    dataset(i).branchPoints = findBranchPoints( getSampleParents( dataset(i) ) );
end
close(progress);

%% Preprocess data: prepare coordinates of branching points

pointsOfInterest = [];

progress = waitbar(0,'<Extracting branching points coordinates>');
for i = 1:length(dataset)
    waitbar(i/subjectCount);
    pointsOfInterest = [pointsOfInterest;branchPointCoordinates(dataset(i))];
end
close(progress);

% checkpoint
plot3(pointsOfInterest(:,1),pointsOfInterest(:,2),pointsOfInterest(:,3),'*');

%% fit the Gassian Mixture Model

options = statset('MaxIter',1000);
Sigma = {'diagonal','full'};
SharedCovariance = {true,false};
groupsCount = 5;

GMModel = fitgmdist(pointsOfInterest,groupsCount,'CovarianceType',Sigma{2},'SharedCovariance',SharedCovariance{2},'Options',options);
clusterPoints = cluster(GMModel,pointsOfInterest);



%% visualize clustered data 

colors = 'rgbkmcy';
markers = 'osd*+.-';
figure;
for idx = 1 : groupsCount
    categoryData = pointsOfInterest(clusterPoints == idx,:);
    plot3(categoryData(:,1), categoryData(:,2), categoryData(:,3), [colors(idx) markers(idx)]);
hold on;
end
grid;

plot3(GMModel.mu(:,1),GMModel.mu(:,2),GMModel.mu(:,3),'co','linewidth',3)
legend {Group 1} {Group 2} {Group 3} {Group 4} {Group 5} {Group Means}
axis equal

% down-sampled visualization
figure;
for idx = 1 : groupsCount
categoryData = pointsOfInterest(clusterPoints == idx,:);
plot3(categoryData(1:10:end,1), categoryData(1:10:end,2), categoryData(1:10:end,3), [colors(idx) markers(idx)]);
hold on
end
grid on
plot3(GMModel.mu(:,1),GMModel.mu(:,2),GMModel.mu(:,3),'co','linewidth',3)
legend {Group 1} {Group 2} {Group 3} {Group 4} {Group 5} {Group Means}
axis equal
