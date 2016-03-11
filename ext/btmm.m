% SOURCE: http://sites.stat.psu.edu/~dhunter/code/btmatlab/btmm.m

function info=btmm(wm)
% function info=btmm(wm)
%
% btmm uses an MM algorithm to fit the Bradley-Terry model.
%
% The input wm is an nxn matrix such that wm(i,j) is the number of times 
% team i beat team j.
%
% The output is an nx1 vector of parameter estimates of "team skill".
%
% This algorithm does not contain any checks for lack of convergence;
% it is assumed that for any partition of the teams into sets A and B,
% at least one team from A beats at least one team from B at least once.

n=size(wm,1);
%flops(0);

% The parameter vector pi is constrained to keep its last
% entry equal to 1; thus, nmo stands for "n minus one".
nmo=n-1;
pi=ones(nmo,1); % initial value:  All teams equal
iteration=0;
change=realmax;
gm=wm(:,1:nmo)'+wm(1:nmo,:);
wins=sum(wm(1:nmo,:),2);
gind=(gm>0);
z=zeros(nmo,n);
pisum=z;

while change > 1e-08  % Simplistic convergence criterion
	iteration=iteration+1;
	pius=pi(:,ones(n,1));
	piust=pius(:,1:nmo)';
	piust(:,n)=ones(nmo,1);
	pisum(gind)=pius(gind)+piust(gind);
	
	z(gind) = gm(gind) ./ pisum(gind);
	newpi=wins ./ sum(z,2);
	change=newpi-pi;
	pi=newpi;
    change = norm(change);
    disp(['||change||=', num2str(change)]);
end
% Iterations = iteration
% Floating_point_operations=flops
info=pi;
info(n)=1;