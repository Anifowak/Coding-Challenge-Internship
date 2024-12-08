# Coding-Challenge-Internship
---
**Task**
You are going to develop a simple implementation of the MinHash algorithm, which will let you quickly calculate genetic distances between these samples.

---
**Reading k-mers**
First, you need to split the genomes into smaller parts which can be compared. A very common way to do this is using k-mers, which are substrings of length k.

---

**Step 1**
Write code to read in the DNA sequence from the above FASTA files, and count the occurences of 14-mers in each of the four files (storing these in a dictionary or similar). You may find it useful to load the whole genome as a string, and then treat it as an array of characters to run through the substrings within it.

**Step 2**
Using your dictionaries of 14-mer counts, write code which calculates the Jaccard distance between two of the input samples. You should ignore the actual values of the counts, and simply take any 14-mer which appears once or more as ‘present’. Most will appear exactly once.

**Step 3**
Find an implementation of a hash function and import it into your code. Calculate the hash of some example 14-mers, and confirm that the same 14-mer input maps to the same integer output.
Make sure you consider the forward and reverse strand of each k-mer. As standard practice, the hashes for the forward and reverse strands of each k-mer are compared, and the lowest hash of the two is taken to represent it in a sketch, known as a “canonical k-mer”.

**Step 4**
Make a sketch of each of the input sequences by following the steps above: mapping any present 14-mers (ignoring their actual count as before) to integers using a hash function, then taking the lowest 1000 values and storing these in a list/array. Save your sketches for each input sequence: either as a text file, or some other representation.
The Jaccard distance can now be approximated by again calculating the sizes of the intersection and union, but using the sketches (i.e. the 1000 hashes) instead of all of the 14-mers.

**Step 5**
For each pair of inputs, load their sketches, and calculate their Jaccard distance (not the Jaccard index!) using the sizes of the intersection and the union of the saved hash values.
