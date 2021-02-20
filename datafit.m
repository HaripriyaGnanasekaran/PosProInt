% Linear Fitting function to get the rigidites. 
% slope will give the mean bending rigidity
% intercept will provide the interfacial tension

function [slope intercept] = datafit(q,hq,start,ends)
qsquare=q(start:ends).*q(start:ends);
y=1./(qsquare.*hq(start:ends));
plot(qsquare,y)
[slope intercept]=polyfit(qsquare,y,1);

end
