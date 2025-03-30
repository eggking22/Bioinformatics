# homework4
## Part III. 1 Mapping 

```
（1）请阐述bowtie中利用了 BWT 的什么性质提高了运算速度？并通过哪些策略优化了对内存的需求？

（2）用bowtie将 THA2.fa mapping 到 BowtieIndex/YeastGenome 上，得到 THA2.sam，统计mapping到不同染色体上的reads数量(即统计每条染色体都map上了多少条reads)。

（3）查阅资料，回答以下问题:

（3.1）什么是sam/bam文件中的"CIGAR string"? 它包含了什么信息?

（3.2）"soft clip"的含义是什么，在CIGAR string中如何表示？

（3.3）什么是reads的mapping quality? 它反映了什么样的信息?

（3.4）仅根据sam/bam文件的信息，能否推断出read mapping到的区域对应的参考基因组序列? (提示:参考https://samtools.github.io/hts-specs/SAMtags.pdf中对于MD tag的介绍)

（4）软件安装和资源文件的下载也是生物信息学实践中的重要步骤。请自行安装教程中未涉及的bwa软件，从UCSC Genome Browser下载Yeast (S. cerevisiae, sacCer3)基因组序列。使用bwa对Yeast基因组sacCer3.fa建立索引，并利用bwa将THA2.fa，mapping到Yeast参考基因组上，并进一步转化输出得到THA2-bwa.sam文件。

```
### （1）请阐述bowtie中利用了 BWT 的什么性质提高了运算速度？并通过哪些策略优化了对内存的需求？

Bowtie中利用BWT的LF(last fist) Mapping 特性提高了运算速度。并通过BWT的数据压缩算法优化了对内存的需求。

### （2）用bowtie将 THA2.fa mapping 到 BowtieIndex/YeastGenome 上，得到 THA2.sam，统计mapping到不同染色体上的reads数量(即统计每条染色体都map上了多少条reads)。

脚本
```bash
#!/bin/bash

# Step 1: Run Bowtie to align THA2.fa to YeastGenome and output to THA2.sam
bowtie -v 2 -m 10 --best --strata /home/test/mapping/BowtieIndex/YeastGenome -f /home/test/mapping/THA2.fa -S /home/test/share/homework/NGS/THA2.sam

# Step 2: Use samtools to count reads mapped to each chromosome
samtools view THA2.sam | cut -f 3 | sort | uniq -c > /home/test/share/homework/NGS/THA2_reads.txt

exit 0
```

```txt
     92 *
     18 chrI
     51 chrII
     15 chrIII
    194 chrIV
     25 chrIX
     12 chrmt
     33 chrV
     17 chrVI
    125 chrVII
     68 chrVIII
     71 chrX
     56 chrXI
    169 chrXII
     67 chrXIII
     58 chrXIV
    101 chrXV
     78 chrXVI
```

### （3）查阅资料，回答以下问题:

（3.1）什么是sam/bam文件中的"CIGAR string"? 它包含了什么信息?

CIGAR（Compact Idiosyncratic Gapped Alignment Report）字符串是 SAM/BAM 文件中的一个字段，描述了 read 如何与参考基因组比对。它由 数字 + 字母 组成，每个部分表示 read 与参考基因组比对的具体方式。常见的符号包括 M（匹配）、I（插入）、D（缺失）、S（软剪切） 等。例如，10M1I5M2D20M 表示 read 的前 10 个碱基匹配，接着 1 个插入，接着 5 个匹配，2 个缺失，最后 20 个匹配。CIGAR 字符串帮助解析比对的结构，包括匹配、错配、缺失等信息。

（3.2）"soft clip"的含义是什么，在CIGAR string中如何表示？

Soft clip（软剪切）指的是 read 两端的一部分碱基未比对到参考基因组，但仍保留在 read 序列中。这通常发生在 reads 质量下降、比对错误或存在结构变异的情况下。在 CIGAR 字符串中，软剪切用 S 表示，前面的数字表示被剪切的碱基数。例如，CIGAR 5S95M 表示 read 的前 5 个碱基未比对（soft clipped），但后续 95 个碱基成功比对到了参考基因组。软剪切的碱基不会影响比对坐标。

（3.3）什么是reads的mapping quality? 它反映了什么样的信息?

Mapping Quality（MAPQ，比对质量）是一个整数值，用于衡量 read 在当前比对位置的置信度。它通常由比对工具计算，基于比对的唯一性和错误概率。例如，MAPQ 值高（如 60）通常表示 read 只有一个明确的比对位置，而 MAPQ 值低（如 0）表示 read 可能比对到多个位置，无法确定唯一比对位置。较高的 MAPQ 值通常表示比对可靠性较高，适用于后续变异分析等任务。

（3.4）仅根据sam/bam文件的信息，能否推断出read mapping到的区域对应的参考基因组序列? (提示:参考https://samtools.github.io/hts-specs/SAMtags.pdf中对于MD tag的介绍)

是的，可以通过 SAM/BAM 文件中的 MD 标签来推断读取比对到的参考基因组序列。MD 标签（MD:Z:）提供了比对过程中错配和缺失的信息，结合读取序列和 CIGAR 字符串，可以恢复参考基因组的序列。例如，MD:Z:10A5^C2 表示前 10 个碱基匹配，第 11 个碱基在参考基因组中是 A（但 read 可能不同），接下来 5 个碱基匹配，然后在参考基因组中有一个 C 被缺失（^C），最后 2 个碱基匹配。解析 MD 标签可以帮助研究比对错误、变异位点以及比对区域的准确性。

### （4）软件安装和资源文件的下载也是生物信息学实践中的重要步骤。请自行安装教程中未涉及的bwa软件，从UCSC Genome Browser下载Yeast (S. cerevisiae, sacCer3)基因组序列。使用bwa对Yeast基因组sacCer3.fa建立索引，并利用bwa将THA2.fa，mapping到Yeast参考基因组上，并进一步转化输出得到THA2-bwa.sam文件。
```bash
wget http://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/bigZips/sacCer3.fa.gz
gzip -d sacCer3.fa.gz# 解压得到sacCer3.fa
```

```bash
#以root进入容器
apt-get update && apt-get install -y bwa
bwa index sacCer3.fa  # 生成索引文件（如sacCer3.fa.bwt等）
```

对比脚本如下：
```bash
#!/bin/bash


bwa mem -M -c 10 \
    /home/test/data/sacCer3.fa \
    /home/test/mapping/THA2.fa \
    > /home/test/share/homework/NGS/THA2-bwa.sam


exit 0
```
THA2-bwa.sam文件内容截取如下：
```sam
@SQ	SN:chrI	LN:230218
@SQ	SN:chrII	LN:813184
@SQ	SN:chrIII	LN:316620
@SQ	SN:chrIV	LN:1531933
@SQ	SN:chrIX	LN:439888
@SQ	SN:chrV	LN:576874
@SQ	SN:chrVI	LN:270161
@SQ	SN:chrVII	LN:1090940
@SQ	SN:chrVIII	LN:562643
@SQ	SN:chrX	LN:745751
@SQ	SN:chrXI	LN:666816
@SQ	SN:chrXII	LN:1078177
@SQ	SN:chrXIII	LN:924431
@SQ	SN:chrXIV	LN:784333
@SQ	SN:chrXV	LN:1091291
@SQ	SN:chrXVI	LN:948066
@SQ	SN:chrM	LN:85779
@PG	ID:bwa	PN:bwa	VN:0.7.17-r1188	CL:bwa mem -M -c 10 /home/test/data/sacCer3.fa /home/test/mapping/THA2.fa
1251-506	4	*	0	0	*	*	0	0	TTACTATTCTATTATTATACTTTATTG	*	AS:i:0	XS:i:0
1252-505	4	*	0	0	*	*	0	0	TCACCACATAACTCTAAAATAAG	*	AS:i:0	XS:i:0
```