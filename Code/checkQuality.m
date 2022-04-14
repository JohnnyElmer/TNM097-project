function [maxVal, meanVal,quality_scielab] = checkQuality(reproduction, original)

%deltaE
reproductionLab = rgb2lab(reproduction);

originalLab = imresize(original,[length(reproductionLab(:,1,:)) length(reproductionLab(1,:,:))],"bicubic");

originalLab = rgb2lab(originalLab);

difference = sqrt((reproductionLab(:,:,1)-originalLab(:,:,1)).^2 +(reproductionLab(:,:,2)-originalLab(:,:,2)).^2 +(reproductionLab(:,:,3)-originalLab(:,:,3)).^2);

maxVal = max(max(difference));
meanVal = mean(mean(difference));


%S-CIELab
reproduction_XYZ = rgb2xyz(reproduction);

original_XYZ = imresize(original,[length(reproductionLab(:,1,:)) length(reproductionLab(1,:,:))],"bicubic");

original_XYZ = rgb2xyz(original_XYZ);

ppi = 300;%120
distance = 40;%20
sampPerDeg = ppi * distance * tan(pi/180);

D65 = [95.05, 100, 108.9];

scielab_im = scielab(sampPerDeg,original_XYZ, reproduction_XYZ, D65, 'xyz');
quality_scielab = mean(mean(scielab_im));

end