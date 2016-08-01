function [histDistance] = distanceToSet(instanceHistogram, histograms)
    
    % the most annoying bug
    if(size(instanceHistogram,1)==1)
        instanceHistogram = instanceHistogram';
    end

    histDistance = sum(bsxfun(@min,instanceHistogram,histograms));

end