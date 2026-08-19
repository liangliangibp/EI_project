#!/usr/bin/perl
use strict;
use warnings;

die "使用方法：perl $0 enhancer_promoter_interaction.pair sonehs_to_stitched.list\n" if(@ARGV != 2);

my $enhancer_to_split_promoter_network = shift;      # 第一个文件：互作网络
my $sonEhs_to_stitched_enhancer = shift;             # 第二个文件：增强子映射关系

# 1. 读取增强子映射关系（sonEhs -> stitched enhancer）
my %sonEhs_father;
open(SSE, $sonEhs_to_stitched_enhancer) || die "无法打开文件: $sonEhs_to_stitched_enhancer\n";
while(my $line = <SSE>) {
    chomp $line;
    my @sub = split/\s+/, $line;
    # 确保每行至少有8列
    if (@sub >= 8) {
        my $son = join "\t", @sub[0..3];    # 前4列为子元素
        my $father = join "\t", @sub[4..7]; # 后4列为父元素
        $sonEhs_father{$son} = $father;
    }
}
close SSE;

# 2. 读取互作网络并处理
my %network;
open(ESPN, $enhancer_to_split_promoter_network) || die "无法打开文件: $enhancer_to_split_promoter_network\n";
while(my $line = <ESPN>) {
    chomp $line;
    my @sub = split/\s+/, $line;
    # 确保至少有9列（两个元素各4列，加上1列权重）
    next if @sub < 9;
    
    my $left_ele = join "\t", @sub[0..3];
    my $right_ele = join "\t", @sub[4..7];
    my $weight = $sub[8];
    
    # 获取元素（仅增强子需要替换）
    my $real_left_ele = get_father($left_ele);
    my $real_right_ele = get_father($right_ele);
    
    # 排序确保一致的键
    my @pair = sort ($real_left_ele, $real_right_ele);
    my $key = $pair[0] . "\t" . $pair[1];
    $network{$key} += $weight;
}
close ESPN;

# 3. 按权重降序输出结果
foreach my $key (sort {$network{$b} <=> $network{$a}} keys %network) {
    print $key, "\t", $network{$key}, "\n";
}

# 获取元素（仅增强子需要替换，启动子保持不变）
sub get_father {
    my $in_ele = shift;
    my @arr_ele = split/\s+/, $in_ele;
    
    # 检查是否为sonEhs类型（增强子）
    if($arr_ele[3] =~ /sonEhs/) {
        return $sonEhs_father{$in_ele} || $in_ele;  # 如果有映射则返回父元素，否则保持原样
    }
    # 如果是PT类型（启动子），保持不变
    else {
        return $in_ele;
    }
}
