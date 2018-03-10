function [H] = activate(h, type)

    switch type
        case 'sigmoid'
            % 1 / (1 + exp(-x))
            H = 1 ./ (1 + exp(-0.5 * h));
        case 'softplus'
            % log(1 + exp(x)) base e
            H = log(1 + exp(h));
        case 'arctan'
            % tan^(-1) (x)
            H = atan(h);
        case 'tanh'
            % (2 / (1 + exp(-2 * x)) ) - 1
            %H = (2 ./ (1 + exp(-2 * h)) ) - 1;
            H = tanh(h);
        case 'bentiden'
            % ((sqrt(x^2 + 1) - 1) / 2) + x
            H = ((sqrt(h .^ 2 + 1) - 1) ./ 2) + h;
        case 'gaussian'
            % exp(-x ^ 2)
            H = exp(- h .^ 2);
        case 'sine'
            % sine(x)
            H = sin(h);
        case 'softsign'
            % x / (1 + |x|)
            H = h ./ (1 + abs(h));
        case 'relu'
            H = max(0, h);
        case 'lrelu'
            H = h;
            H(h < 0) = h(h < 0) .* 0.5;
            H(h >= 0) = h(h >= 0) .* 2;
    end
end
