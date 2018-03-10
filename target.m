function T = target(T, classes, label)

    col = size(classes, 2);
    
    for i= 1:col
        T((classes(i) == label), i) = 1;
    end
end
