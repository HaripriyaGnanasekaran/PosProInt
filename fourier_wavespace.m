function [q,hq]= fourier_wavespace(height_fluctuations,resolution,boxsize)
%%
% height_fluctuations is a vector of size equal to box size.
% resolution is the distance between two nodes in the simulation box. Grid
%   resolution
% box size is the total box size used in the simulation. If you had used a
% cuboidal box, the box size should be the size along which the height
% fluctuations are recorded. 

%%
dx=resolution;
qs=(2*pi)/dx;                         %Sampling wavenumber
nbox=boxsize;                       %Length of the signal sampled.
S=height_fluctuations;


Y=fft(S);
P2=(abs(Y/nbox)).^2;
P1=P2(1:nbox/2+1);
P1(2:end-1)=2*P1(2:end-1);
q=qs*(0:(nbox/2))/nbox;
hq=P1*nbox*nbox;

%%
%  figure(2)
%  loglog(q,P1*nbox*nbox,'-b*')
%  xlabel('q');
%  ylabel('<|h(q)|^2A>');
%  hold on
%  
%  figure(3)
%  loglog(q,P1,'-b*')
%  xlabel('q');
%  ylabel('<|h(q)|^2>');
%  hold on

end