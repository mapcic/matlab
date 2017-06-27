clear; clc;

e = 1.6e-19; eVtoJ = e; JtoEv = e^(-1); 
me = 9.11*1e-31; nm = 1e-9;

% Do it smooth
dis = 1;
% atoms' radius
dx = 0.56; %nm
dx = dx/dis;
 
% Count layers
a = [3, 5, 7, 10]; % monolayers
b = 6;
c = 6;

a = a*dis;
b = b*dis;
c = c*dis;

sizeHS = a + b + c + b + a;

% Fermi Energy
EFermi = 1.51*1e-20; % J

% Applyied voltage
dU = 0:0.005:0.5;

% Ec
Ec1 = [zeros(1, a(1)), 0.5*ones(1, b), zeros(1, c), 0.5*ones(1, b), zeros(1, a(1))];
Ec2 = [zeros(1, a(2)), 0.5*ones(1, b), zeros(1, c), 0.5*ones(1, b), zeros(1, a(2))];
Ec3 = [zeros(1, a(3)), 0.5*ones(1, b), zeros(1, c), 0.5*ones(1, b), zeros(1, a(3))];
Ec4 = [zeros(1, a(4)), 0.5*ones(1, b), zeros(1, c), 0.5*ones(1, b), zeros(1, a(4))];

% meff
meff1 = [0.067*ones(1, a(1)), 0.15*ones(1, b), 0.067*ones(1, c), 0.15*ones(1, b), 0.067*ones(1, a(1))];
meff2 = [0.067*ones(1, a(2)), 0.15*ones(1, b), 0.067*ones(1, c), 0.15*ones(1, b), 0.067*ones(1, a(2))];
meff3 = [0.067*ones(1, a(3)), 0.15*ones(1, b), 0.067*ones(1, c), 0.15*ones(1, b), 0.067*ones(1, a(3))];
meff4 = [0.067*ones(1, a(4)), 0.15*ones(1, b), 0.067*ones(1, c), 0.15*ones(1, b), 0.067*ones(1, a(4))];

reserve = 10;

tic

J1 = getJ(dx*nm, ...
	meff1*me, ...
	Ec1*eVtoJ, ...
	dU*eVtoJ, ...
	EFermi, ...
	reserve, ...
	a(1),...
	b,...
	c...
);

J2 = getJ(dx*nm, ...
	meff2*me, ...
	Ec2*eVtoJ, ...
	dU*eVtoJ, ...
	EFermi, ...
	reserve, ...
	a(2),...
	b,...
	c...
);

J3 = getJ(dx*nm, ...
	meff3*me, ...
	Ec3*eVtoJ, ...
	dU*eVtoJ, ...
	EFermi, ...
	reserve, ...
	a(3),...
	b,...
	c...
);

J4 = getJ(dx*nm, ...
	meff4*me, ...
	Ec4*eVtoJ, ...
	dU*eVtoJ, ...
	EFermi, ...
	reserve, ...
	a(4),...
	b,...
	c...
);

U1 = getVs(dx*nm, ...
	meff1*me, ...
	Ec1*eVtoJ, ...
	dU*eVtoJ, ...
	EFermi, ...
	reserve, ...
	a(1),...
	b,...
	c...
);

U2 = getVs(dx*nm, ...
	meff2*me, ...
	Ec2*eVtoJ, ...
	dU*eVtoJ, ...
	EFermi, ...
	reserve, ...
	a(2),...
	b,...
	c...
);

U3 = getVs(dx*nm, ...
	meff3*me, ...
	Ec3*eVtoJ, ...
	dU*eVtoJ, ...
	EFermi, ...
	reserve, ...
	a(3),...
	b,...
	c...
);

U4 = getVs(dx*nm, ...
	meff4*me, ...
	Ec4*eVtoJ, ...
	dU*eVtoJ, ...
	EFermi, ...
	reserve, ...
	a(4),...
	b,...
	c...
);

numPoint = 5000;

Tr1 = getTransperent(...
	dx*nm, ...
	meff1*me, ...
	U1,...
	numPoint...
);

Tr2 = getTransperent(...
	dx*nm, ...
	meff2*me, ...
	U2,...
	numPoint...
);

Tr3 = getTransperent(...
	dx*nm, ...
	meff3*me, ...
	U3,...
	numPoint...
);

Tr4 = getTransperent(...
	dx*nm, ...
	meff4*me, ...
	U4,...
	numPoint...
);

toc

showResult(dx*nm, sizeHS, U1*JtoEv, U2*JtoEv, U3*JtoEv, U4*JtoEv, J1, J2, J3, J4, Tr1, Tr2, Tr3, Tr4, dU, a); % img 3.8 img 3.9