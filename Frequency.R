###################################################################################################
############ Calculating CNVs frequency in controls population#####################################
###################################################################################################
# input the control CNVs file
data < -read.table("test.txt", header=T, sep="\t")

# input CNVs file for which frequency needed to be calculated
# names of the column should be chr, start, end
CNVs < -read.table("file.txt", header = T, sep = "\t")
outputCNVs < -c()
outputCNVsGains < -c()
SizeControl = 9649

for (k in 1:nrow(CNVs))
    {
    chr < -CNVs$chr[k]
    startt < -CNVs$start[k]
    endd < -CNVs$end[k]
    ddf < -paste(chr, startt, sep=": ")
    dd < -paste(ddf, endd, sep="- ")
    aa < -data[which(data$chr == chr), ]

    rr < -c()

    for (i in 1:length(aa$start))
    {
    if (((startt <= aa$end[i]) & (endd >= aa$end[i]) | ((startt <= aa$start[i]) & (endd >= aa$start[i]))) |
    ( (startt >= aa$start[i]) & (startt <= aa$end[i]) & (endd >= aa$start[i]) & (endd <= aa$end[i]) ) |
    ((startt <= aa$start[i]) & (startt <= aa$end[i]) & (endd >= aa$start[i]) & (endd >= aa$end[i]) ))
        {
         rr < -rbind(rr, aa$LossaAndGain[i])
        }
    }
sum(rr[, 1])
outputCNVs < -rbind(outputCNVs, dd)
outputCNVsGains < -rbind(outputCNVsGains, sum(rr[, 1]))
}

ddd < -cbind(outputCNVs, outputCNVsGains, round(((outputCNVsGains / SizeControl) * 100), 2))
colnames(ddd) < -c("CNV", "Num.Gain.Loss", "Frequency.in.control")
rownames(ddd) < -NULL
write.csv(ddd, "CNVsFre.CSV")
