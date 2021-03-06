 % getJ: function description dx, meff, Ec, Ez
function J = getJ(dx, meff, Ec, dU, EFermi, r, a, b, c)
	e = 1.6e-19; eVtoJ = e; JtoEv = e^(-1); 
	hbar = 1.054*1e-34; k_B = 1.38e-23;
	T = 300;
	kT = T*k_B;

	k = ((2*meff(1)*e*kT)/(4*pi^2*hbar^3));
	J = k*ones(1, length(dU));

	ni = 1e12;
	Nd = 1e24;

	Ni = [Nd*ones(1, r), ni*ones(size(Ec)), Nd*ones(1, r)];

	eps = 13.18 - 3.12*[zeros(1, r), zeros(1, a), ones(1, b), zeros(1, c), ones(1, b), zeros(1, a), zeros(1, r)];

	for j = 1:length(dU)
		[V, n] = getConcentrationElectrons(0.001,...
			[Ec(1)*ones(1, r), Ec, Ec(end)*ones(1, r)],...
			[meff(1)*ones(1, r), meff, meff(end)*ones(1, r)],...
			Ni,...
			eps,...
			dx,...
			dU(j),...
			r + 1,...
			r + length(Ec)...
		);
		Uj = Ec - V(r+1:length(Ec)+r)*eVtoJ;
		% Uj = Ec - linspace( 0, dU(j), length(Ec) );
		dTDEz = @(Ez) TDEz(dx, meff, Uj, Ez, EFermi);
		J(j) = J(j)*integral(dTDEz, 0, 2*e, 'AbsTol', 1e-60);
		% hold on;
		% plot(1:length(Uj), Uj);
	end
	% plot(dU, J);
end
