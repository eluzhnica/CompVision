
C = zeros(8,8);

for i=1:length(test_imagenames)
   guessed = guessImage(strcat(imageDir, test_imagenames{i}));
   index = 0;
   for j=1:8
       if strcmp(mapping(j), guessed)
           index = j;
           break;
       end
   end
   if test_labels(i)==7
      disp(test_imagenames(i))
   end
   C(test_labels(i), index) = C(test_labels(i), index) + 1;
end

disp(trace(C)/length(test_imagenames))