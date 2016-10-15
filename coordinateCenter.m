%coordinateOrigin finds the average position of lat / long positions
% input: coordinates of type mx2 matrix [lat,lon]
% ouput: origin of type mx2 matrix[lat,lon]

function origin = coordinateCenter(coordinates)
if nargin ~= 1
  warning('Incorrect number of input arguments');
  return
end

%% Setup Variables
lat         = coordinates(:,1);
long        = coordinates(:,2);
[~,~,UTM]   = deg2utm(lat(1),long(1));
%% Convert to XY
[x,y] = deg2utm(coordinates(:,1),coordinates(:,2));
%% Take average
mX  = mean(x);
mY  = mean(y);

[origin(1), origin(2)] = utm2deg(mX,mY,UTM);
end