%% getWaveFunction: function description
function [waveLeft, waveRigth] = getWaveFunction(delta, meff, U, Ez)
	eVtoJ = 1.6e-19;
	JtoEv = eVtoJ^(-1);
	me = 9.10938356*1e-31;
	hbar = 1.0551*1e-34;
	nm = 1e-9;

	EzLen = length(E);
	ULen = length(U);

	Ez = Ez*eVtoJ;
	U = U*eVtoJ;
	delta = delta*nm;

	waveLeft = zeros(EzLen, n);
	waveRigth = zeros(EzLen, n);

	for j = 1 : EzLen
		kLeft = sqrt( 2*meff(1)*me*(Ez(j)-U(1)) )/hbar;
		kRight = sqrt( 2*meff(end)*me*(Ez(j)-U(1)) )/hbar;

		d1 = meff(2:ULen)./meff(1:ULen-1);
		d2 = 2*delta^2*me*meff(2:end-1).*(E(j) - U(2:end-1)) - 2;
		d3 = meff(1:ULen-1)./meff(2:ULen);

		H = diag(d1, -1) + diag(d2) + diag(d3, +1);

		fLeft = [2*1i*kLeft*delta; zeros(lenU-1, 1)];
		fRight = [zeros(lenU-1, 1); 2*1i*kRight*delta];

		waveLeft(j, :) = (inv(H)*fLeft)';
		waveRigth(j, :) = (inv(H)*fRight)';
	end
	
end