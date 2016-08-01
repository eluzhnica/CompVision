function [h] = getImageFeatures(wordMap,dictionarySize)

%check if all elements of wordMap are the same
%(otherwise function below will bug)
if(size(unique(wordMap),1)==1)
   h = zeros(1,dictionarySize);
   h(wordMap(1,1)) = 1;
   return;
end

%count cluster occurences
[c,indexes]=hist(wordMap,unique(wordMap));
h = zeros(1,dictionarySize);
h(indexes) = sum(c,2);
h = h / numel(wordMap);

end

