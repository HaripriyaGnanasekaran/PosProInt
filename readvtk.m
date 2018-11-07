function [rho]=readvtk(nx,ny,nz,dx,filename)

M=dlmread(filename,'\t',10,0);

%% Make 1D to 3D

rho=zeros(nx,ny,nz);
for i=1:nx
    for j=1:ny
        for k=1:nz
            rho(i,j,k)=M((i-1)*nx*ny+(j-1)*ny+k);
        end
    end
end
%%


end