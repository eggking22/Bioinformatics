setwd("D:/桌面/大三下/生物信息学/Bioinformatics/R")
str(iris)

# 加载必要的库（实际上iris是内置数据集，无需加载）
# 按Species分组计算均值和标准差
result <- aggregate(Sepal.Length ~ Species, data = iris, 
                    FUN = function(x) c(mean = mean(x), sd = sd(x)))

# 将结果转换为数据框
result_df <- data.frame(
  Species = result$Species,
  Mean_Sepal_Length = result$Sepal.Length[,1],
  SD_Sepal_Length = result$Sepal.Length[,2]
)

# 保存为CSV文件
write.csv(result_df, "sepal_length_stats.csv", row.names = FALSE)

# 显示结果
print(result_df)
# 执行One-way ANOVA
anova_result <- aov(Sepal.Width ~ Species, data = iris)

# 输出结果
summary(anova_result)
