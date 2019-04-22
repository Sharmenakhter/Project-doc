function [ data ] = glcmsFeatureExtract(handles)
    
    numOfTumorRegion = bwconncomp(handles.bwfim1, 4);
    glcms = graycomatrix(handles.bwfim1);
    energy = sum(sum(glcms.^2));
    entrophy =(-1)*( sum(sum(dot(log(glcms),glcms))));
    glcms = reshape(glcms,4,1);

    areaOfTumor = sum(sum(handles.bwfim1));
    data = [ numOfTumorRegion.NumObjects ; energy; entrophy; glcms; areaOfTumor ]';
end