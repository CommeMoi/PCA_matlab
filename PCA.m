sample = [84 65 61 72 79 81; 64 77 77 76 55 70; 65 67 63 49 57 67; 74 80 69 75 63 74; 84 74 70 80 74 82;]
sampleSize = size(sample,1)
dimSize = size(sample,2)

meanOfEachDim = mean(sample)
centeredData = sample - repmat(mean(sample),sampleSize,1)

C3 = cov(sample) %standard matlab tools for cov


[EVectors,Evalues] = eig(C3)
[sortedD,orderD] = sort(diag(Evalues),'descend')
sortedEvalues = Evalues(orderD,orderD)
sortedEvectors = EVectors(:,orderD)

sumOfEvalues = sum(sortedD)
sumOfUsed = 0;

for i = 1:size(sortedD,1)
    sumOfUsed = sumOfUsed + sortedD(i);
    percentage = sumOfUsed/sumOfEvalues
end

k = 2
filteredEvalues = zeros(k);
filteredEvalues = sortedEvalues(1:k,1:k)
filteredEvectors = sortedEvectors(1:end,1:k)

rowFeatureVectors = filteredEvectors'
rowDataAdjust = centeredData'
FinalData = rowFeatureVectors*rowDataAdjust

originalData = ( (rowFeatureVectors' * FinalData ) + repmat(mean(sample),sampleSize,1)' )'
reconstructData = ( (rowFeatureVectors' * FinalData ) + repmat(mean(sample),sampleSize,1)' )'
sample
diff = sample - originalData
