function [J, grad] = costFunctionReg(theta, X, y, lambda)
m = length(y); 

J = 0;
grad = zeros(size(theta));

h = sigmoid(X * theta);
J = 1/m * ((-y'*log(h))-((1-y)'*log(1-h))) + lambda / (2*m) * sum(theta(2:end).^2);
grad_1 = theta(2:end);
grad = 1/m * X' * (h - y) + lambda / m * [0;grad_1];

end