function GenerateBinocularWallpaperGen(ress,bgcolor)

% Generates a wallpaper that can be used for checking/adjusting locations binocular(dual) displays
% function GenerateBinocularWallpaperGen(ress,:bgcolor)
% (: is optional)
%
% This function generates a special wallpaper on which several line and annulus guidelines are drawn.
% In binocular stimulus (e.g. stereograms, or binocular rivalry) presentation, we may present left and right
% eye images onto two displays separately (and we may also use an additional display for a console).
% In such a situation, a strict positional adjustment of the two displays will be necessary for accurate
% binocular fusion and precise measurements. The wallpaper(s) generated by this function can support these
% adjustment by presenting guidelines on the screen.
%
% [example]
% >> GenerateBinocularWallpaperGen([1920,1200;1920,1080;1920,1080],[127,127,127]);
% >> GenerateBinocularWallpaperGen([0,0;1920,1080;1920,1080],[127,127,127]);
%
% [input]
% ress: display resolutions, a 3 x 2 matrix.
%       [width_display_1, height_display_1; width_display_2, height_display_2; width_display_3, height_display_3]
%       here, display 1 is for a console, display 2 is for presenting left-eye image, and display 2 is for
%       presenting right-eye image.
%       e.g. ress=[1920,1200; 1920, 1080; 1920, 1080].
%       NOTE: if you don't use the console display (display 1) or the right-eye-image (display 3),
%       please set 0 to ress of these displays. e.g. ress=[0,0; 1920, 1080; 1920, 1080].
% bgcolor : (optional) background to be used on the console display (display 1)
%           bgcolor=[127,127,127] by default.
%
% [output]
% no output variable, the generated wallpaper image is saved in the current directory as
% wallpaper_[1|2|3]_display*.png
%
%
% Created    : "2016-01-17 14:57:53 ban"
% Last Update: "2021-06-17 00:08:27 ban"

%% check the input variables
if nargin<1 || isempty(ress), help(mfilename()); return; end
if nargin<2 || isempty(bgcolor), bgcolor=[127,127,127]; end

%% processing -- generating the required background (wellpaper) especially for binocular display location adjustments.

% get the maximum vertical display resolution.
max_res_v=ress(1,2);
for ii=2:1:size(ress,1)
  if ress(ii,2)>max_res_v, max_res_v=ress(ii,2); end
end

% initialize wallpaper image
wimg=uint8( repmat(reshape(bgcolor,[1,1,3]),[max_res_v,sum(ress(:,1)),1]) );

% generating the wallpaper for binocular display location adjustment.

% only disp 1 is used
if ress(1,1)~=0 && ress(2,1)==0 && ress(3,1)==0
  fprintf('processing display 1 alone with resolution: [width, height]=[%d, %d]...',ress(1,1),ress(1,2));

  img=GenerateWallpaperImages([ress(1,1),ress(1,2)]);
  wimg(1:ress(1,2),1:ress(1,1),:)=img{1};

  imwrite(wimg,sprintf('wallpaper_1_display_%dx%d.png',ress(1,1),ress(1,2)),'png');
  fprintf('completed.\n');

% only disp 2 is used
elseif ress(1,1)==0 && ress(2,1)~=0 && ress(3,1)==0
  fprintf('processing display 2 alone with resolution: [width, height]=[%d, %d]...',ress(2,1),ress(2,2));

  img=GenerateWallpaperImages([ress(2,1),ress(2,2)]);
  wimg(1:ress(2,2),1:ress(2,1),:)=img{1};

  imwrite(wimg,sprintf('wallpaper_1_display_%dx%d.png',ress(2,1),ress(2,2)),'png');
  fprintf('completed.\n');

% only disp 3 is used
elseif ress(1,1)==0 && ress(2,1)==0 && ress(3,1)~=0
  fprintf('processing display 3 alone with resolution: [width, height]=[%d, %d]...',ress(3,1),ress(3,2));

  img=GenerateWallpaperImages([ress(3,1),ress(3,2)]);
  wimg(1:ress(3,2),1:ress(3,1),:)=img{1};

  imwrite(wimg,sprintf('wallpaper_1_display_%dx%d.png',ress(3,1),ress(3,2)),'png');
  fprintf('completed.\n');

% only disp 1 and 2 are used
elseif ress(1,1)~=0 && ress(2,1)~=0 && ress(3,1)==0
  fprintf('processing display 1 & 2 with resolutions: [width, height]=[%d, %d] & [%d, %d]...',ress(1,1),ress(1,2),ress(2,1),ress(2,2));

  img=GenerateWallpaperImages([ress(2,1),ress(2,2)]);
  wimg(1:ress(2,2),ress(1,1)+1:ress(1,1)+ress(2,1),:)=img{2};

  imwrite(wimg,sprintf('wallpaper_2_displays_%dx%d_%dx%d.png',ress(1,1),ress(1,2),ress(2,1),ress(2,2)),'png');
  fprintf('completed.\n');

% only disp 1 and 3 are used
elseif ress(1,1)~=0 && ress(2,1)==0 && ress(3,1)~=0
  fprintf('processing display 1 & 3 with resolutions: [width, height]=[%d, %d] & [%d, %d]...',ress(1,1),ress(1,2),ress(3,1),ress(3,2));

  img=GenerateWallpaperImages([ress(3,1),ress(3,2)]);
  wimg(1:ress(3,2),ress(1,1)+1:ress(1,1)+ress(3,1),:)=img{3};

  imwrite(wimg,sprintf('wallpaper_2_displays_%dx%d_%dx%d.png',ress(1,1),ress(1,2),ress(3,1),ress(3,2)),'png');
  fprintf('completed.\n');

% only disp 2 and 3 are used, bonocular displays without a separatre console display
elseif ress(1,1)==0 && ress(2,1)~=0 && ress(3,1)~=0
  fprintf('processing display 2 & 3 with resolutions: [width, height]=[%d, %d] & [%d, %d]...',ress(2,1),ress(2,2),ress(3,1),ress(3,2));

  img_L=GenerateWallpaperImages([ress(2,1),ress(2,2)]);
  img_R=GenerateWallpaperImages([ress(3,1),ress(3,2)]);
  wimg(1:ress(2,2),1:ress(2,1),:)=img_L{2};
  wimg(1:ress(3,2),ress(2,1)+1:ress(2,1)+ress(3,1),:)=img_R{3};

  imwrite(wimg,sprintf('wallpaper_2_displays_%dx%d_%dx%d.png',ress(2,1),ress(2,2),ress(3,1),ress(3,2)),'png');
  fprintf('completed.\n');

% all 1-3 displays are used. the independent console + bonocular displays
elseif ress(1,1)~=0 && ress(2,1)~=0 && ress(3,1)~=0
  fprintf('processing display all 1-3 with resolutions: [width, height]=[%d, %d], [%d, %d], [%d, %d]...',ress(1,1),ress(1,2),ress(2,1),ress(2,2),ress(3,1),ress(3,2));

  img_L=GenerateWallpaperImages([ress(2,1),ress(2,2)]);
  img_R=GenerateWallpaperImages([ress(3,1),ress(3,2)]);
  wimg(1:ress(2,2),ress(1,1)+1:ress(1,1)+ress(2,1),:)=img_L{2};
  wimg(1:ress(3,2),sum(ress([1,2],1))+1:sum(ress([1,2],1))+ress(3,1),:)=img_R{3};

  imwrite(wimg,sprintf('wallpaper_3_displays_%dx%d_%dx%d_%dx%d.png',ress(1,1),ress(1,2),ress(2,1),ress(2,2),ress(3,1),ress(3,2)),'png');
  fprintf('completed.\n');

else
  error('at least one display should be set non-one value. check the parameters.');
end

return
