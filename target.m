function T = target(T, classes, label)
    % prepare target array for the correct class of each entry
    col = size(classes, 2);
    
    for i= 1:col
        T((classes(i) == label), i) = 1;
    end
end
