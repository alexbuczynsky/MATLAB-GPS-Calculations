function theta = coordinateFindAngle(origin,axsRefP)
%coordinateFindAngle Finds angle to transform x,y pairs to x',y'
%
% - VARIABLE DEFINITIONS
%       INTERNAL VARS:
%           y0      = unit vector [0,1,0] from polar converted axis
%           x0      = unit vector [1,0,0] from polar converted axis
%       INPUT VARS:
%           origin  = geographic [lat,long] pair
%           axsRefP = user selected point to define the direction of the y axis
%       
% - METHOD EXPLANATION
%       The method is based on defining two points in the UTM Coordinate system:
%           Point 1: The origin
%           Point 2: An x-axis reference point
%       1. Convert these points to two relative x,y pairs.
%       2. Create a unit vector (y0) [0,1]
%       3. Subtract the difference in one dimension (the y-dimension was
%          used in this case) to create a second vector between the origin 
%          and the axis reference point called (y1) 
%       4. Rearrange and solve for theta in the dot product formula to find
%          the angle betweent vector y0 and y1.


%% Check user input
assert(nargin == 2,         'Incorrect number of input arguments');
assert(ismatrix(origin),    'Input 1 (origin) must be of type matrix')
assert(ismatrix(axsRefP),   'Input 2 (axsRefP) must be of type matrix')
refLat      = axsRefP(1);
refLon      = axsRefP(2);
centerLat   = origin(1);
centerLon   = origin(2);

%% Define variables
y0                  = [0,1]; %unit vector in y direction

[org(1),org(2)]     = deg2utm(centerLat,centerLon);
[ref(1),ref(2)]     = deg2utm(refLat,refLon);

y1                  = ref - org;

theta               = (90 - acosd( dot(y1,y0) / ( norm(y1)*norm(y0) ) ));
end