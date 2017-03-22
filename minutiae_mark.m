function [minutiae] = minutiae_mark(im_proc,name,I,theta_degree,savdir,roi_mask)
imopen=imclose(roi_mask,strel('square',20));
imClean= imfill(imopen,'holes');
imClean=bwareaopen(imClean,10);
imClean([1 end],:)=0;
imClean(:,[1 end])=0;
roi=imerode(imClean,strel('disk',20));
figure(10),imshow(roi)
fun = @minutiae_extract;
neighbour = nlfilter(im_proc,[3 3],fun);
neighbour = neighbour .* roi;
[x,y] = find(neighbour == 3);
for i=1:1:size(x,1)
    if im_proc(x(i),y(i)-1)==1&&im_proc(x(i)-1,y(i)+1)==1&&im_proc(x(i)+1,y(i)+1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i)-1,y(i))==1&&im_proc(x(i)+1,y(i)-1)==1&&im_proc(x(i)+1,y(i)+1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i)-1,y(i)-1)==1&&im_proc(x(i)+1,y(i)-1)==1&&im_proc(x(i),y(i)+1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i)-1,y(i)-1)==1&&im_proc(x(i)-1,y(i)+1)==1&&im_proc(x(i)+1,y(i))==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i)-1,y(i)-1)==1&&im_proc(x(i)+1,y(i))==1&&im_proc(x(i),y(i)+1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i),y(i)-1)==1&&im_proc(x(i)-1,y(i))==1&&im_proc(x(i)+1,y(i)+1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i)-1,y(i))==1&&im_proc(x(i)+1,y(i)-1)==1&&im_proc(x(i),y(i)+1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i),y(i)-1)==1&&im_proc(x(i)+1,y(i))==1&&im_proc(x(i)-1,y(i)+1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i)-1,y(i)-1)==1&&im_proc(x(i)+1,y(i)-1)==1&&im_proc(x(i)+1,y(i)+1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i)-1,y(i)-1)==1&&im_proc(x(i)-1,y(i)+1)==1&&im_proc(x(i)+1,y(i)-1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i)-1,y(i)+1)==1&&im_proc(x(i)+1,y(i)-1)==1&&im_proc(x(i)+1,y(i)+1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i)-1,y(i)-1)==1&&im_proc(x(i)-1,y(i)+1)==1&&im_proc(x(i)+1,y(i)+1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i),y(i)-1)==1&&im_proc(x(i),y(i)+1)==1&&im_proc(x(i)+1,y(i))==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i),y(i)-1)==1&&im_proc(x(i),y(i)+1)==1&&im_proc(x(i)-1,y(i))==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i)-1,y(i))==1&&im_proc(x(i)+1,y(i))==1&&im_proc(x(i),y(i)-1)==1
        neighbour(x(i),y(i)) = 3;
    elseif im_proc(x(i)-1,y(i))==1&&im_proc(x(i)+1,y(i))==1&&im_proc(x(i),y(i)+1)==1
        neighbour(x(i),y(i)) = 3;
    else
        neighbour(x(i),y(i)) = 2;
    end
end

%For Display
s=size(im_proc);
N=3;%window size
n=(N-1)/2;
r=s(1)+2*n;
c=s(2)+2*n;
double temp(r,c);   
temp=zeros(r,c);
temp((n+1):(end-n),(n+1):(end-n))=im_proc(:,:);
outImg=zeros(r,c,3);%For Display
outImg(:,:,1) = temp .* 255;
outImg(:,:,2) = temp .* 255;
outImg(:,:,3) = temp .* 255;
[ridge_x,ridge_y]=find(neighbour==1);
len=length(ridge_x);
%For Display
for i=1:len
    outImg((ridge_x(i)-3):(ridge_x(i)+3),(ridge_y(i)-3),2:3)=0;
    outImg((ridge_x(i)-3):(ridge_x(i)+3),(ridge_y(i)+3),2:3)=0;
    outImg((ridge_x(i)-3),(ridge_y(i)-3):(ridge_y(i)+3),2:3)=0;
    outImg((ridge_x(i)+3),(ridge_y(i)-3):(ridge_y(i)+3),2:3)=0;
    
    outImg((ridge_x(i)-3):(ridge_x(i)+3),(ridge_y(i)-3),1)=255;
    outImg((ridge_x(i)-3):(ridge_x(i)+3),(ridge_y(i)+3),1)=255;
    outImg((ridge_x(i)-3),(ridge_y(i)-3):(ridge_y(i)+3),1)=255;
    outImg((ridge_x(i)+3),(ridge_y(i)-3):(ridge_y(i)+3),1)=255;
end
[bifurcation_x,bifurcation_y] = find(neighbour==3);
len=length(bifurcation_x);
for i=1:len
    outImg((bifurcation_x(i)-3):(bifurcation_x(i)+3),(bifurcation_y(i)-3),1:2)=0;
    outImg((bifurcation_x(i)-3):(bifurcation_x(i)+3),(bifurcation_y(i)+3),1:2)=0;
    outImg((bifurcation_x(i)-3),(bifurcation_y(i)-3):(bifurcation_y(i)+3),1:2)=0;
    outImg((bifurcation_x(i)+3),(bifurcation_y(i)-3):(bifurcation_y(i)+3),1:2)=0;
    
    outImg((bifurcation_x(i)-3):(bifurcation_x(i)+3),(bifurcation_y(i)-3),3)=255;
    outImg((bifurcation_x(i)-3):(bifurcation_x(i)+3),(bifurcation_y(i)+3),3)=255;
    outImg((bifurcation_x(i)-3),(bifurcation_y(i)-3):(bifurcation_y(i)+3),3)=255;
    outImg((bifurcation_x(i)+3),(bifurcation_y(i)-3):(bifurcation_y(i)+3),3)=255;
end
figure(11),imshow(outImg);title('Minutiae');
bif_ind = sub2ind(size(I),bifurcation_x,bifurcation_y);
bif_theta = theta_degree(bif_ind);
ridge_ind = sub2ind(size(I),ridge_x,ridge_y);
ridge_theta = theta_degree(ridge_ind);
minutiae = [bifurcation_x,bifurcation_y,bif_theta;ridge_x,ridge_y,ridge_theta];
txtname = strcat(name,'.txt');
save(fullfile(savdir,txtname),'minutiae', '-ASCII','-append');
end

