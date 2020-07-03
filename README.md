# tSNE
# Language: R
# Input: TXT (key, value pairs)
# Output: CSV
# Tested with: PluMA 1.1, R 4.0.0
# Dependency: tsne_0.1.3

PluMA plugin to run t-Distributed Stochastic Neighbor Embedding Classifier
(van der Maaten et al, 2008) to determine, given
two sets of data and the values of multiple observables in each set, how well the
two sets can be separated based on these values.

The plugin accepts as input a TXT file with keyword, value pairs.  The keyword
"input1" should be mapped to the name of the first input datafile (CSV) and "input2"
to the second. 

Data will be output to a CSV file, with each sample and its x-y coordinates.

