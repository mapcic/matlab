%Img 4.7, 4.8
clear; clc;

e = 1.6e-19; eVtoJ = e; JtoEv = e^(-1); 
me = 9.11*1e-31; nm = 1e-9;

T = 100 + 273.5; % K

checkTime = [0, 2, 5, 10, 15, 16]*24*360; %years

% atoms' radius
dx = 0.56; %nm

% Count layers
r = 10; % monolayers
a = 10; % monolayers
b = 6;
c = 6;

sizeHS = r + a + b + c + b + a + r;

% Fermi Energy
EFermi = 1.51*1e-20; % J

% Applyied voltage
dU = 0:0.5:0.5;

% grid of Al conentration
grid_x_Al = [zeros(1, a), ...
	0.44*ones(1, b), ...
	zeros(1, c), ...
	0.44*ones(1, b), ...
	zeros(1, a)
];

Nd = 1.2*1e18*1e6;
% Get profile Ec
[grids_Ec, grids_meff, grids_C_Al, Six] = getDiffBAlGaAs_Si( grid_x_Al, checkTime, dx*nm, T, Nd);
% get J from V
for j = 1 : length(checkTime)
	J(j, :) = getJ(dx*nm, ...
		grids_meff(j, :)*me, ...
		grids_Ec(j, :)*eVtoJ, ...
		dU*eVtoJ, ...
		EFermi...
	);
end

showResult(grids_C_Al, Six/Nd, grids_Ec, checkTime, J, sizeHS, dx, T, dU, Nd); %Img 4.7, 4.8
