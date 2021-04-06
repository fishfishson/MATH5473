clear;
close all;
n = 320;
m = 256; %m & n for shoppingmall
r = 5;% 5 r : Target rank of underlying low rank matrix. 
p = 0.4;   
c = 1;   


%% Read the video Shopping mall
v = VideoReader('/Users/xueyangquan/Documents/MATLAB/DataReduction/Project 1/AccAltProj-Matlab Code-Ready version/shoppingmall.avi')
videof = read(v);
for i = 1:1000
frg = rgb2gray(videof(:,:,:,i));
videog(:,i) = frg(:);
end

D = double(videog);
%D : Observed matrix. Sum of underlying low rank matrix and underlying
%    sparse matrix. 


%% Solve D = L + S
[L1, S1] = AccAltProj(D, r, '' );


%% AccAltProj without trim, using all default parameters

% Reshape for shoppingmall
D = reshape(D,[256,320,1000]);
S1 = reshape(S1,[256,320,1000]);
L1 = reshape(L1,[256,320,1000]);
vw = VideoWriter('LowRank.avi');
vwS = VideoWriter('Sparse.avi');

open(vw);
for f = 1:1000
frame = L1(:,:,f);
writeVideo(vw,mat2gray(frame));
end
close(vw);

open(vwS);
for f = 1:1000
frame = S1(:,:,f);
writeVideo(vwS,mat2gray(frame));
end
close(vwS);



%% AccAltProj with trim
% % para.mu        = 1.1*get_mu_kappa(shoppingmall,r);  
% % para.beta_init = r*sqrt(para.mu(1)*para.mu(end))/(sqrt(m*n));
% % para.beta      = r*sqrt(para.mu(1)*para.mu(end))/(4*sqrt(m*n));
% % para.trimming  = true;
% % para.tol       = 1e-5;
% % para.gamma     = 0.5;
% % para.max_iter  = 100;
% % [L2, S2] = AccAltProj( shoppingmall, r, para );
% % 
% % for f = 1:1000%649
% % frame = L2(:,:,f);
% % writeVideo(vw,mat2gray(frame));
% % end
% % close(vw);
% % 
% % open(vwS);
% % for f = 1:1000%649
% % frame = S2(:,:,f);
% % writeVideo(vwS,mat2gray(frame));
% % end
% % close(vwS);
% L2_err = norm(L2-L_true,'fro')/norm(L_true,'fro')

    
    