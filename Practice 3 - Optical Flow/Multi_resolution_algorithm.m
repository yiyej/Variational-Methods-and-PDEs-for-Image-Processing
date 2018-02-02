function [u_up,v_up]=Multi_resolution_algorithm(im1,im2,levels,tao,lambda,epsilon,algorithm_option)

[m,n,~]=size(im1);

m_top = uint16(m/2^levels);
n_top = uint16(n/2^levels);

u_up = zeros(m_top,n_top); %Initialize top u , v as 0 
v_up = u_up; 

%% create gaussian pyramid
    pyramid1 = cell(levels); %correspond to the pyramid with "levels-1" levels in the pdf
    pyramid1{1} = im1; %level-0 is original image
    
    pyramid2 = cell(levels);
    pyramid2{1} = im2;
    
    %downsample   
    for i=2:levels
        m_app=uint16(m/2^(i-1));
        n_app=uint16(n/2^(i-1));
        pyramid1{i} = imresize(pyramid1{i-1},[m_app,n_app]);
        pyramid2{i} = imresize(pyramid2{i-1},[m_app,n_app]);
        %pyramid2{i} = imresize(imfilter(pyramid2{i-1},filter),[m_app,n_app]);
    end

%% iterations
for l=levels:-1:1 
    
   %upsample of u to fit the current domain
    u_up=imresize(u_up,[uint16(m/2^(l-1)),uint16(n/2^(l-1))]);
    u_up=2.*u_up;
    
    %upsample of v to fit the current domain
    v_up=imresize(v_up,[uint16(m/2^(l-1)),uint16(n/2^(l-1))]);
    v_up=2.*v_up;
    
    im2_reg=Registration(u_up,v_up,pyramid2{l});
    
    %get optical flow using different algorithm    
    if algorithm_option == 'hs'
        [u_l,v_l]=getop(im2_reg,pyramid1{l},tao,lambda,epsilon,u_up,v_up);
        
    elseif algorithm_option == 'fb'
        [u_l,v_l]=getop_fb(im2_reg,pyramid1{l},tao,lambda,epsilon,u_up,v_up);
        
    elseif algorithm_option == 'tv'
        [u_l,v_l]=getop_tv(im2_reg,pyramid1{l},tao,lambda,epsilon,u_up,v_up);
        
    else
        error('algorithm is supposed to be one of (hs,fb,tv)');
        
    end
        
    u_up=u_up+u_l;
    v_up=v_up+v_l;

end

end