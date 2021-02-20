% Currently the tool can only analyze the vtk format files. 
% Supports vtk 8.0 or smaller. Higher version might encounter some compatibility issues.

function [rho]=readvtk(component, nx,ny,nz,dx,filename)

system_size = nx*ny*nz;
% first=10+system_size*component;
% if(component > 0)
%     first = first + 2;
% last=first + system_size-1;

% M=dlmread(filename,'\t', [first 0 last 0]);

M=dlmread(filename,'\t', [10 0 10+system_size-1 0]);



%% Make 1D to 3D

rho=zeros(nx,ny,nz);
n = 1;
for i=1:nx
    for j=1:ny
        for k=1:nz
            rho(i,j,k)=M(n);
            n = n+1;
        end
    end
end
%%



end
