%% showResult: function description
function [outputs] = showResult(dx, EcRTHS, EcBHS, JBHS, JRTHS, TrBHS, TrRTHS, dU)

	figure('units', 'normalized', 'outerposition', [0 0 1 1]);
	Axes = {
		subplot(1, 2, 1);
		subplot(1, 2, 2);
	};

	plot(Axes{1},...
		log(TrBHS, linspace(0, max(max(EcBHS)), length(Tr)));

	plotFormat( Axes{1}, ...
		'Transperent of BHS',...
		'$\ln T(E)$', 'Energy, eV', ...
		strcat(lF, strread(num2str(b),'%s'), lL), ...
		[], [], ...
		18 ...
	);

	plot(Axes{2}, dU, J(1,:));
	plotFormat( Axes{1}, ...
		strcat('Current density of BHS') , ...
		'$J$, A/m$^{-2}$', '$dU$, V', ...
		{}, ...
		[], [], ...
		18 ...
	);


	figure('units', 'normalized', 'outerposition', [0 0 1 1]);
	Axes = {
		subplot(1, 2, 1);
		subplot(1, 2, 2);
	};

	plot(Axes{1},...
		log(Tr(2, :)), linspace(0, max(max(Ec(2, :))), length(Tr(2:))));

	plotFormat( Axes{1}, ...
		'Transperent of RTHS',...
		'$\ln T(E)$', 'Energy, eV', ...
		{}, ...
		[], [], ...
		18 ...
	);

	plot(Axes{2}, dU, J(2, :));
	plotFormat( Axes{1}, ...
		strcat('Current density of BHS') , ...
		'$J$, A/m$^{-2}$', '$dU$, V', ...
		{}, ...
		[], [], ...
		18 ...
	);

	outputs = 1;