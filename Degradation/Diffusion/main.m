% img 2.5, 2.7, 2.9
clear; clc;

e = 1.6e-19; eVtoJ = e; JtoEv = e^(-1); 
me = 9.11*1e-31; nm = 1e-9;

checkTime = 0 : 5; %years

dx = 1; %nm

a = 10; % monolayers
b = 30; 

sizeHS = a + b + a;

grid_x_Al = [
	zeros(1, a), ...
	ones(1, b), ...
	zeros(1, a)
];

nSi = 1e24;

[~, ~, grids_C_Al] = getDiffCloseAlGaAs( grid_x_Al, checkTime, dx*nm, 920 );
showResult(dx, sizeHS, grids_C_Al, 'Close Diffusion System', checkTime); %img 2.5

[~, ~, grids_C_Al] = getDiffOpenAlGaAs( grid_x_Al, checkTime, dx*nm, 920 );
showResult(dx, sizeHS, grids_C_Al, 'Open Diffusion System', checkTime); %img 2.7

[~, ~, grids_C_Al, grids_C_Si] = getDiffAlGaAs_Si(grid_x_Al, checkTime, dx*nm, 430, nSi);
showResultSi(dx, sizeHS, grids_C_Al, grids_C_Si, 'Not Constant $D$', checkTime); %img 2.9