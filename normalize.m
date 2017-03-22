function [mask,im] = normalize(I,threshold)
blksize = 12;
fun1 = @(block_struct) std2(block_struct.data)*ones(size(block_struct.data));
stddev = blockproc(I,[blksize blksize],fun1);
mask_gen = stddev > threshold;
mask_op = imopen(mask_gen,strel('disk',4));
mask = imclose(mask_op,strel('disk',14));
figure(1),imshow(I)
hold on
imshow(mask)
alpha(0.5)
hold off
mask_ind = find(mask); 
im = (I - mean(I(mask_ind)))/std(I(mask_ind));
figure(2),imshow(im)
end

