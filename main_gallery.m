%{
Gallery Images - feature extraction

Aashik Nagadikeri Harish
aashikgowda@ufl.edu
%}
%************************IMAGE INPUT***************************%
files = dir('C:\Users\aashi_000\Documents\MATLAB\Biometric\Fingerprint Enhancement\Gallery\*.tif');
len = length(files);
Images{len} = [];
for k = 1:len
Images{k} = imread(fullfile('C:\Users\aashi_000\Documents\MATLAB\Biometric\Fingerprint Enhancement\Gallery\', files(k).name));
savdir = 'C:\Users\aashi_000\Documents\MATLAB\Biometric\Fingerprint Enhancement\Gallery\';
I = im2double(Images{k});
name = files(k).name;
name = strrep(name, '.tif','');
%************************NORMALIZATION*************************%
[mask,im] = normalize(I,0.05);
%**************************ORIENTATION*************************%
[theta,theta_degree] = orient(im,I);
%***********************RIDGE FREQUENCY************************%
[freqim, medianfreq] = ridgefreq(im,mask,theta,32,5,5,15);
%*************************FILTER BANK**************************%
newim =  ridgefilter(im,theta,freqim,0.5,0.5,1);
%***********************THINNING IMAGE*************************%
binim = newim > 0;
figure(7),imshow(binim)
roi_mask = bwmorph(binim,'thin',Inf);
ridgethin_image=bwmorph(~binim,'thin',Inf);
figure(8),imshow(ridgethin_image)
hbreak_rem=bwmorph(ridgethin_image,'hbreak',3);
iso_rem=bwmorph(hbreak_rem,'clean',3);
im_proc=bwmorph(iso_rem,'spur',4);
figure(9),imshow(im_proc)
%**********************MINUTIAE MARKING************************%
[minutiae] = minutiae_mark(im_proc,name,I,theta_degree,savdir,roi_mask);
end






















