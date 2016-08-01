function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)

h = [];
K = dictionarySize; 


L = layerNum - 1;
l = L;

rows = size(wordMap,1) / 2^l;
cols = size(wordMap,2) / 2^l;


oneLayerHistogram = zeros(1,K*(4^l));
prevHistograms = cell(2^l,2^l);

for i=1:int16(2^l)
    for j=1:int16(2^l)
        currentWordMap = wordMap((i-1)*rows+1:i*rows,(j-1)*cols+1:j*cols);
        currentHistogram = getImageFeatures(currentWordMap,K);
        prevHistograms{i,j} = currentHistogram; 

        lastPosition = int16(((i-1)*2^l + j-1)*K);
        start_i = int16(lastPosition + 1);
        end_i = int16(lastPosition + K);
        oneLayerHistogram(start_i:end_i) = currentHistogram;
    end
end

oneLayerHistogram = oneLayerHistogram / 4^l;

if(l==0 || l==1)
    weight = 2^(-L);
else
    weight = 2^(l-L-1);
end

oneLayerHistogram = weight*oneLayerHistogram;
h = [oneLayerHistogram h];

l = l - 1;

while l>=0
    oneLayerHistogram = zeros(1,dictionarySize*(4^l));
    currentHistograms = cell(2^l,2^l);
    for i=1:(2^l)
        for j=1:(2^l)
            currentHistograms{i,j} = prevHistograms{2*i-1,2*j-1} + prevHistograms{2*i,2*j-1} + ...
                                 prevHistograms{2*i-1,2*j}   + prevHistograms{2*i,2*j};
            currentHistograms{i,j} = currentHistograms{i,j} / 4; 
            
            lastPosition = int16(((i-1)*2^l + j-1)*K);
            start_i = int16(lastPosition + 1);
            end_i = int16(lastPosition + K);
            oneLayerHistogram(start_i:end_i) = currentHistograms{i,j};
        end
    end
    
    prevHistograms = currentHistograms;
    
    if(l==0 || l==1)
        weight = 2^(-L);
    else
        weight = 2^(l-L-1);
    end

    oneLayerHistogram = oneLayerHistogram / 2^(2*l);
    oneLayerHistogram = weight*oneLayerHistogram;
    h = [oneLayerHistogram h];
    l = l-1;
end


end