function [test_time, test_acc, result] = my_elm_test(test_x, test_y, model)

    tic;
    [n, ~] = histcounts(test_y);
    classes = find(n > 0) + 1;
    clear n;
        
    H1 = transpose(transpose(model.w1) * transpose(test_x)); % sütunlar nöronu ifade etmektedir.
    H1 = H1 + model.b1;
    H1 = activate(H1, model.act_func);
    
    [~, result] = max(H1 * model.beta, [], 2);
    result = convert_class(result, classes);
    
    test_acc = ((numel(find(result == test_y))) / (numel(test_y))) * 100;
    
    test_time = toc;
end
