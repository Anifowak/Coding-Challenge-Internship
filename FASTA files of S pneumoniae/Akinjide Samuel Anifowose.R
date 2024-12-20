# Load required libraries
if (!requireNamespace("BiocManager", quietly = TRUE))
   install.packages("BiocManager")
BiocManager::install("Biostrings")
install.packages("stringr") 

# Load libraries
library(Biostrings)
library(stringr)

# Function to read DNA sequence from a FASTA file and count 14-mers
count_14mers <- function(file_path) {
   # Step 1: Read DNA sequence from FASTA file
   dna_sequences <- readDNAStringSet(file_path)
   
   # Step 2: Concatenate all sequences into one long string (if multiple sequences)
   dna_string <- paste(as.character(dna_sequences), collapse = "")
   
   # Step 3: Extract 14-mers from the sequence
   generate_kmers <- function(dna_sequence, k) {
      seq_length <- nchar(dna_sequence)  # Get the length of the sequence
      kmers <- vector("character", seq_length - k + 1)  # Pre-allocate a vector for k-mers
      kmers[1] <- substr(dna_sequence, 1, k) # Get the first k-mer
      
      for (i in 2:(seq_length - k + 1)) {
         kmers[i] <- substr(dna_sequence, i, i + k - 1)  # Extract the k-mer
      }
      return(kmers) 
   }
   
   kmers <- generate_kmers(dna_string, 14)
   
   # Step 4: Count occurrences of each 14-mer
   kmer_counts <- table(kmers) # Create a frequency table
   
   # Return the 14-mer counts as a named vector
   return(kmer_counts)
}

# Function to count 14-mers from multiple FASTA files
count_14mers_from_files <- function(file_paths) {
   # Initialize an empty list to store the 14-mer counts for each file
   all_kmer_counts <- list()
   
   # Loop through each file and count 14-mers
   for (file_path in file_paths) {
      message("Processing file: ", file_path)
      kmer_counts <- count_14mers(file_path)
      all_kmer_counts[[file_path]] <- kmer_counts
   }
   
   return(all_kmer_counts)
}


# List of FASTA files to process
fasta_files <- c("C:/Users/anifo/OneDrive/Desktop/EMBL-EBI Internship/R6.fa", "C:/Users/anifo/OneDrive/Desktop/EMBL-EBI Internship/TIGR4.fa", "C:/Users/anifo/OneDrive/Desktop/EMBL-EBI Internship/14412_3#82.contigs_velvet.fa", "C:/Users/anifo/OneDrive/Desktop/EMBL-EBI Internship/14412_3#84.contigs_velvet.fa")

# Count 14-mers in each file and store the results in a list
all_kmer_counts <- count_14mers_from_files(fasta_files)

# View the 14-mer counts for one file (e.g., first file)
print(all_kmer_counts[[1]])
print(all_kmer_counts[[2]])
print(all_kmer_counts[[3]])
print(all_kmer_counts[[4]])


#STAGE 2
# Function to calculate Jaccard distance between two 14-mer dictionaries
calculate_jaccard_distance <- function(all_kmer_counts1, all_kmer_counts2) {
   
   # Step 1: Extract unique 14-mers (ignoring counts) from the two dictionaries
   kmers1 <- names(all_kmer_counts[[1]])  # Get names of 14-mers present in sample 1
   kmers2 <- names(all_kmer_counts[[2]])  # Get names of 14-mers present in sample 2
   
   # Step 2: Calculate the intersection and union of the two sets
   intersection <- length(intersect(kmers1, kmers2)) # Number of shared 14-mers
   union <- length(union(kmers1, kmers2))            # Total number of unique 14-mers
   
   # Step 3: Calculate Jaccard distance
   jaccard_distance <- 1 - (intersection / union)
   
   return(jaccard_distance)
}


# Calculate the Jaccard distance between the two samples
jaccard_distance <- calculate_jaccard_distance(kmers1, kmers2)
print(paste("Jaccard distance between the two samples is:", round(jaccard_distance, 4)))

# Function to calculate Jaccard distance between two 14-mer dictionaries
calculate_jaccard_distance <- function(all_kmer_counts3, all_kmer_counts4) {
   
   # Step 1: Extract unique 14-mers (ignoring counts) from the two dictionaries
   kmers3 <- names(all_kmer_counts[[3]])  # Get names of 14-mers present in sample 1
   kmers4 <- names(all_kmer_counts[[4]])  # Get names of 14-mers present in sample 2
   
   # Step 2: Calculate the intersection and union of the two sets
   intersection <- length(intersect(kmers3, kmers4)) # Number of shared 14-mers
   union <- length(union(kmers3, kmers4))            # Total number of unique 14-mers
   
   # Step 3: Calculate Jaccard distance
   jaccard_distance <- 1 - (intersection / union)
   
   return(jaccard_distance)
}


# Calculate the Jaccard distance between the two samples
jaccard_distance <- calculate_jaccard_distance(kmers3, kmers4)
print(paste("Jaccard distance between the two samples is:", round(jaccard_distance, 4)))


#STAGE 3
# Function to read the DNA sequence from a file
read_sequence_from_file <- function(file_path) {
   # Read the sequence from the FASTA file using Biostrings
   dna_sequence <- readDNAStringSet(file_path)
   
   # Convert the DNA sequence to a character string
   sequence <- as.character(dna_sequence[[1]])
   
   return(sequence)
}

# Function to generate k-mers from a sequence
generate_kmers <- function(sequence, k) {
   seq_length <- nchar(sequence)  # Get the length of the sequence
   kmers <- vector("character", seq_length - k + 1)  # Pre-allocate a vector for k-mers
   for (i in 1:(seq_length - k + 1)) {
      kmers[i] <- substr(sequence, i, i + k - 1)  # Extract the k-mer
   }
   return(kmers)
}

# Example file path (change this to the actual file path)
file_path <- c("C:/Users/anifo/OneDrive/Desktop/EMBL-EBI Internship/TIGR4.fa")

# Read sequence from the file
sequence <- read_sequence_from_file(file_path)

# Set the k-mer length
k <- 14

# Generate k-mers from the sequence
kmers <- generate_kmers(sequence, k)

# Print the k-mers
print(kmers)

library(digest)

# generate reverse complement of DNA sequence
get_reverse_complement <- function(dna_sequence) {
   # Define the complement pairs
   complements <- c(A = "T", T = "A", C = "G", G = "C")
   
   # Split the sequence into individual characters
   dna_chars <- unlist(strsplit(dna_sequence, split = ""))
   
   # Get the complement for each character
   complement_chars <- complements[dna_chars]
   
   # Reverse the complemented sequence and paste it back together
   reverse_complement <- paste(rev(complement_chars), collapse = "")
   
   return(reverse_complement)
}

# some 14-mers for this example
kmers <- c("CCTCACCCACTCCC", 
           "CTCACCCACTCCCA", 
           "TCACCCACTCCCAA",
           "CACCCACTCCCAAG", 
           "ACCCACTCCCAAGT", 
           "CCCACTCCCAAGTA",
           "CCACTCCCAAGTAT", 
           "CACTCCCAAGTATC", 
           "ACTCCCAAGTATCA",
           "CTCCCAAGTATCAG")

# get reverse complements
kmers_rev_comp <- sapply(kmers, get_reverse_complement)

# calculate a hash of the first k-mer, this comes back as a hex string. You could convert this to an integer (be aware this may be difficult in R as integers are 32-bits), but just using these hex strings directly for the steps below will work just as well
hash1 <- digest(kmers[1], algo = "murmur32", serialize = F, seed = 0)
hash1

# Run on all the k-mers in forward and reverse direction
hash_run1_forward <- unlist(lapply(kmers, digest, algo = "murmur32", serialize = F, seed = 0))
hash_run1_reverse <- unlist(lapply(kmers_rev_comp, digest, algo = "murmur32", serialize = F, seed = 0))

# use pmin to get the lowest hash for each pair of k-mers
hash_run1 <- pmin(hash_run1_forward, hash_run1_reverse)
hash_run1

# Confirm the same hashes are generated on repeated runs (so they are comparable between samples)
hash_run2_forward <- unlist(lapply(kmers, digest, algo = "murmur32", serialize = F, seed = 0))
hash_run2_reverse <- unlist(lapply(kmers_rev_comp, digest, algo = "murmur32", serialize = F, seed = 0))
hash_run2 <- pmin(hash_run2_forward, hash_run2_reverse)

all(hash_run1 == hash_run2)

#STAGE 4 and 5
# Function to generate sketch for the sequences
#First install necessary package and load the libraries
install.packages("seqinr")
install.packages("ape")

library(seqinr)
library(digest)
library(ape)
library (parallel)

# Get the reverse complement of the sequence 
revcomp <- function(sequence) { 
   complement <- chartr("ACGTacgt", "TGCAtgca", sequence) 
   return(paste(rev(unlist(strsplit(complement, ""))), collapse = "")) 
}

read_fasta_sequences <- function(file_path) {
   sequences <- read.fasta(file_path, seqtype = "DNA", as.string = TRUE) 
   sequence_list <- sapply(sequences, function(x) paste(x, collapse = "")) 
   return(sequence_list)
}

#Generate Hash values
hash_14mers <- function(sequence) { 
   kmers <- unique(sapply(1:(nchar(sequence) - 13), function(i) substr(sequence, i, i + 13))) 
   kmers_rev_comp <- sapply(kmers, revcomp) 
   
   hash_run1_forward <- unlist(lapply(kmers, digest, algo = "murmur32", serialize = FALSE, seed = 0)) 
   hash_run1_reverse <- unlist(lapply(kmers_rev_comp, digest, algo = "murmur32", serialize = FALSE, seed = 0)) 
   
   hashes <- pmin(hash_run1_forward, hash_run1_reverse) 
   # Debugging: Print the first few hash values to ensure they are computed correctly 
   print(head(hashes)) 
   return(hashes)
}

get_sketch <- function(hashes, k = 1000) { 
   if (length(hashes) < k) { 
      print("Warning: Less than 1000 hashes available.") 
   } 
   sorted_hashes <- sort(hashes) 
   return(sorted_hashes[1:min(k, length(sorted_hashes))]) 
}

#Read each FASTA file and process the sequences
fasta_files <- c("C:/Users/anifo/OneDrive/Desktop/EMBL-EBI Internship/R6.fa", "C:/Users/anifo/OneDrive/Desktop/EMBL-EBI Internship/TIGR4.fa", "C:/Users/anifo/OneDrive/Desktop/EMBL-EBI Internship/14412_3#82.contigs_velvet.fa", "C:/Users/anifo/OneDrive/Desktop/EMBL-EBI Internship/14412_3#84.contigs_velvet.fa")

# Parallel processing setup 
numCores <- detectCores() - 1 
cl <- makeCluster(numCores)

all_sequences <- unlist(lapply(fasta_files, read_fasta_sequences))
clusterExport(cl, c("hash_14mers", "get_sketch", "digest", "revcomp")) 

sketches <- parLapply(cl, all_sequences, function(seq) { 
   hashes <- hash_14mers(seq) 
   # Debugging: Print the first few hash values to ensure they are computed correctly 
   print(head(hashes)) 
   sketch <- get_sketch(hashes) 
   # Debugging: Print the first few sketch values to ensure they are created correctly 
   print(head(sketch)) 
   return(sketch)
}) 

stopCluster(cl) 

# Debugging: Print the first sketch to ensure it is generated correctly 
print(sketches[[1]])

#Save sketches
save_sketches <- function(sketches, file_name) {
   write.table(sketches, file = file_name, row.names = FALSE, col.names = FALSE)
}
sketch_filenames <- paste0(sequence_names, "_sketch.txt")
lapply(seq_along(sketches), function(i) save_sketches(sketches[[i]], sketch_filenames[i]))
                                                      
#Generate the Jaccard distance matrix for all sketches
jaccard_distance <- function(sketch1, sketch2) {
   intersection <- length(intersect(sketch1, sketch2))
   union <- length(union(sketch1, sketch2))
   return(1 - (intersection / union))
}

n <- length(sketches)
distance_matrix <- matrix(NA, n, n)
for (i in 1:n) {
   for (j in i:n) {
      distance_matrix[i, j] <- jaccard_distance(sketches[[i]], sketches[[j]])
      distance_matrix[j, i] <- distance_matrix[i, j]  # Distance is symmetric
   }
}
print(paste("Jaccard distance between the sequences is:", distance_matrix))

#BONUS
# Create the neighbor-joining tree 
nj_tree <- nj(as.dist(distance_matrix)) 
# Plot the tree 
plot(nj_tree, main = "Neighbor-Joining Tree based on Jaccard Distance") 
   