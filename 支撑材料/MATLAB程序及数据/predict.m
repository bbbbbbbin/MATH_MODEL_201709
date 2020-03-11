function p = predict(theta, X)

m = size(X, 1); 

p = zeros(m, 1);

k = find(sigmoid( X * theta) >= 0.62 );  
p(k) = 1; 

end