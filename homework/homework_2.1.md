
# Homework 2.1
1. 统计文件的行数以及字符数
```bash
test@leid_docker:~/share$ wc -l test_command.gtf
8 test_command.gtf
test@leid_docker:~/share$ wc -c test_command.gtf
636 test_command.gtf
```

2. 筛选并输出示例文件中以 chr_ 起始，并且基因id为 YDL248W 的行
```bash
test@leid_docker:~/share$ grep '^chr_' test_command.gtf | grep 'YDL248W' test_command.gtf
chr_IV  ensembl gene    1802    2953    .       +       .       gene_id "YDL248W"; gene_version "1";
chr_IV  ensembl transcript      802     2953    .       +       .       gene_id "YDL248W"; gene_version "1";
chromosome_IV   ensembl exon    1802    2953    .       +       .       gene_id "YDL248W"; gene_version "1";
chromosome_IV   ensembl CDS     1802    950     .       +       0       gene_id "YDL248W"; gene_version "1";
chr_IV  ensembl start_codon     1802    1804    .       +       0       gene_id "YDL248W"; gene_version "1";
```

3. 将示例文件中的 chr_ 替换为 chromosome_ 并输出每行的第1，3，4，5列
```bash
test@leid_docker:~/share$ sed 's/chr_/chromosome/g' test_command.gtf | cut -f 1,3,4,5
chromosomeIV    gene    1802    2953
chromosomeIV    transcript      802     2953
chromosome_IV   exon    1802    2953
chromosome_IV   CDS     1802    950
chromosomeIV    start_codon     1802    1804
chromosome_IV   stop_codon      2951    2953
chromosome_IV   gene    762     3836
chromosomeIV    transcript      3762    836
```

4. 互换示例文件的第2列和第3列，并且对输出结果利用 sort 命令依照第4和第5列数字大小排序，将最终结果输出到result.gtf文件中。

* awk命令：  
```bash
# 打印整行内容
awk '{print $0}' data.txt
# 打印第一列 (姓名)
awk '{print $1}' data.txt
# 过滤年龄大于25的行
awk '$2 > 25' data.txt
# 处理 CSV 文件
awk -F ',' '{print $1 " 的年龄是 " $2}' data.csv
# 重新格式化输出
awk '{printf "姓名: %s, 年龄: %d, 分数: %d\n", $1, $2, $3}' data.txt
```
* 代码实现：
```bash
test@leid_docker:~/share$ awk '{print $1, $3, $2, $4, $5, $6, $7, $8, $9, $10, $11, $12}' test_command.gtf | sort -k4,4n -k5,5n > result.gtf
test@leid_docker:~/share$ cat result.gtf
chromosome_IV gene ensembl 762 3836 . + . gene_id "YDL247W-A"; gene_version "1";
chr_IV transcript ensembl 802 2953 . + . gene_id "YDL248W"; gene_version "1";
chromosome_IV CDS ensembl 1802 950 . + 0 gene_id "YDL248W"; gene_version "1";
chr_IV start_codon ensembl 1802 1804 . + 0 gene_id "YDL248W"; gene_version "1";
chr_IV gene ensembl 1802 2953 . + . gene_id "YDL248W"; gene_version "1";
chromosome_IV exon ensembl 1802 2953 . + . gene_id "YDL248W"; gene_version "1";
chromosome_IV stop_codon ensembl 2951 2953 . + 0 gene_id "YDL248W"; gene_version "1";
chr_IV transcript ensembl 3762 836 . + . gene_id "YDL247W-A"; gene_version "1";
```

5. 更改示例文件的权限，使得文件所有者及所在用户组用户可读、写、执行而其他用户只可读
```bash
root@leid_docker:/home/test/share# ls -l test_command.gtf
-rwxrwxrwx 1 root root 636 Mar  3 07:10 test_command.gtf
root@leid_docker:/home/test/share# chmod 774 test_command.gtf
root@leid_docker:/home/test/share# ls -l test_command.gtf
-rwxrwxr-- 1 root root 636 Mar  3 07:10 test_command.gtf
```