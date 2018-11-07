function [rgibbs,hx,hy,q,hqx,hqy]=calculateparameters(rho,nx,ny,nz,dx)

%% Calculate the Gibbs plane for all x,y
rgibbs=zeros(nx,ny);
for i=1:nx
    for j=1:ny
        rgibbs(i,j)=(sum(rho(i,j,:)-rho(i,j,nz)))/(abs(rho(i,j,1)-rho(i,j,nz)));
    end
end

%% Calculate the height fluctuations for all x,y
hx=zeros(nx,ny); hy=zeros(ny,nx);
for i=1:nx
    for j=1:ny
        hx(i,j)=rgibbs(i,j)-mean(rgibbs(i,1:ny));
    end
end

for i=1:ny
    for j=1:nx
        hy(i,j)=rgibbs(j,i)-mean(rgibbs(1:nx,i));
    end
end

%% Calculate the spectrum 
hqxa=zeros(ny,1);
for i=1:nx
    [q,hqx]= fourier_wavespace(hx(i,1:ny),dx,ny);
    hqxa=hqx+hqxa;
end
hqx=hqxa/nx;

hqya=zeros(nx,1);
for i=1:ny
    [q,hqy]= fourier_wavespace(hy(i,1:nx),dx,nx);
    hqya=hqy+hqya;
end
hqy=hqya/ny;



end