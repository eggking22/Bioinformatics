# Homework 3

*致理-生21 雷丹*   

## 1.2 linux-Bash   


**课程作业**
```
参考和学习本章内容，写出一个 bash 脚本，可以使它自动读取一个文件夹（例如 bash_homework/）的内容，将该文件夹下文件的名字输出到 filenames.txt, 子文件夹的名字输出到 dirname.txt 。
```

bash脚本如下：
```bash
#!/bin/bash

cur_ls=`ls`

for var in $cur_ls
do
    if [ -f $var ];then
        echo "$var" >> /home/test/share/homework/linux/filename.txt
        else
        echo "$var" >> /home/test/share/homework/linux/dirname.txt
    fi

done

exit 0
```

执行结果如下：
```bash
test@leid_docker:~/share/bash_homework$ bash ../homework/linux/read.sh 
test@leid_docker:~/share/homework/linux$ ls
1.gtf  1.txt  dirname.txt  filename.txt  read.sh  run.sh
#此时dirname.txt和filename.txt已经生成
test@leid_docker:~/share/homework/linux$ head -n 5 dirname.txt 
a-docker
app
backup
bin
biosoft
#查看dirname.txt文件内容
test@leid_docker:~/share/homework/linux$ head -n 5 filename.txt 
a1.txt
a.txt
b1.txt
bam_wig.sh
b.filter_random.pl
#查看filename.txt文件内容
```


dirname.txt文件内容如下：
```
a-docker
app
backup
bin
biosoft
c1-RBPanno
datatable
db
download
e-annotation
exRNA
genome
git
highcharts
home
hub29
ibme
l-lwl
map2
mljs
module
mogproject
node_modules
perl5
postar2
postar_app
postar.docker
RBP_map
rout
script
script_backup
software
tcga
test
tmp
tmp_script
var
x-rbp
```


filename.txt文件内容如下：
```
a1.txt
a.txt
b1.txt
bam_wig.sh
b.filter_random.pl
c1.txt
chrom.size
c.txt
d1.txt
dir.txt
e1.txt
f1.txt
human_geneExp.txt
if.sh
image
insitiue.txt
mouse_geneExp.txt
name.txt
number.sh
out.bw
random.sh
read.sh
test3.sh
test4.sh
test.sh
test.txt
wigToBigWig
```