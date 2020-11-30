function [ref_image] = CreateRefPlateImage(im,corners)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



end

% def create_ref(im_path, p2=None):
%     # get image corners:
%     im = cv2.imread(im_path)
%     im = cv2.cvtColor(im, cv2.COLOR_BGR2RGB)
% 
%     if p2 is not None:
%         corners = p2
%     else:
%         corners = getCorners(im)    # As we did in my_homography but for one image only
% 
%     top_l, top_r, bot_r, bot_l = corners[:, 0], corners[:, 1], corners[:, 2], corners[:, 3]
% 
%     # Calculate width and height of the image:
%     width = int(round(max(np.linalg.norm(top_r - top_l, 2), np.linalg.norm(bot_r - bot_l, 2))))
%     height = int(round(max(np.linalg.norm(bot_r - top_r, 2), np.linalg.norm(bot_l - top_l, 2))))
% 
%     # compute H for the transformation:
%     Rect = np.array([[0, 0], [width, 0], [width, height], [0, height]])
%     Rect = Rect.T
%     H = mh.computeH(Rect, corners)
%     ref_image = mh.warpH(im, H, (width, height))   # Includes only the selected object from the picture
% 
%     new_corners = np.array([[0,width,width,0], [0,0,height,height]])
% 
%     return ref_image, new_corners
