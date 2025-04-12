# 第六次作业
## Part III. 1.2 bedtools/samtools

作业要求：
```
（1）我们提供的bam文件COAD.ACTB.bam是单端测序分析的结果还是双端测序分析的结果？为什么？(提示：可以使用samtools flagstat）

（2）查阅资料回答什么叫做"secondary alignment"？并统计提供的bam文件中，有多少条记录属于"secondary alignment?" （提示：可以使用samtools view -f 获得对应secondary alignment的records进行统计）

（3）请根据hg38.ACTB.gff计算出在ACTB基因的每一条转录本中都被注释成intron的区域，以bed格式输出。并提取COAD.ACTB.bam中比对到ACTB基因intron区域的bam信息，后将bam转换为fastq文件。

提示：

写脚本把ACTB在gff中第三列为"gene"的interval放在一个bed文件中，第三列为"exon"的intervals放在另外一个bed文件中，再使用bedtools subtract。

请注意bed文件使用的是0-based coordinate，gff文件使用的是1-based coordinate。

鼓励其他实现方法，描述清楚过程即可

(4) 利用COAD.ACTB.bam计算出reads在ACTB基因对应的genomic interval上的coverage，以bedgraph格式输出。 （提示：对于真核生物转录组测序向基因组mapping得到的bam文件，bedtools genomecov有必要加-split参数。）
```

### （1）我们提供的bam文件COAD.ACTB.bam是单端测序分析的结果还是双端测序分析的结果？为什么？

```bash
test@bioinfo_docker:~/share/homework/NGS/samtool_file/homework$ samtools flagstat COAD.ACTB.bam
185650 + 0 in total (QC-passed reads + QC-failed reads)
4923 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
185650 + 0 mapped (100.00% : N/A)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (N/A : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (N/A : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```
"paired in sequencing" 为 0，说明是单端测序。

### （2）查阅资料回答什么叫做"secondary alignment"？并统计提供的bam文件中，有多少条记录属于"secondary alignment?"
**定义 "secondary alignment"：**
在 BAM 文件中，当一条 read 可以比对到基因组的多个位置时，映射工具会选择一个最佳位置作为 "primary alignment"，其他次优比对位置被标记为 "secondary alignment"。

由于（1）中的代码“4923 + 0 secondary“，说明有4923条记录属于"secondary alignment"。

### （3）请根据hg38.ACTB.gff计算出在ACTB基因的每一条转录本中都被注释成intron的区域，以bed格式输出。并提取COAD.ACTB.bam中比对到ACTB基因intron区域的bam信息，后将bam转换为fastq文件。

提取intron：
```bash
awk '$3=="gene" && $9~/ACTB/{print $1"\t"$4-1"\t"$5}' hg38.ACTB.gff > ACTB_gene.bed
awk '$3=="exon"{print $1"\t"$4-1"\t"$5}' hg38.ACTB.gff > ACTB_exon.bed
bedtools subtract -a ACTB_gene.bed -b ACTB_exon.bed > ACTB_intron.bed
```
ACTB_intron.bed内容：
```bed
chr7	5528185	5528280
chr7	5529982	5530523
chr7	5530627	5540675
chr7	5540771	5561851
chr7	5561949	5562389
chr7	5562828	5563713
```
COAD.ACTB.bam中比对到ACTB基因intron区域的bam信息，后将bam转换为fastq文件：
```bash
samtools view -b -L ACTB_intron.bed COAD.ACTB.bam > COAD_ACTB_intron.bam
samtools fastq COAD_ACTB_intron.bam > COAD_ACTB_intron.fastq
```

### （4）利用COAD.ACTB.bam计算出reads在ACTB基因对应的genomic interval上的coverage，以bedgraph格式输出。

代码：
```bash
samtools sort COAD.ACTB.bam -o COAD_ACTB.sorted.bam
samtools index COAD_ACTB.sorted.bam
samtools view -b -L ACTB_gene.bed COAD_ACTB.sorted.bam > COAD_ACTB_region.bam
bedtools genomecov -ibam COAD_ACTB_region.bam -bga -split > ACTB_coverage.bedgraph
```
ACTB_coverage.bedgraph内容：
```bed
test@bioinfo_docker:~/share/homework/NGS/samtool_file/homework$ head -5 ACTB_coverage.bedgraph 
chr7    0       5045717 0
chr7    5045717 5045731 1
chr7    5045731 5058689 0
chr7    5058689 5058695 1
chr7    5058695 5072542 0
```
## 附加Homework：人类基因组与非编码RNA研究

![alt text](image-7.png)

### 一、人类基因组的大小及基本组成

- 人类基因组大小约为 **3.2 Gb（32亿个碱基对）**。
- 组成结构如下（以GRCh38版本为例）：

| 区域         | 比例     | 功能说明                             |
|--------------|----------|--------------------------------------|
| 编码区       | 约1.5%   | 编码蛋白质的外显子区域               |
| 非编码区     | 超过98%  | 包含调控序列、非编码RNA、重复序列等 |
| 重复序列     | 约50%    | 如LINEs、SINEs、LTR等重复元素        |
| 线粒体DNA    | 约16,569 bp | 编码13种蛋白和多个tRNA/rRNA        |

数据来源：[NCBI Genome Data Viewer](https://www.ncbi.nlm.nih.gov/genome/gdv/)（GRCh38.p14，更新时间：2023年12月）

### 二、基因中非编码RNA的最新注释与功能分类

#### 非编码RNA的分类及数量（参考GENCODE v44，更新日期：2024年3月）

| RNA类型   | 基因/转录本数量 | 功能简述                           |
|-----------|------------------|------------------------------------|
| lncRNA    | 18,380 转录本     | 调控基因表达、染色质结构、转录后加工等 |
| miRNA     | 1,917 个         | 靶向mRNA，调控翻译或诱导降解         |
| snoRNA    | 2,186 个         | 参与rRNA的修饰和加工                 |
| snRNA     | 1,357 个         | 在mRNA剪接中起关键作用               |
| rRNA      | 616 个           | 构成核糖体，参与蛋白质合成            |
| tRNA      | 624 个           | 运送氨基酸至核糖体                   |
| miscRNA   | 若干             | 其他具有特殊功能的非编码RNA类型       |

数据来源：[GENCODE v44](https://www.gencodegenes.org/human/stats.html)
