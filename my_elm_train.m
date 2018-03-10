function [train_time, train_acc, model] = my_elm_train(train_x, train_y, num_of_hid, C, act_func)
    tic;
    [n, ~] = histcounts(train_y);
    classes = find(n > 0) + 1;
    num_of_class = size(classes, 2);
    clear n;
    
    [t_row, n] = size(train_x); % n bir veride ki özellik sayýsý
    
    T = zeros(t_row, num_of_class);
    clear t_row;
    clear num_of_class;
    
    T = target(T, classes, train_y);
    
    m = num_of_hid; % gizli katmanda ki nöron sayýsý
    clear num_of_hid;
    
    w1 = 2 * rand(n, m) - 1; % 
    clear n;
    b1 = 2 * rand(1, m) - 1; % her gizli nörona bir bias deðeri 
    
    H1 = transpose(transpose(w1) * transpose(train_x)); % sütun bir nöronu ifade etmektedir.
    H1 = H1 + b1;
    H1 = activate(H1, act_func);
%     scaling factor of activation function
%     H1 = 0.1 .* H1;
    
%     w2 = rand(size(H1));
%     b2 = rand(1, size(H1, 2));
%     
%     H2 = w2 .* H1; % sütun bir nöronu ifade etmektedir.
%     H2 = H2 + b2;
%     H2 = activate(H2, act_func);
    
%     pinv_H = pinv(H1); % pseudo inverse of matrix
%     beta = pinv_H * T;
%     beta = transpose(H1) * pinv(1/5 + H1 * transpose(H1)) * T;
%     beta = H1 \ T; % solve linear equaiton
    
%     pinv_beta = pinv(beta);
%     beta2 = pinv_beta * T;

%  Ridge regression
    lambda = eye(m);
    lambda = (lambda .* C); % C regularization coefficient
    
    tr_H = transpose(H1);
    tr_H_mult_H = tr_H * H1;
    tr_H_mult_H = tr_H_mult_H + lambda;
    
%     beta = tr_H_mult_H \ tr_H;
%     beta = H1 * beta;
%     beta = beta * T;

    tr_H_T = tr_H * T;
    beta = tr_H_mult_H \ tr_H_T; % lineer denklem çözümü -> Ax = B -> x = A'B

%     beta = ridge(T, H1, C, 0);
    
    [~, res] = max(H1 * beta, [], 2);
    res = convert_class(res, classes);
    
    train_acc = ((numel(find(res == train_y))) / (numel(train_y))) * 100;
    
    model.w1 = w1;
    model.b1 = b1;
    model.beta = beta;
    model.act_func = act_func;
    
    train_time = toc;
end
