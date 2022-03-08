%**************************************************************
% Make smaller pallettes with the specifically chosen colours.
%**************************************************************

% load('SpecRgb100.mat');
% originalPallette = SpecRgb100;
% 
% %Get a pallette with 50 colours instead
% SpecRgb50 = zeros(50,3);
% k = 1;
% for i = 1:100
%     
%     if (mod(i,2) == 0)
%        SpecRgb50(k,:) =  originalPallette(i,:);
%        k = k + 1;
%     end
% 
% end
% 
% clear k i
% %Get a pallette with 20 colours instead
% SpecRgb20 = zeros(20,3);
% k = 1;
% for i = 1:100
%     
%     if (mod(i,5) == 0)
%        SpecRgb20(k,:) =  originalPallette(i,:);
%        k = k + 1;
%     end
% 
% end
% 
% %%
% %**************************************************************
% % Make smaller pallettes with the randomly chosen colours.
% %**************************************************************
load('RanRgb100.mat');
pallette = RanRgb100;
pallette = pallette./255;
palletteLab = rgb2lab(pallette);

L = palletteLab(:,1);
A = palletteLab(:,2);
B = palletteLab(:,3);
colorAmount = 100;
THRESHOLD = 15;
%Optimera färgpaletten, beräkna deltaE mellan det olika pixlarna.
for i = 1:1:colorAmount
    for j = i+1:1:colorAmount
        
        %Beräkna deltaE mellan valda pixeln och alla efterkommande pixlar
        deltaE = sqrt((L(i,:) - L(j,:)).^2 + (A(i,:) - A(j,:)).^2 + (B(i,:) - B(j,:)).^2);
        
        %Om färgen har ett deltaE mindre än threshold, dvs om färgen liknar
        %en annan, ta bort och gå vidare i loopen
        
        %TILL HANDLEDNING! Är detta en bra metod för att optimera
        %färgpaletten? Vilket värde bör tröskelvärdet ha för att få bra
        %resultat? Funkar?
        
        if deltaE < THRESHOLD
            if deltaE > 0
            %Sätt färgen som liknar till 0 värde för LAB.
            L(i,1) = 0;
            A(i,1) = 0;
            B(i,1) = 0;
            end
            break;
        end
    end
end

%Sätt ihop det 3 variablerna igen till en 3 dimensionel palett.
LAB = cat(2, L, A, B);
RanRgb51 = lab2rgb(LAB).*255;

%%
%**************************************************************
% Make smaller pallettes with image as basis.
% %**************************************************************
% load('SpecRgb100.mat');
% pallette = SpecRgb100;
% load('RanRgb100.mat');
% pallette = RanRgb100;
% pallette = pallette./255;
% palletteLab = rgb2lab(pallette);
% 
%  L = palletteLab(:,1);
%  A = palletteLab(:,2);
%  B = palletteLab(:,3);
% 
% 
% im = imread("images\swing.png");
% %im = imread("images\treeGap.png");
% %im = imread("images\dino.png");
% 
% imLab = rgb2lab(im);
% maxPos = zeros(size(palletteLab));
% height = length(im(1,:,:));
% width = height;
% n = 1;
% THRESHOLD = 48;
% 
% for i = 1:height
% 
%     for j = 1:width
%             
%         lab(1,:) = imLab(i,j,:);
% 
%         labm = repmat(lab, [length(palletteLab), 1]);
% 
%         deltaE = sqrt((labm(:,1)-palletteLab(:,1)).^2 +(labm(:,2)-palletteLab(:,2)).^2 +(labm(:,3)-palletteLab(:,3)).^2);
%         
% 
% %         maxPos(n,:) = find(deltaE == max(deltaE));
% %         n = n + 1;
% 
% %             if deltaE > THRESHOLD
% %             minPos = find(deltaE > THRESHOLD)
% %             L(minPos,1) = 0;
% %             A(minPos,1) = 0;
% %             B(fminPos,1) = 0;
% %             end
% 
% 
%     end
%     
% end
% 
% for k = 1:length(deltaE)
%     
%     if deltaE(k,1) > THRESHOLD
% 
%             L(k,1) = 0;
%             A(k,1) = 0;
%             B(k,1) = 0;
%     end
% 
% end
% 
% %L(L==0) = [];
% 
% LAB = cat(2, L, A, B);
% %%
% swing_RanRgb20 = lab2rgb(LAB).*255;

%%
load('SpecRgb100.mat');
pallette = SpecRgb100;
% load('RanRgb100.mat');
% pallette = RanRgb100;
pallette = pallette./255;
palletteLab = rgb2lab(pallette);

 im = imread("images\swing.png");
%im = imread("images\treeGap.png");
%im = imread("images\dino.png");
colorAmount = 100;
%colorAmount = 100;

[im_no_dither,map] = rgb2ind(im,colorAmount,'nodither');
mapLab = rgb2lab(map);

mapLabL = mapLab(:,1);
mapLabA = mapLab(:,2);
mapLabB = mapLab(:,3);

THRESHOLD = 15;
finalPalette = zeros(size(mapLab));

for i = 1:colorAmount
    for j = 1:100
        lab(1,:) = mapLab(i,:);

        labm = repmat(lab, [length(palletteLab), 1]);

        difference = sqrt((labm(:,1)-palletteLab(:,1)).^2 +(labm(:,2)-palletteLab(:,2)).^2 +(labm(:,3)-palletteLab(:,3)).^2);
        
        minPos = find(difference == min(difference));
        
        finalPalette(i,:) = pallette(minPos,:);
    end

end

finalPalette = finalPalette.*255;

%%
n = 0;
for k = 1:1:length(finalPalette(:,1))-1
    for l = k+1:1:length(finalPalette(:,1))
                                                       
        if finalPalette(k,:) == finalPalette(l,:)
            finalPalette(k,1) = NaN;
            finalPalette(k,2) = NaN;
            finalPalette(k,3) = NaN;
        end
    end
end

test = finalPalette;