% CODED BY : PUNEET DHEER
% DATE : 10-06-2019
% Gif_maker
%
function Gif_maker(frame)

if strcmp('frame_1',frame)
    
    frame = getframe(1);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    imwrite(imind, cm, 'GMMTest.gif', 'gif', 'Loopcount', inf, 'DelayTime', 0.3);
    
elseif strcmp('frame_onwards',frame)
   
   frame = getframe(1);
   im = frame2im(frame);
   [imind, cm] = rgb2ind(im, 256);            
   imwrite(imind, cm, 'GMMTest.gif', 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
   hold off
    
end

end