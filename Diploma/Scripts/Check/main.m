clear; clc;

nm = 1e-9;
L = 100;
dx = 5;
x = 0 :dx: L;

CInit = sin(x*pi/L);

dt = 10;
t = [400, 1100];

D = 1.5;

for ind = 1 : length(t)
	CAnalyt(ind, :) = CInit*exp(-D*pi^2*t(ind)/L^2);
end

dtdx2 = dt/dx^2;
maxt = max(t);

CNumF = CInit';
lmbd = D*dtdx2;

d1 = [[lmbd*ones(1, length(x)-2)], 0];
d2 = [1, 1 - 2*lmbd*ones(1, length(x)-2), 1];
d3 = [0, lmbd*ones(1, length(x)-2)];

Matrix = diag(d1, -1) + diag(d2) + diag(d3, +1);

for j = 0 : dt : maxt
	CNumF = Matrix*CNumF;

	ind = find(j == t); 
	if (ind & j ~= 0)
		CNumFRes(ind, :) = CNumF';
	end
end

CNumB = CInit';
lmbd = D*dtdx2;

d1 = [[-lmbd*ones(1, length(x)-2)], 0];
d2 = [1, 1 + 2*lmbd*ones(1, length(x)-2), 1];
d3 = [0, -lmbd*ones(1, length(x)-2)];

Matrix = diag(d1, -1) + diag(d2) + diag(d3, +1);
invMatrix = inv(Matrix);
toc
tic
for j = 0 : dt : maxt
	CNumB = invMatrix*CNumB;

	ind = find(j == t); 
	if (ind & j ~= 0)
		CNumBRes(ind, :) = CNumB';
	end
end

CNumCN = CInit';
lmbd = D*dtdx2/2;
d1 = [[-lmbd*ones(1, length(x)-2)], 0];
d2 = [1, 1 + 2*lmbd*ones(1, length(x)-2), 1];
d3 = [0, -lmbd*ones(1, length(x)-2)];

MatrixL = diag(d1, -1) + diag(d2) + diag(d3, +1);
invMatrixL = inv(MatrixL);

d1 = [[lmbd*ones(1, length(x)-2)], 0];
d2 = [1, 1 - 2*lmbd*ones(1, length(x)-2), 1];
d3 = [0, lmbd*ones(1, length(x)-2)];

MatrixR = diag(d1, -1) + diag(d2) + diag(d3, +1);

Matrix = invMatrixL*MatrixR;
toc

tic
for j = 0 : dt : maxt
	CNumCN = Matrix*CNumCN;

	ind = find(j == t); 
	if (ind & j ~= 0)
		CNumCNRes(ind, :) = CNumCN';
	end
end

showResults(x, CInit, CAnalyt, CNumFRes, CNumBRes, CNumCNRes);