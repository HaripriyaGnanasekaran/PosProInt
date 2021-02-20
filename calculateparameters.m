% Okay we need a lot of parameters before we can get the right spectrum
% list includes the gibbs radius to get the height of interface provided density in 3d box
% Only two component system  is studied. For more than 2 component this script will surely not work. 

function [rgibbs,hx,hy,q,hqx,hqy,corravgx,corravgy,lags,pdfh,h,gr,r]=calculateparameters(rho,nx,ny,nz,dx)

%% Calculate the Gibbs plane for all x,y
rgibbs=zeros(nx,ny);
sum1=0;sum2=0;
for i=1:nx
    for j=1:ny
    sum1=sum1+(rho(i,j,1)+rho(i,j,2))/2;
    sum2=sum2+(rho(i,j,nz)+rho(i,j,nz-1))/2;
    end
end
den=(sum1-sum2)/(nx*ny);



for i=1:nx
    for j=1:ny
        rgibbs(i,j)=(sum(rho(i,j,:)-(sum2/(nx*ny))))/den;
        %rgibbs(i,j)=normpdf(1,0,1);
        %rgibbs(i,j)=sin(2*pi*j/ny)+0.2*sin(4*pi*j/ny)+0.02*sin(6*pi*j/ny)+0.002*sin(8*pi*j/ny)+0.02*sin(100*pi*j/ny);%(rgibbs(i,j)-mean(rgibbs(i,1:ny)))+sin(4*j/ny);
    end
end

for loop=1:1
temp=[rgibbs(:,1) rgibbs rgibbs(:,nx)];
temp=[temp(1,:); temp; temp(nx,:)];

%Application of 9 point box filter. disable if not needed.
for i=1:nx
    for j=1:ny
        %rgibbs(i,j)= (temp(i+1,j)+2*temp(i+1,j+1)+temp(i+1,j+2)+temp(i,j+1)+temp(i+2,j+1))/6;
        rgibbs(i,j)= (temp(i+1,j)+temp(i+1,j+1)+temp(i+1,j+2)+temp(i,j+1)+temp(i+2,j+1)+temp(i,j)+temp(i+j+2)+temp(i+2,j)+temp(i+2,j+2))/9;
    end
    
end
end



%% Calculate the height fluctuations for all x,y
hx=zeros(nx,ny); hy=zeros(ny,nx);
for i=1:nx
    for j=1:ny
        hx(i,j)=(rgibbs(i,j)-mean(rgibbs(i,1:ny)));
    end
end
corravgx=zeros(1,nx*2-1);
for i=1:nx
    [corr,lags]=xcorr(hx(i,1:ny));
    corravgx=corravgx+corr;
end
corravgx=corravgx/nx;

for i=1:ny
    for j=1:nx
        hy(i,j)=rgibbs(j,i)-mean(rgibbs(1:nx,i));
    end
end
corravgy=zeros(1,ny*2-1);
for i=1:ny
    [corr,lags]=xcorr(hy(i,1:nx));
    corravgy=corravgy+corr;
end
corravgy=corravgy/nx;

%% Calculate the pdf of height 
edges=linspace(-4,4,101);
h=zeros(1,100);
for i=1:100
    h(i)=(edges(i)+edges(i+1))/2;
end
[N]=histcounts(hx,edges);
pdfh=N/(nx*ny*(h(2)-h(1)));

%% calculate g(r)
r=zeros(1,nx-1);
gr=zeros(1,nx-1);
for k=1:nx-1
    for i=1:nx-k
        for j=1:ny
            gr(k)= gr(k)+(hx(j,i+k)-hx(j,i))^2;
        end
    end
    gr(k)=gr(k)/(ny*(nx-k));
    r(k)=k;
end
%loglog(r,gr)
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
