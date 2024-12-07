function hpol = polardb(theta, rho, lim, line_style)
% POLARDB Generates a polar plot for dB-scaled data.
% 
% Inputs:
%   theta      - Angles in radians (axes labeled in degrees)
%   rho        - Plot values in dB
%   lim        - Lower limit for plot in dB (e.g., -40)
%   line_style - String indicating line style (e.g., '-g') (optional)
%
% Example:
%   polardb(theta, beampatt, -40, '-r');

const = 0.7; % Scaling constant for plot radius

if nargin < 3
    error('Requires at least 3 input arguments.');
elseif nargin == 3
    line_style = '-b'; % Default line style
end

% Clip rho values below the limit
rho(rho < lim) = lim;
rho = (rho - lim) / 10; % Scale rho for plotting

% Create polar axes
cax = newplot;
hold_state = ishold;
hold on;

% Draw grid and radial lines
th = 0 : pi/50 : 2*pi;
xunit = cos(th);
yunit = sin(th);

% Radial grid lines
for i = 0:10
    plot(const * xunit * i, const * yunit * i, '--', 'color', [0.7 0.7 0.7]);
    text(const * i, 0, [num2str(i * 10 + lim)], 'VerticalAlignment', 'bottom');
end

% Plot spokes
spokes = (0:30:330) * pi / 180; % Spokes in radians
cst = cos(spokes);
snt = sin(spokes);
plot(const * [cst; -cst], const * [snt; -snt], '--', 'color', [0.7 0.7 0.7]);

% Annotate spokes
for i = 1:length(spokes)
    text(const * 10 * cst(i), const * 10 * snt(i), [num2str(i * 30 - 180)], ...
        'HorizontalAlignment', 'center');
end

% Transform data to Cartesian coordinates
xx = const * rho .* cos(theta);
yy = const * rho .* sin(theta);

% Plot data
hpol = plot(xx, yy, line_style);
set(hpol, 'LineWidth', 1.5);

% Format plot
axis equal;
axis off;

if ~hold_state
    hold off;
end
end
