load('../dat/traintest.mat');
imageDir = '../dat/';
% uncomment the line below if you want to recompute the dicitionary
%computeDictionary;
load('dictionary.mat','dictionary','filterBank');
% uncomment the line below if you want to recompute the visual words
fprintf('Visual words')
batchToVisualWords;

histFile = fullfile('../dat/','trainingFeatures.mat');
dictionarySize = size(dictionary,1);
train_features = createHistograms(dictionarySize,train_imagenames,'../dat/');
save(histFile,'train_features');
load(histFile,'train_features'); %will have a bug if you disable this, trust me.
save('vision.mat','filterBank','dictionary','train_features','train_labels');

