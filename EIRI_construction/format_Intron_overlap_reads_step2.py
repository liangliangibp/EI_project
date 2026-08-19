#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pandas as pd
import sys
import numpy as np

def process_file_pandas(input_file, output_file):
    # 读取文件
    df = pd.read_csv(input_file, sep='\t', header=None)
    
    print(f"原始数据形状: {df.shape}")
    print("\n原始数据前5行:")
    print(df.head(5))
    
    # 按第4列（索引3）分组
    # 对于每组，计算所有第2列（索引1）和第3列（索引2）值的最小值和最大值
    def get_group_range(group):
        # 收集该组所有的第2列和第3列的值
        all_values = pd.concat([group[1], group[2]])
        return pd.Series({
            'min_val': all_values.min(),
            'max_val': all_values.max()
        })
    
    # 计算每组的统计值
    group_stats = df.groupby(3).apply(get_group_range).reset_index()
    group_stats.columns = ['gene_name', 'min_val', 'max_val']
    
    print("\n各组统计信息:")
    for _, row in group_stats.iterrows():
        print(f"基因 {row['gene_name']}: 最小值={row['min_val']}, 最大值={row['max_val']}")
    
    # 创建映射字典
    min_map = dict(zip(group_stats['gene_name'], group_stats['min_val']))
    max_map = dict(zip(group_stats['gene_name'], group_stats['max_val']))
    
    # 替换第2列和第3列
    df[1] = df[3].map(min_map)  # 第2列替换为最小值
    df[2] = df[3].map(max_map)  # 第3列替换为最大值
    
    # 保存结果
    df.to_csv(output_file, sep='\t', header=False, index=False)
    
    print(f"\n处理完成！结果已保存到: {output_file}")
    print("\n处理后数据前5行:")
    print(df.head(5))

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("使用方法: python script.py <输入文件> <输出文件>")
        sys.exit(1)
    
    process_file_pandas(sys.argv[1], sys.argv[2])
