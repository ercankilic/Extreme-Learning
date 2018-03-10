function res_cl = convert_class(res, classes)

    res_cl = zeros(size(res));
    col = size(classes, 2);
    
    for i= 1:col
       res_cl(i == res) = classes(i);
    end
end
