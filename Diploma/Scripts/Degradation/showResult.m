%% showResult: function description
function [outResult] = showResult(grids_C_Al, grids_C_Si, grids_Ec, checkTime, J, sizeHS, dx, T, dU, Nd)
figure('units', 'normalized', 'outerposition', [0 0 1 1]);
Axes = {
	subplot(1, 2, 1);
	subplot(1, 2, 2);
};

checkTime = checkTime/360/24;
lF = {'$t =', '$t =', '$t =', '$t =', '$t =', '$t =', '$t ='}';
lL = {'$ years', '$ years', '$ years', '$ years', '$ years', '$ years', '$ years'}';

plot(Axes{1}, (0:sizeHS-1)*dx, grids_C_Al);
plotFormat( Axes{1}, ...
	strcat('Part of Al, then $T=', num2str(T),'K$, $N_{D}^{r}=', num2str(Nd), '\,m^{-3}$'), ...
	'z, $nm$', 'x, part of Al', ...
	strcat(lF, strread(num2str(checkTime),'%s'), lL), ...
	[0, (sizeHS-1)*dx], [], ...
	16 ...
);

plot(Axes{2}, (0:sizeHS-1)*dx, grids_C_Si);
plotFormat( Axes{2}, ...
	strcat('Concentration of Silicon, then $T=', num2str(T),'K$, $N_{D}^{r}=', num2str(Nd), '\,m^{-3}$'), ...
	'z, $nm$', 'x, part of Si', ...
	strcat(lF, strread(num2str(checkTime),'%s'), lL), ...
	[0, (sizeHS-1)*dx], [], ...
	16 ...
);

figure('units', 'normalized', 'outerposition', [0 0 1 1]);
Axes = {
	subplot(1, 2, 1);
	subplot(1, 2, 2);
};

plot(Axes{1}, dU, [J(1, :); J(2, :); J(3, :); J(4, :)]);
plotFormat( Axes{1},...
	strcat('Current density, then $T=300K$, $N_{D}=', num2str(Nd), '\,1/m^{-3}$'), ...
	'U, $V$', 'J, $A/m^{2}$', ...
	strread(num2str(checkTime(1:4)),'%s'), ...
	[], [0, max(max(J(1:2, :)))], ...
	16 ...
);

plot(Axes{2}, dU, J');
plotFormat( Axes{2}, ...
	strcat('Current density, then $T=300$, $N_{D}=', num2str(Nd), '\,1/m^{-3}$'), ...
	'U, $V$', 'J, $A/m^{2}$', ...
	strread(num2str(checkTime),'%s'), ...
	[], [0, max(max(J))], ...
	16 ...
);


outResult = 1
end