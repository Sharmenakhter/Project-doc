function featureVector = ExtractFeature(img)
        glcms = graycomatrix(img);
        glcms = glcms(1:4,1:4);
    energy = sum(sum(glcms.^2));
    entrophy =(-1)*( sum(sum(dot(log(glcms),glcms))));
    glcms = reshape(glcms,16,1);
    featureVector = [ energy; entrophy; glcms]'

end