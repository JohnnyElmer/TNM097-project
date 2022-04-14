function [bead] = makeBeadBox(pallette, minPos, beadHeight, beadWidth)

    bead = ones(beadHeight,beadWidth, 3);

    for i = 1:beadHeight
        for j = 1:beadWidth
            bead(i,j,:) = pallette(minPos(1,:),:);
        end
    end

end