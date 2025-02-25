ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")
#creates string with 3 NCBI ID’s
library(rentrez) 
#loads rentrez package, gives ability to search NCBI database
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")
#downloads NCBI data from the NCBI ID’s list

#creating Sequences 
Sequences <- strsplit(Bburg, "\n\n")[[1]]

#making Sequences into a data frame
Sequences <- unlist(Sequences)
print(Sequences)

#separating sequences from headers using regular expressions 

header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)

#removing new line characters: 

Sequences<- gsub("[0-9]", "", Sequences)

Sequences<-data.frame(Name=header,Sequence=seq)

print(Sequences)


#saving as a CSV file: 
write.csv(Sequences, "Sequences.csv", row.names = FALSE) 



