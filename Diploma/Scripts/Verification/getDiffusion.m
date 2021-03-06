%% getDiffOpenAlGaAsNd: function description
function [resAlGrid, resSiGrid] = getDiffAlGaAs_Si(AlGrid, SiGrid, niGrid, TmGrid, dx, T)
	e = 1.6e-19; eVtoJ = e; JtoEv = e^(-1);
	nm = 1e-9; me = 9.1*1e-31;
	hbar = 1.054*1e-34; k_B = 1.38e-23;

	kT = T*k_B; % J

	% time = max(TmGrid); % to hours
	% time = max(TmGrid)*60; % to minutes
	% time = max(TmGrid)*60*60; % to seconds
	time = max(TmGrid); % to

	dt = 1; % step grid of time
	% dtdx2 = dt*60*60/dx^2; % s/m^2, T is hours
	% dtdx2 = dt*60/dx^2; % s/m^2, T is minute
	% dtdx2 = dt/dx^2; % s/m^2, T is sendond
	dtdx2 = dt/(dx)^2/10; % s/m^2, T is sendond

	if (find(0 == TmGrid))
		resAlGrid(1, :) = AlGrid;		
		resSiGrid(1, :) = SiGrid;		
	end

	len = length(AlGrid);

	AlGrid = AlGrid'; % To multiply
	SiGrid = SiGrid';

	for j = 0 : dt : time
		D = 0.17*exp(-3.5/(kT*JtoEv))*(SiGrid'./niGrid).^3*1e-4;

		D_plus = (D(1:len-1) + D(2:len))./2;
		D_minus = (D(2:len) + D(1:len-1))./2;

		d1 = [D_minus(1:end-1)*dtdx2, 0];
		d2 = [1, 1 - (D_plus(2:end) + D_minus(1:end-1))*dtdx2, 1];
		d3 = [0, D_plus(2:end)*dtdx2];
		Matrix = diag(d1, -1) + diag(d2) + diag(d3, +1);

		AlGrid = Matrix*AlGrid;
		SiGrid = Matrix*SiGrid;

		% ind = find(j == TmGrid); 
		% ind = find(j == TmGrid*60); 
		% ind = find(j == TmGrid*60*60); 
		ind = find(j == TmGrid); 
		if (ind & j ~= 0)
			resAlGrid(ind, :) = AlGrid;
			resSiGrid(ind, :) = SiGrid;
		end
	end
end