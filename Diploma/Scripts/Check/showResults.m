%% showResults: function description
function [outputs] = showResults(x, CInit, CAnalyt, CNumFRes, CNumBRes, CNumCNRes)

	figure('units', 'normalized', 'outerposition', [0 0 1 1]);
	Axes = {
		subplot(1, 4, 1);
		subplot(2, 4, 2);
		subplot(2, 4, 3);
		subplot(2, 4, 4);
		subplot(2, 4, 6);
		subplot(2, 4, 7);
		subplot(2, 4, 8);
	};
	
	plot(Axes{1}, x, [CInit; CAnalyt; CNumFRes; CNumBRes; CNumCNRes]);
	plotFormat( Axes{1}, ...
		'Check: Analytical, FTCS, BTCS, Crank-Nicolson', ...
		'x', 'Part', ...
		{}, ...
		[], [], ...
		10 ...
	);

	plot(Axes{2}, x, abs(CAnalyt - CNumFRes));
	plotFormat( Axes{2}, ...
		'Error: Analytical/FTCS', ...
		'x', 'Difference', ...
		{}, ...
		[], [], ...
		10 ...
	);
	
	plot(Axes{3}, x, abs(CAnalyt - CNumBRes));
	plotFormat( Axes{3}, ...
		'Error: Analytical/BTCS', ...
		'x', 'Difference', ...
		{}, ...
		[], [], ...
		10 ...
	);
	
	plot(Axes{4},x, abs(CAnalyt - CNumCNRes));
	plotFormat( Axes{4}, ...
		'Error: Analytical/Crank-Nicolson', ...
		'x', 'Difference', ...
		{}, ...
		[], [], ...
		10 ...
	);
	
	plot(Axes{5},x, abs(CNumBRes - CNumFRes));
	plotFormat( Axes{5}, ...
		'Error: FTCS/BTCS', ...
		'x', 'Difference', ...
		{}, ...
		[], [], ...
		10 ...
	);
	
	plot(Axes{6},x, abs(CNumBRes - CNumCNRes));
	plotFormat( Axes{6}, ...
		'Error: BTCS/Crank-Nicolson', ...
		'x', 'Difference', ...
		{}, ...
		[], [], ...
		10 ...
	);

	plot(Axes{7},x, abs(CNumFRes - CNumCNRes));
	plotFormat( Axes{7}, ...
		'Error: FTCS/Crank-Nicolson', ...
		'x', 'Difference', ...
		{}, ...
		[], [], ...
		10 ...
	);

	outputs = 1;