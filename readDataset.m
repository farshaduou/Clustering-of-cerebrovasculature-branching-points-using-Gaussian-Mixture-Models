function dataset = readDataset(n)

datasetLength = 0;

for i= 1:n     
    filename = ['data/NormalA',num2str(i,'%03.f'),'.mat'];
    if exist (filename,'file')
        datasetLength = datasetLength + 1 ;
        load(filename);
        dataset(datasetLength) = T;
    end
end