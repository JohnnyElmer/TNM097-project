function [binaryImage] = createBinaryMask(height, width, beadHeight, beadWidth)

binaryImage = zeros(height, width);
hbh = beadHeight/2;
hbw = beadWidth/2;
bead = zeros(beadHeight,beadWidth);
n = 0;

%Create the bead itself
 for i = 1:hbh
     
    if mod(beadWidth,2) == 0

    bead(i, (hbw-n):(hbw+1+n)) = 1;

    bead(i+ hbw, (1+n):(beadWidth-n)) = 1;

    n = n + 1;

    elseif mod(beadWidth,2) ~= 0

    bead(i, (hbw+0.5-n):(hbw+0.5+n)) = 1;
    bead(i+ hbw -0.5, (1+n):(beadWidth-n)) = 1;
    n = n + 1;
    end
        
 end

%Put all beads into the mask
for i = 1:beadHeight:height
    for j = 1:beadWidth:width
       binaryImage(i:i+beadHeight-1,j:j+beadWidth-1) = bead;
    end
end
