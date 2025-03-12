# Week 3
| 权限  | 作用       | 文件示例 (-rwx------) | 目录示例 (drwx------) |
|------|----------|----------------|----------------|
| `r` (read)  | 读取权限  | 文件内容可读 | 可列出目录内容 (`ls`) |
| `w` (write) | 写入权限  | 可修改文件内容 | 可创建/删除文件 |
| `x` (execute) | 执行权限  | 可执行文件 | 可进入目录 (`cd`) |

### 权限分为三类：
- **`u`（user）** - 文件所有者  
- **`g`（group）** - 文件所属组  
- **`o`（others）** - 其他用户  
- **`a`（all）** - `u`、`g` 和 `o` 的总称  

```bash
if [ ]
then
#elif
#elso
fi
```
```bash
for i in `seq $si $ei | shuf `
do
  shuffled=$shuffled${s:$i:1}
done
#在 Bash 脚本中，{}（花括号）用于增强变量引用的清晰度，避免歧义。虽然在很多情况下 "$variable" 和 "${variable}" 作用相同，但加上 {} 可以让变量边界更加清晰
#在 Bash 字符串拼接是直接相连的，不像 Python 或 Java 需要 + 号。例如：
```

```bash
${s:$i:1} # 获取字符串 s 从位置 i 开始的 1 个字符
$(()) # 用于整数运算
```
```bash
while true
do
if
then
break;
fi
done
```