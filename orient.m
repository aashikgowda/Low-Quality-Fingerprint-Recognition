function [theta,theta_degree] = orient(im,I)
im_f = imgaussfilt(im,1,'FilterSize',7);
% Compute gradient along x-axis and y-axis
% Compute gx^2, gy^2 and 2*gx*gy
[gx, gy]  = imgradientxy(im_f);
gx2 = gx.*gx ;gy2 = gy .* gy;
g2xy = 2.*gx .* gy;
Gx2 = imgaussfilt(gx2,5,'FilterSize',31);
Gy2 = imgaussfilt(gy2,5,'FilterSize',31);
Vx =  imgaussfilt(g2xy,6,'FilterSize',37);
Vy = Gx2 - Gy2;
Vy = imgaussfilt(Vy,5,'FilterSize',31);
% Determine theta value in degree and then convert to radian
theta_degree = 90 + (0.5 .* atan2d(Vx,Vy));
theta = theta_degree .* (pi/180);
spacing = 12;
   figure(3),imshow(I)
    [rows, cols] = size(theta);
    len = 0.8*spacing; 
    theta_orient = theta(spacing:spacing:rows-spacing, ...
		      spacing:spacing:cols-spacing);

    xoff = len/2*cos(theta_orient);
    yoff = len/2*sin(theta_orient);    
    % Determine placement of orientation vectors
    [x,y] = meshgrid(spacing:spacing:cols-spacing, ...
		     spacing:spacing:rows-spacing);
    x = x-xoff;
    y = y-yoff;
    % Orientation vectors
    u = xoff*2;
    v = yoff*2;

    figure(4),quiver(x,y,u,v,0,'.','linewidth',1);
    
    axis equal, axis ij,  hold off
   
    figure(5),imshow(I)
    hold on
    quiver(x,y,u,v,0,'.','linewidth',1);
    hold off
end

