%% Simulation parameters
nx=50;
ny=50;
nz=50;
dx=1;
filename = 'tag5_';
nfiles=800;

%% Function Calls
hqa=zeros(nx,1);
for filenumber=600:nfiles
    
    fp=sprintf('%s%d.vtk',filename,filenumber);
    [rho]=readvtk(nx,ny,nz,dx,fp);
    [rgibbs,hx,hy,q,hqx,hqy]=calculateparameters(rho,nx,ny,nz,dx);
    hq=sqrt(hqx.^2 +hqy.^2);
    hqa=hq+hqa;
    
end

hq=hqa/nfiles;
figure(1)
loglog(q,hq,'-r*');
xlabel('q')
ylabel('|h(q)|^2 A');