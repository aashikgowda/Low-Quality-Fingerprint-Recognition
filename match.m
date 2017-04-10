%{
Matching function for features from Probe and Gallery

Aashik Nagadikeri Harish
aashikgowda@ufl.edu
%}
tic
pfiles = dir('C:\Users\aashi_000\Documents\MATLAB\Biometric\Fingerprint Enhancement\Probe\*.txt');
plen = length(pfiles);
gfiles = dir('C:\Users\aashi_000\Documents\MATLAB\Biometric\Fingerprint Enhancement\Gallery\*.txt');
glen = length(gfiles);
matchscore = zeros(plen,glen);
for x=1:plen
m01p =  load(fullfile('C:\Users\aashi_000\Documents\MATLAB\Biometric\Fingerprint Enhancement\Probe\', pfiles(x).name));    
for y = 1:glen
m01g = load(fullfile('C:\Users\aashi_000\Documents\MATLAB\Biometric\Fingerprint Enhancement\Gallery\', gfiles(y).name));
[row1,col1] = size(m01p);
[row2,col2] = size(m01g);
k_size = row1*row2;
for i =1:1:row1
    if m01p(i,3) >= 360
        m01p(i,3)= mod(m01p(i,3),360);
    end
end
for i =1:1:row2
    if m01g(i,3) >= 360
        m01g(i,3)= mod(m01g(i,3),360);
    end
end
C = cell(k_size,1);
A = cell(k_size,1);
count = 0;
for i=1:1:k_size
    A{i} = 0;
end
k =1;
for i=1:1:row2
   for j =1:1:row1
        theta_del = min(abs(m01g(i,3) - m01p(j,3)));
        x_del = m01g(i,1) - m01p(j,1)*cosd(theta_del) - m01p(j,2)*sind(theta_del);
        y_del = m01g(i,2) + m01p(j,1)*sind(theta_del) - m01p(j,2)*cosd(theta_del); 
        C{k}(1) = x_del;
        C{k}(2) = y_del;
        C{k}(3) = theta_del;
        k = k+1;
  end
end
for i=1:1:k_size
    for j = 1:1:k_size
        sub_1 = abs(C{i}(1) - C{j}(1));
        sub_2 = abs(C{i}(2) - C{j}(2));
        sub_3 = abs(C{i}(3) - C{j}(3));
        if sub_1 <= 15 && sub_2 <= 15 && sub_3 <= 10
            A{i}(1) = A{i}(1)+1;
        end
    end
end
A_array = cell2mat(A);
A_max = max(A_array);
[A_count] = find(A_array == A_max);
[row,col] = size(A_count);
Delta_val = cell(row,1);
for i=1:1:row
    Delta_val{i} = [0 0 0];
end
for i=1:1:row
Delta_val{i} = C{[A_count(i)]};
end
Detla_val = cell2mat(Delta_val);
if row > 1
transform = mean(Detla_val);
del_x = transform(1);
del_y = transform(2);
del_thet = transform(3);
elseif row == 1 
del_x = Detla_val(1);
del_y = Detla_val(2);
del_thet = Detla_val(3);
end
m01p_2 = zeros(row1,3);
for i = 1:1:row1
     m01p_2(i,1) = del_x + m01p(i,1)*cosd(del_thet) + m01p(i,2)*sind(del_thet) ;
     m01p_2(i,2) = del_y - m01p(i,1)*sind(del_thet) + m01p(i,2)*cosd(del_thet) ;
     m01p_2(i,3) = mod(del_thet + m01p(i,3),180) ;
end
dist = zeros(row2,row1); 
thet = zeros(row2,row1); 
 for i = 1:1:row2
    for j = 1:1:row1
     dist(i,j) = sqrt((m01g(i,1)-m01p_2(j,1))^2+(m01g(i,2)- m01p_2(j,2))^2);
        thet(i,j) = abs(m01g(i,3)- m01p_2(j,3));
    end
 end
 count_real=0;
  for i = 1:1:row2
      count = 0;
     for j = 1:1:row1
          if dist(i,j) < 20 && thet(i,j) < 12
             count = count+1;
          end
     end
     if count >=1
             count_real = count_real+1;
     end
  end
 matchscore(x,y) = (count_real/row1)*(count_real/row2);
end
end
toc
