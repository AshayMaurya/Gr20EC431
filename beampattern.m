function beampattern(N, d, w, steer_angle)
% BEAMPATTERN Generates the beam pattern of a linear array.
% 
% Inputs:
%   N           - Number of elements in the array (default: 8)
%   d           - Inter-element spacing in wavelengths (default: 0.5)
%   w           - Weightings (default: uniform)
%   steer_angle - Steering angle in degrees (default: 0)
%
% Example:
%   beampattern(8, 0.5, ones(1,8), 30);

if nargin < 1, N = 8; end             % Default number of elements
if nargin < 2, d = 0.5; end           % Default spacing
if nargin < 3, w = 1/N * ones(1, N); end % Default uniform weights
if nargin < 4, steer_angle = 0; end   % Default steering angle

n = (-(N-1)/2 : (N-1)/2).';           % Element indices
theta = pi * (-1 : 0.001 : 1);        % Angle range in radians
u = cos(theta);                       % Direction cosines
vv = exp(1j * 2 * pi * d * n * u);    % Steering vector
theta_T = steer_angle / 180 * pi;     % Convert steering angle to radians
W = w .* exp(1j * n * pi * cos(theta_T)).'; % Steering weights
B = W * vv;                           % Array factor
B = 10 * log10(abs(B).^2);            % Convert to dB

% Plot the beam pattern using polardb
polardb(theta, B, -40, '-r'); % Use the provided polardb function
title('Beam Pattern');
end
