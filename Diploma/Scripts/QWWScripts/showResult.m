%% showResult: function description
function [outputs] = showResult(dx, HS, Ec1, Ec2, Ec3, Ec4, J1, J2, J3, J4, dU, Tr1, Tr2, Tr3, Tr4, b)
	lF = {'$well =', '$well =', '$well =', '$well ='}';
	lL = {'$ monolayers', '$ monolayers', '$ monolayers', '$ monolayers'}';

	figure('units', 'normalized', 'outerposition', [0 0 1 1]);

	Axes = {
		subplot(4, 2, 1);
		subplot(4, 2, 3);
		subplot(4, 2, 5);
		subplot(4, 2, 7);
		subplot(1, 2, 2);
	};

	plot(Axes{1}, (0:HS(1)-1)*dx*1e9, Ec1);
	plotFormat( Axes{1}, ...
		'Potential energy' , ...
		'$x$, $nm$', '$E_{c}$, eV', ...
		strcat(lF(1), strread(num2str(b(1)),'%s'), lL(1)), ...
		[0, (HS(1)-1)*dx*1e9], [], ...
		10 ...
	);

	plot(Axes{2}, (0:HS(2)-1)*dx*1e9, Ec2);
	plotFormat( Axes{2}, ...
		'Potential energy' , ...
		'$x$, $nm$', '$E_{c}$, eV', ...
		strcat(lF(1), strread(num2str(b(2)),'%s'), lL(1)), ...
		[0, (HS(2)-1)*dx*1e9], [], ...
		10 ...
	);

	plot(Axes{3}, (0:HS(3)-1)*dx*1e9, Ec3);
	plotFormat( Axes{3}, ...
		'Potential energy' , ...
		'$x$, $nm$', '$E_{c}$, eV', ...
		strcat(lF(1), strread(num2str(b(3)),'%s'), lL(1)), ...
		[0, (HS(3)-1)*dx*1e9], [], ...
		10 ...
	);

	plot(Axes{4}, (0:HS(4)-1)*dx*1e9, Ec4);
	plotFormat( Axes{4}, ...
		'Potential energy' , ...
		'$x$, $nm$', '$E_{c}$, eV', ...
		strcat(lF(1), strread(num2str(b(4)),'%s'), lL(1)), ...
		[0, (HS(4)-1)*dx*1e9], [], ...
		10 ...
	);

	% plot(Axes{5},...
	% 	log(Tr1), linspace(0, max(max(Ec1)), length(Tr1)),...
	% 	log(Tr2), linspace(0, max(max(Ec1)), length(Tr2)),...
	% 	log(Tr3), linspace(0, max(max(Ec1)), length(Tr3)),...
	% 	log(Tr4), linspace(0, max(max(Ec1)), length(Tr4)));
	

	plot(Axes{5},...
		log(Tr1), linspace(0, max(max(Ec1)), length(Tr1)),...
		log(Tr2), linspace(0, max(max(Ec1)), length(Tr2)),...
		log(Tr3), linspace(0, max(max(Ec1)), length(Tr3)),...
		log(Tr4), linspace(0, max(max(Ec1)), length(Tr4)));

	plotFormat( Axes{5}, ...
		'Transperent of RTHS',...
		'$\ln T(E)$', 'Energy, eV', ...
		strcat(lF, strread(num2str(b),'%s'), lL), ...
		[], [], ...
		18 ...
	);
		
	figure('units', 'normalized', 'outerposition', [0 0 1 1]);
	Axes = {
		subplot(1, 2, 1);
		subplot(1, 2, 2);
	};

	plot(Axes{1}, dU, J1, dU, J2);
	plotFormat( Axes{1}, ...
		strcat('Current density') , ...
		 '$dU$, V', '$J$, A/m$^{-2}$',...
		strcat(lF(1:2), strread(num2str(b(1:2)),'%s'), lL(1:2)), ...
		[], [], ...
		18 ...
	);

	plot(Axes{2},  dU, J3, dU, J4);
	plotFormat( Axes{2}, ...
		strcat('Current density') , ...
		 '$dU$, V', '$J$, A/m$^{-2}$',...
		strcat(lF(1:2), strread(num2str(b(3:4)),'%s'), lL(1:2)), ...
		[], [], ...
		18 ...
	);

	outputs = 1;