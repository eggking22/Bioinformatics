# Day 2

## introduction of linux

### linux 构成

### linux环境配置

### linux基本命令

man ls   
ls --help   
ls -la # 查看文件详细信息  
cd  
pwd # 查看当前路径  
mkdir testdir   
cp   #复制文件
mv testfile testdir# 移动文件    
rm 删除命令
cat testfile # 查看文件内容
wc / head / tail # 查看文件信息  
chomd # 修改文件权限

查看文件：   
cat / head / wc

**important**   
*文件处理中比较重要的操作*   
cut sed grep unic sort   
## **不同命令的区别**

| **命令**  | **主要用途** | **适用场景** | **常用选项** | **示例** |
|-----------|------------|-------------|-------------|--------|
| `cut`  | 按列或字符提取文本 | 处理结构化数据（如 CSV、日志） | `-f`（按列）<br>`-d`（指定分隔符）<br>`-c`（按字符提取） | `cut -d',' -f2 file.txt`（提取 CSV 第二列） |
| `sed`  | 查找、替换、删除、修改文本 | 文本编辑、大规模替换 | `s///`（替换）<br>`d`（删除匹配行）<br>`-i`（修改文件） | `sed 's/old/new/g' file.txt`（替换 `old` 为 `new`） |
| `grep` | 搜索匹配的行 | 查找日志、筛选文本 | `-i`（忽略大小写）<br>`-v`（反向匹配）<br>`-n`（显示行号） | `grep "error" log.txt`（查找 `error`） |
| `uniq` | 去重 | 处理重复数据 | `-c`（统计次数）<br>`-d`（仅显示重复行）<br>`-u`（仅显示唯一行） | `uniq -c file.txt`（统计重复行） |
| `sort` | 排序 | 排序文本、数值 | `-n`（按数值排序）<br>`-r`（倒序）<br>`-u`（去重） | `sort -n data.txt`（按数值排序） |

---




#sed 适用于一般文本，cut 适用于结构化数据

cut--按列提取    
cut -d ";" -f 2 file.txt   
#以 ; 作为字段的分隔符，从 file_name 文件中提取第 2 列的数据。  
#cut 只能提取列

**sed--编辑，打印**   
sed 's/a/A/g' file_name     
#文本编辑，将文件中所有的 a 替换为 A   

sed -n '3,6 p' file_name    #打印第3到6行  
sed '2 q' file_name         #打印前2行
#sed 可以提取行

grep--搜索   
grep 'CDS' file_name       #显示匹配上 'CDS' 的所有行   
grep -v 'CDS' file_name    #显示没有匹配上'CDS'的所有行

sort 排序  
sort -k 4 file_name           # 按照第 4 列排序  




**管道**  


## bioinformatics-part2   
HMM-transformer 

生物信息---自然语言
text is a projecion of the world  

### 一维
HMM  intron exon