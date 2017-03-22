[row,col] = size(matchscore);
g_score1 = diag(matchscore);
 id_sys1 = eye(size(matchscore));
 imp_score1 = matchscore(~id_sys1);
range1 = 0:0.02:1;
 g_score1_hist = histc(g_score1,range1);
 imp_score1_hist = histc(imp_score1,range1);
 g_score1_pdf = g_score1_hist ./row ;
 imp_score1_pdf = imp_score1_hist ./ (row*row - row);
figure(1),plot(range1,g_score1_pdf);
 hold on
 plot(range1,imp_score1_pdf)
xlabel('Match Score');
ylabel('Probability');
title('GENUINE AND IMPOSTER SCORE DISTRIBUTION');
legend('Genuine distribution', 'Imposter Distribution');
hold off
% GAR vs FAR
for range1_index = 1:1:size(range1,2)
far_1_array(range1_index) =0;
for imp_score1_index = 1:1:182
if imp_score1(imp_score1_index) >= range1(range1_index)
far_1_array(range1_index) = far_1_array(range1_index)+1;
end
end
end
 for range1_index = 1:1:size(range1,2)
gar_1_array(range1_index) = 0;
 for g_score1_index = 1:1:14
if g_score1(g_score1_index) >= range1(range1_index)
gar_1_array(range1_index) =  gar_1_array(range1_index) + 1;
end
end
end
 far_1 = (far_1_array ./ 182)*100;
 gar_1 = (gar_1_array ./ 14)*100 ;
figure(2), plot (far_1,gar_1)
xlabel('False Acceptance Rate (%)');
ylabel('Genuine Acceptance Rate (%)'); 
title('RECEIVER OPERATING CHARACTERISTIC CURVE');


