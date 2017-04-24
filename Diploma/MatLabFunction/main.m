clear; clc;

e = 1.6e-19; eVtoJ = e; JtoEv = e^(-1); 
me = 9.11*1e-31; nm = 1e-9;

T = 360; % K

checkTime = 0:1:10; %years

% atoms' radius
dx = 0.56; %nm
% Smooth
% dx = 0.3; %nm

% Count layers
% Active field
a = 8; % monolayers
b = 5;
c = 6;

sizeHS = a + b + c + b + a;

% Smooth
% a = a*2; % monolayers
% b = b*2;
% c = c*2;

% Fermi Energy
EFermi = 1.51*1e-20; % J

% Applyied voltage
dU = 0:0.01:0.5;

% grid of Al conentration
grid_x_Al = [zeros(1, a), ...
	0.44*ones(1, b), ...
	zeros(1, c), ...
	0.44*ones(1, b), ...
	zeros(1, a)
];

% Get profile Ec
% [grids_Ec, grids_meff, grids_C_Al] = getDiffCloseAlGaAs( grid_x_Al, checkTime, dx*nm, T );
% [grids_Ec, grids_meff, grids_C_Al] = getDiffOpenAlGaAs( grid_x_Al, checkTime, dx*nm, T );
% [grids_Ec, grids_meff, grids_C_Al] = getDiffCloseAlGaAsNd( grid_x_Al, checkTime, dx*nm, T, 5e15*1e6 );
% [grids_Ec, grids_meff, grids_C_Al] = getDiffOpenAlGaAsNd( grid_x_Al, checkTime, dx*nm, T, 5e15*1e6 );
[grids_Ec, grids_meff, grids_C_Al, Six] = getDiffAlGaAs_Si( grid_x_Al, checkTime, dx*nm, T, 2*1e18*1e6 );

% get J from V
for j = 1 : length(checkTime)
	J(j, :) = getJ(dx*nm, ...
		grids_meff(j, :)*me, ...
		grids_Ec(j, :)*eVtoJ, ...
		dU*eVtoJ, ...
		EFermi...
	);
end

figure('units', 'normalized', 'outerposition', [0 0 1 1]);
Axes = {
	subplot(1, 2, 1);
	subplot(1, 2, 2);
};

plot(Axes{1}, (0:a+b+c+b+a-1)*dx, grids_C_Al);
plotFormat( Axes{1}, ...
	strcat('Part of Aluminum, then $T=', num2str(T),'K$') , ...
	'z, $nm$', 'x, part of Al', ...
	strread(num2str(checkTime),'%s'), ...
	[0, (a+b+c+b+a-1)*dx], [], ...
	16 ...
);

plot(Axes{2}, (0:a+b+c+b+a-1)*dx, grids_Ec);
plotFormat( Axes{2}, ...
	strcat('Part of Aluminum, then $T=', num2str(T),'K$'), ...
	'z, $nm$', 'x, part of Al', ...
	strread(num2str(checkTime),'%s'), ...
	[0, (a+b+c+b+a-1)*dx], [], ...
	16 ...
);

figure('units', 'normalized', 'outerposition', [0 0 1 1]);
Axes = {
	subplot(1, 2, 1);
   	subplot(1, 2, 2); 
};

plot(Axes{1}, dU, [J(1, :); J(2, :)]);
plotFormat( Axes{1},...
	strcat('Current density, then $T=', num2str(T),'K$'), ...
	'U, $V$', 'J, $A/m^{2}$', ...
	strread(num2str(checkTime(1:2)),'%s'), ...
	[], [0, max(max(J(1:2, :)))], ...
	16 ...
);

plot(Axes{2}, dU, J);
plotFormat( Axes{2}, ...
	strcat('Current density, then $T=', num2str(T),'K$'), ...
	'U, $V$', 'J, $A/m^{2}$', ...
	strread(num2str(checkTime),'%s'), ...
	[], [0, max(max(J))], ...
	16 ...
);