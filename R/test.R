# 创建一个简单的数据集
x <- 1:10
y <- x^2

# 绘制基础散点图
plot(x, y, 
     main = "我的第一个R图形",  # 标题
     xlab = "X轴标签",         # X轴标签
     ylab = "Y轴标签",         # Y轴标签
     col = "blue",             # 点的颜色
     pch = 19,                 # 点形状（19=实心圆）
     cex = 1.5)                # 点大小

# 添加一条红色趋势线
lines(x, y, col = "red", lwd = 2)

# 添加图例
legend("topleft", 
       legend = c("数据点", "趋势线"), 
       col = c("blue", "red"), 
       pch = c(19, NA), 
       lty = c(NA, 1))

z = 10
z
