function result_histograms = createHistograms(dictionarySize,imagePaths,wordMapDir)

%imagePaths: cell array of image paths
%wordMapDir: directory that has the wordmaps

layers = 3;
histSize = dictionarySize * ( 4^layers - 1) / 3;
result_histograms = zeros(histSize,length(imagePaths));

for i = 1:length(imagePaths)
   imagePath = imagePaths{i};
   %viva la stackoverflow
   matPath = strrep(imagePath,'.jpg','.mat');
   mat = fullfile(wordMapDir,matPath);
   im_mat = load(mat);
   histogram = getImageFeaturesSPM(layers, im_mat.wordMap, dictionarySize);
   result_histograms(:,i) = histogram;
end                  

end