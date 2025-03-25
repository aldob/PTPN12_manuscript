# Chord diagrams

library(circlize)



chr_order=c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6", "chr7", "chr8", "chr9", "chr10", "chr11", "chr12", "chr13", "chr14", "chr15", "chr16", "chr17", "chr18", "chr19", "chr20", "chr21", "chr22", "chrX")
cols <- c("#0000ff", "#9606D3FF", "#25A814FF", "#CB1704FF", "#13EDA0FF", "#8E053AFF", "#F92393FF", "#C8A5F0FF", "#F3AD16FF", "#EE44A8FF", "#00bfff", "#31DA13FF", "#ffb300", "#B8FAA7FF", "#7DC402FF", "#B2090CFF", "#8CF156FF", "#F6A9CEFF", "#ff2323", "#B998DCFF", "#B629DEFF", "#44abff", "#F8AAEAFF")
names(cols) = chr_order


plot_mat <- data.matrix(read.csv("wt_ut_l1_adj.csv", row.names=1))
colnames(plot_mat) <- rownames(plot_mat)
plot_mat2 <- data.matrix(read.csv("wt_d3_d1_adj.csv", row.names=1))
colnames(plot_mat2) <- rownames(plot_mat2)
norm_mat <- data.matrix(read.csv("ko_d3_d1_adj.csv", row.names=1))
colnames(norm_mat) <- rownames(norm_mat)

plot_mat[plot_mat <0] <- 0
plot_mat[plot_mat <0] <- 0
norm_mat[norm_mat <0] <- 0
gap = 360-(360*(sum(plot_mat)/sum(norm_mat)))
gap2 = 360-(360*(sum(plot_mat2)/sum(norm_mat)))



circos.clear()
circos.par(gap.after = c(gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23))
p <- chordDiagram(plot_mat, reduce=0, order = chr_order, grid.col = cols)
circos.clear()

circos.clear()
circos.par(gap.after = c(gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23, gap2/23))
p <- chordDiagram(plot_mat2, reduce=0, order = chr_order, grid.col = cols)
circos.clear()

circos.clear()
circos.par(gap.after = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
p <- chordDiagram(norm_mat, reduce=0, order = chr_order, grid.col = cols)
circos.clear()


# Deltas

plot_mat <- data.matrix(read.csv("wt_d3_d1_adj_delta.csv", row.names=1))
colnames(plot_mat) <- rownames(plot_mat)
norm_mat <- data.matrix(read.csv("ko_d3_d1_adj_delta.csv", row.names=1))
colnames(norm_mat) <- rownames(norm_mat)

plot_mat[plot_mat <0] <- 0
norm_mat[norm_mat <0] <- 0
gap = 360-(360*(sum(plot_mat)/sum(norm_mat)))



circos.clear()
circos.par(gap.after = c(gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23, gap/23))
p <- chordDiagram(plot_mat, reduce=0, order = chr_order, grid.col = cols)
circos.clear()

circos.clear()
circos.par(gap.after = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
p <- chordDiagram(norm_mat, reduce=0, order = chr_order, grid.col = cols)
circos.clear()











# rearrangment per chromosome heatmaps
library(gplots)



chr_order=c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6", "chr7", "chr8", "chr9", "chr10", "chr11", "chr12", "chr13", "chr14", "chr15", "chr16", "chr17", "chr18", "chr19", "chr20", "chr21", "chr22", "chrX")

wt_mat_ut <- data.matrix(read.csv("wt_ut_l1_adj.csv", row.names=1))
colnames(wt_mat_ut) <- rownames(wt_mat_ut)
wt_mat <- data.matrix(read.csv("wt_d3_d1_adj.csv", row.names=1))
colnames(wt_mat) <- rownames(wt_mat)
ko_mat_ut <- data.matrix(read.csv("ko_ut_l1_adj.csv", row.names=1))
colnames(ko_mat_ut) <- rownames(ko_mat_ut)
ko_mat <- data.matrix(read.csv("ko_d3_d1_adj.csv", row.names=1))
colnames(ko_mat) <- rownames(ko_mat)

wt_mat_delta <- wt_mat - wt_mat_ut
ko_mat_delta <- ko_mat - ko_mat_ut

hmcols1<- c((colorRampPalette(c("#000033","blue","#2d6cff", "#00b2ff","white","#ffb22e","#ff6100","red","#3d0000"))(100)))
maxval = max(c(abs(min(ko_mat_delta, na.rm=TRUE)), max(ko_mat_delta, na.rm=TRUE)))
breaks <- seq(from=-maxval, to=maxval, length.out=101)

png(file = ("plots/hm_ko_mat_delta_adj.png"), width=1.5, height=1.5, units="in", res=1000, pointsize = 2)
heatmap.2(ko_mat_delta, scale='none', trace = "none", breaks=breaks, labRow=FALSE, labCol=FALSE, col=hmcols1, Rowv = FALSE, Colv = FALSE, density.info = "none", na.color="grey", dendrogram = "none")
dev.off()
pdf(file = ("plots/hm_wt_mat_delta_adj.pdf"), width=3, height=3, pointsize = 2)
heatmap.2(wt_mat_delta, scale='none', trace = "none", breaks=breaks, labRow=FALSE, labCol=FALSE, col=hmcols1, Rowv = FALSE, Colv = FALSE, density.info = "none", na.color="grey", dendrogram = "none")
dev.off()












# Mutation rate heatmaps

library(gplots)
hmcols8<- c((colorRampPalette(c("#000033","blue"))(25)), (colorRampPalette(c("blue","#2d6cff"))(25)), (colorRampPalette(c("#2d6cff","#00b2ff"))(25)), (colorRampPalette(c("#00b2ff","white"))(25)),(colorRampPalette(c("white","#ffb22e"))(25)),(colorRampPalette(c("#ffb22e","#ff6100"))(25)),(colorRampPalette(c("#ff6100","red"))(25)),(colorRampPalette(c("red","#3d0000"))(25)))



plot_mat <- data.matrix(read.csv("mut_heatmap_tab.csv", row.names=1))
plot_mat_raw <- data.matrix(read.csv("mut_heatmap_tab_raw.csv", row.names=1))
plot_mat_scaled <- t(apply(plot_mat_raw, 1, FUN=function(x) scale(x, center=FALSE)))

pdf(file = ("plots/heatmap_muts_normed_nonc_8.pdf"), width=3, height=2, pointsize = 2)
heatmap.2(plot_mat_scaled, scale='none', trace = "none", labRow=FALSE, labCol=FALSE, col=hmcols8, Rowv = FALSE, Colv = FALSE, density.info = "none", na.color="grey", dendrogram = "none", notecol='black')
dev.off()

pdf(file = ("plots/heatmap_muts_raw_8.pdf"), width=3, height=2, pointsize = 2)
heatmap.2(plot_mat_raw[2:4,], scale='none', trace = "none", labRow=FALSE, labCol=FALSE, col=hmcols8, Rowv = FALSE, Colv = FALSE, density.info = "none", na.color="grey", dendrogram = "none", notecol='black')
dev.off()



plot_mat <- data.matrix(read.csv("dellen_heatmap_tab_raw.csv", row.names=1))
plot_mat_raw <- data.matrix(read.csv("dellen_heatmap_tab_raw.csv", row.names=1))
plot_mat_scaled <- t(apply(plot_mat_raw, 1, FUN=function(x) scale(x, center=FALSE)))

pdf(file = ("plots/heatmap_dellen_normed_nonc_8.pdf"), width=3, height=2, pointsize = 2)
heatmap.2(plot_mat_scaled, scale='none', trace = "none", labRow=FALSE, labCol=FALSE, col=hmcols8, Rowv = FALSE, Colv = FALSE, density.info = "none", na.color="grey", dendrogram = "none", notecol='black')
dev.off()







