# Kronecker Regularized Least Squares with multiple kernels boosting algorithm
Matlab implementation of the Kronecker Regularized Least Squares with multiple kernels boosting algorithm. This project is an attempt to improve the kronrlsmkl (Kronecker Regularized Least Squares with multiple kernels learning) algorithm. We try to emply boosting to see if it performs better than learning when it comes to execution time and area under curve. We implemented the boosting algorithms on top of kronrlsmkl cloned from https://github.com/andrecamara/kronrlsmkl/ . Please refer to the following paper by Nascimento, André CA, Ricardo BC Prudêncio, and Ivan G. Costa for more information on kronrlsmkl. We have used the same set of kernel and data matrices provided by the paper above.

## usage
Please call the function sample in sample.m

## Reference:
Nascimento, André CA, Ricardo BC Prudêncio, and Ivan G. Costa. "A multiple kernel learning algorithm for drug-target interaction prediction." BMC Bioinformatics 17, no. 1 (2016): 1. 
URL: <http://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-016-0890-3>
