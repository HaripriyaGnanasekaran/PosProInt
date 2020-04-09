function [slope intercept] = datafit(q,hq,start,ends)
qsquare=q(start:ends).*q(start:ends);
y=1./(qsquare.*hq(start:ends));
plot(qsquare,y)
[slope intercept]=polyfit(qsquare,y,1);

end