function val = minutiae_extract(x)
[m,n] = size(x);
centre = floor(([m n]+1)/2);
if x(centre,centre)==0
    val = 0;
else
    val = sum(x(:))-1;
end

