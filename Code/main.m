clear all
%Load in the image you want to reproduce

%im = imread('images\dino.png'); B = 0.1;
 
  im = imread('images\swing.png'); B = 0.1;

% im = imread('images\treeGap.png'); B = 0.8;
%  
%  load('specializedPalettes\treeGap_RanRgb18.mat');
%  palette = treeGap_RanRgb18;

%**************************************************************
% Pick and load in the palette (non-specialized)

% load('SpecRgb20.mat');
% palette = SpecRgb20;
% % 
% load('SpecRgb50.mat');
% palette = SpecRgb50;

load('SpecRgb100.mat');
palette = SpecRgb100;

% load('RanRgb21.mat');
% palette = RanRgb21; 

% load('RanRgb51.mat');
% palette = RanRgb51; 

% load('RanRgb100.mat');
% palette = RanRgb100;

%**************************************************************
%Set the amount of pixels you want to use in height and width
height = 200;
width = height;

%Size of bead
beadHeight = 20;
beadWidth = beadHeight;

%Create an empty matrix of the given size to put the reproduction into
reproduction = ones(height*beadHeight, width*beadWidth, 3);

%Resize the image to fit with the given size
resizedIm = imresize(im, [height width]);
imLab = rgb2lab(resizedIm);

%Convert the palette into lab values
palette = palette./255;
paletteLab = rgb2lab(palette);

%Reproduce the image using the chosen palette, making sure to represent one
%pixel with a bead of beadHeight x beadWidth
for i = 1:height

    for j = 1:width
            
        lab(1,:) = imLab(i,j,:);

        labm = repmat(lab, [length(paletteLab), 1]);

        difference = sqrt((labm(:,1)-paletteLab(:,1)).^2 +(labm(:,2)-paletteLab(:,2)).^2 +(labm(:,3)-paletteLab(:,3)).^2);

        minPos = find(difference == min(difference));

        beadBox = makeBeadBox(palette, minPos, beadHeight, beadWidth);
            
        reproduction((i-1)*beadHeight+1:i*beadHeight,(j-1)*beadHeight+1:j*beadHeight,:) = beadBox;

    end
    
end

%Create binary mask
binaryMask = createBinaryMask(height*beadHeight, width*beadWidth, beadHeight, beadWidth);

%Apply the binary mask
finalReproduction = binaryMask.*reproduction + ~binaryMask*B; 

%Check the quality (deltaE and S-CIELab)
[maxVal, meanVal, quality_scielab] = checkQuality(finalReproduction,im);

%Save the image using imwrite for future referense.
%imwrite(finalReproduction, 'images\imNoMask.png'); 

%Use imshow to see the final reproduction (mostly for testing)
imshow(finalReproduction)

