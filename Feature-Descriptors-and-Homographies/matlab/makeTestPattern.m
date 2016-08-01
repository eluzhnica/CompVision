function [ compareX, compareY] = makeTestPattern(patchWidth, nbits)

patchSize = [patchWidth patchWidth];
pairs = randi([1, patchWidth], nbits, 4);

compareX = sub2ind(patchSize, pairs(:,1), pairs(:,2));
compareY = sub2ind(patchSize, pairs(:,3), pairs(:,4));
    
save('testPattern.mat', 'compareX', 'compareY');
end