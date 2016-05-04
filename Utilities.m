%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                     %%%
%%% Description: VP Lab 4 SIFT                                          %%%
%%%              Part 2 - Evaluation of sift                            %%%
%%% Authors: Rodrigo Daubt and Jose Bernal                              %%%
%%% Date: 21-04-2016                                                    %%%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Function handlers
function h = Utilities()
    h.evaluate_sift_one_scale = @evaluate_sift_one_scale;
    h.evaluate_normal_sift = @evaluate_normal_sift;
end

function loc = evaluate_sift_one_scale(image1, image2, H)
    loc = evaluate_sift(image1, image2, H, true);
end

function loc = evaluate_normal_sift(image1, image2, H)
    loc = evaluate_sift(image1, image2, H, false);
end

function loc = evaluate_sift(image1, image2, H, is_one_scale)
    I1 = single(rgb2gray(image1));
    I2 = single(rgb2gray(image2));
    
    if ~is_one_scale
        [f1, d1] = vl_sift(I1);
        [f2, d2] = vl_sift(I2);
    else
        [f1, d1] = vl_sift(I1, 'Octaves', 1);
        [f2, d2] = vl_sift(I2, 'Octaves', 1);
    end
    
    matches = vl_ubcmatch(d1, d2);
    
    loc = 0;
    location_threshold = 20;
    
    for i = 1 : size(matches, 2)
        p1 = H * [f1(1:2, matches(1, i)); 1];
        p1 = p1 / p1(end);
        p2 = f2(1:2, matches(2, i));

        if norm(p1(1:2) - p2(1:2)) < location_threshold
            loc = loc + 1;
        end
    end
 
    loc = loc / size(matches, 2);
end