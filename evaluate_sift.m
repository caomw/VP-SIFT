function loc = evaluate_sift(image1, image2, H)
    I1 = single(rgb2gray(image1));
    I2 = single(rgb2gray(image2));
    
    [f1, d1] = vl_sift(I1);
    [f2, d2] = vl_sift(I2);
    matches = vl_ubcmatch(d1, d2);
    
    loc = 0;
    location_threshold = 20;
    
    for i = 1 : size(matches, 2)
        p1 = H * [f1(1:2, matches(1, i)); 1];
        %p1 = H * [f1(2, matches(1, i)); f1(1, matches(1, i)); 1];
        p2 = f2(1:2, matches(2, i));

        if norm(p1(1:2) - p2(1:2)) < location_threshold
        %if norm(p1(1:2) - p2(2:-1:1)) < location_threshold
            loc = loc + 1;
        end
    end
 
    loc = loc / size(matches, 2);
end