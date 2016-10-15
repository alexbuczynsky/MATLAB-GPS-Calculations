%coordinateTransformer(point,origin,theta,I)
%   The method is based on defining two points on a map... to be beter
%   explained later...
%   Variables defined:
%       latlongpair =
%       theta       = Angle (degrees)
%   
% - VARIABLE DEFINITIONS
%       INTERNAL VARS:
%           M       = transformation matrix used in affine transformation
%           A       = 2x1 Matrix of the origin's x,y pair.
%           B       = 2x1 Matrix of the point to point's x,y pair.
%       INPUT VARS:
%           origin  = geographic [lat,long] pair
%           point   = user selected point where the x,y distance is to be
%                     determined.
%           theta   = Angle determined in COORDINATEFINDANGLE that rotates
%                     the ordinate axis based on predetermined points. 
%           I       = 2x1 Unit Vector (Matrix) that determines the
%                     direction of the x or y axis.
%
%  What is the affine transformation:
%       Basically, the idea is to temporarily shift our circle so that it's
%       centered about the origin, apply a rotation matrix to the point as
%       done in linear algebra, then shift it back. To represent the
%       counterclockwise rotation through an angle theta. (if you want it
%       clockwise, swap the -sin(theta) with the sin(theta)), this
%       transformation is given by: C=M(BxA)+A where A,B,C are the vectors
%       representing their respective points.
%   See also COORDINATEFINDANGLE



function [x,y] = coordinateTransformer(origin,point,theta,I)
%% Check user input
assert(nargin == 4 || nargin == 3, 'Incorrect number of input arguments')
if nargin == 3
    I = [1;1];
end
assert(ismatrix(point) && ismatrix(origin),'origin and point must be an mx2 matrix.')

%% Define variables
[A(1),A(2),UTM] = deg2utm(origin(1),origin(2));
c = cosd(theta);
s = sind(theta);

%% Create transformation matrix (clockwise)
M = [c,s;-s,c];

%% Preallocate memory for speed for vars x,y
x = zeros(1,size(point,1));
y = zeros(1,size(point,1));
%% Perform Affine Transform
for ii = 1:size(point,1)
    [B(1),B(2),~]   = deg2utm(point(ii,1),point(ii,2));
    % F = M*(B'-A')+A'; %Not used... for debug purposes.
    F = M*(B'-A');
    F = F.*I; %Transform by flipping either x or y axis
    %% output
    x(ii) = F(1);
    y(ii) = F(2);
end
end