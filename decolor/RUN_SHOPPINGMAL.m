clear all
close all

addpath('internal');
addpath(genpath('gco-v3.0'));

dataName = 'shoppingmall';
load(['data\', dataName]);

ImData = reshape(shoppingmall, [1000, 256, 320]);
ImData = permute(ImData, [2, 3, 1]);
ImData = uint8(ImData);

[LowRank,Mask,tau,info] = ObjDetection_DECOLOR(ImData);
save(['result\' dataName '_DECOLOR.mat'],'dataName','Mask','LowRank','tau','info');    
load(['result\' dataName '_DECOLOR.mat'],'dataName','Mask','LowRank','tau');

moviename = ['result\' dataName,'_DECOLOR_bg.avi']; fps = 12;
mov = VideoWriter(moviename);
open(mov);
for i = 1:size(ImData,3)
    figure(1); clf;
    imshow(ImData(:,:,i)), axis off, colormap gray; axis off;
    imshow(LowRank(:,:,i)), axis off,colormap gray; axis off;
    writeVideo(mov,getframe(1));
end
close(mov);
