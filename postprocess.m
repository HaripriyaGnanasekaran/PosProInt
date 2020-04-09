%% Simulation parameters
system('rm spectrum_*.dat');
nx=256;
ny=256;
nz=31;
dx=1;
component=1;
filename = '../../covidsim';
simulationname='covidsim';
start = 3;
nfiles=start+3;
% 210 to 219 for 0.6
% 1 to 19 for 0.55 
%% Function Calls
hqa=zeros(nx,1);
ca=zeros(1,nx*2-1);
pdfha=zeros(1,100);
gra=zeros(1,nx-1);
for filenumber=start:nfiles-1
    fprintf('Running file %d \n',filenumber);
    fp=sprintf('%s_%d.vtk',filename,filenumber);
    [rho]=readvtk(component,nx,ny,nz,dx,fp);
    [rgibbs,hx,hy,q,hqx,hqy,cx,cy,lag,pdfh,h,gr,r]=calculateparameters(rho,nx,ny,nz,dx);
    hq=sqrt(hqx.^2 +hqy.^2);
    hqa=hq+hqa;
    ca=ca+(cx+cy)/2;
    pdfha=pdfha+pdfh;
    gra=gra+gr;
    
end
count=nfiles-start;
hq=hqa/count;
ca=ca/count;
pdfha=pdfha/count;
gra=gra/count;





loglog(q(1,1:end-1),hq(1,1:end-1),'-r');
%plot(lag(nx:2*nx-1),ca(nx:2*nx-1)/ca(nx));
%bar(h,pdfha);





















%% File writing
writefile=sprintf('spectrum_%s.dat',simulationname);
fp_w=fopen(writefile,'a');
[r c]=size(q);
for l=1:c
    fprintf(fp_w,'%.16e\t%.16e\n',q(1,l),hq(1,l));
end


%%
writefile=sprintf('pdf_%s.dat',simulationname);
fp_w=fopen(writefile,'a');
[r c]=size(h);
for l=1:c
    fprintf(fp_w,'%.16e\t%.16e\n',h(l),pdfh(l));
end

writefile=sprintf('smpdf_%s.dat',simulationname);
fp_w=fopen(writefile,'a');
[r c]=size(h);
for l=1:c
    fprintf(fp_w,'%.16e\t%.16e\n',h(l),h(l)*h(l)*pdfh(l));
end
dh=h(2)-h(1);
w=sqrt(sum(h.*h.*pdfh)*dh);
writefile=sprintf('tmpdf_%s.dat',simulationname);
fp_w=fopen(writefile,'a');
[r c]=size(h);
for l=1:c
    fprintf(fp_w,'%.16e\t%.16e\n',h(l),h(l)*h(l)*h(l)*pdfh(l));
end
skewness=(sum(h.*h.*h.*pdfh)*dh)/w^3;


writefile=sprintf('fmpdf_%s.dat',simulationname);
fp_w=fopen(writefile,'a');
[r c]=size(h);
for l=1:c
    fprintf(fp_w,'%.16e\t%.16e\n',h(l),h(l)*h(l)*h(l)*h(l)*pdfh(l));
end
kurtosis=(sum(h.*h.*h.*h.*pdfh)*dh)/w^4;
writefile=sprintf('gr_%s.dat',simulationname);
fp_w=fopen(writefile,'a');

%for l=1:180
%    fprintf(fp_w,'%.16e\t%.16e\n',l,gra(l));
%end