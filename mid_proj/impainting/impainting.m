clear all

dataName = 'shoppingmall';
load(['data\', dataName]);
shoppingmall = reshape(shoppingmall,1000,256,320);
I = shoppingmall(1,:,:);
I = reshape(I, 256, 320);
Omega = rand(size(I))>0.5;
I1 = mat2gray(I).*double(Omega);
alpha = sqrt(size(I1,1))*0.025;
X = mc_apg(I1,Omega,zeros(size(I1)),alpha,1e-4,500);
I2 = mat2gray(X);

figure;
subplot(1,2,1);
imshow(I1,'InitialMagnification','fit')
axis off;
subplot(1,2,2);
imshow(I2,'InitialMagnification','fit')
axis off;