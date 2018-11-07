# PosProInt
Post processing interfacial fluctuations to determine the dominant modes in wavenumber space. 

postprocess.m - Main file, which contains all the function calls.
readvtk.m - Function to read the vtk file. (You have to supply the density data of your simulation box as a vtk file. Sample file will be uploaded soon)
calculateparameters.m - Important parameters such as gibbs plane, height fluctuations are calculated here. Also contains the function call that determines the fourier transform of height fluctuations.
fourier_wavespace.m - Determines the fourier transformation of the vector with n(box size) discrete points, return q (wavenumber) and S(q) (structure factor). 



