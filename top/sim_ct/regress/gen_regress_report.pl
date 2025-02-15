#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

# 打开或创建 regress_report 文件
open my $report_fh, '>', 'regress_report' or die "无法创建 regress_report 文件: $!";

# 写入标题行
print $report_fh sprintf("%-20s%-35s%-15s\n", 'No', 'Case name', 'State');

# 查找 regress_result 目录下的所有文件
my $dir = 'regress_result';
opendir my $dh, $dir or die "无法打开目录 $dir: $!";
my @files = grep { -f "$dir/$_" } readdir($dh);
closedir $dh;

# 用于记录文件名和测试结果
my %results;

# 用于统计 "TEST PASS", "TEST FAIL" 和 "TEST NA" 的数量
my %result_count = ('TEST PASS' => 0, 'TEST FAIL' => 0, 'TEST NA' => 0);

# 遍历每个文件
foreach my $file (@files) {
    my $file_path = "$dir/$file";

    # 使用File::Basename模块获取纯文件名
    my $pure_filename = fileparse($file, qr/\.[^.]*/);

    # 打开文件
    open my $file_fh, '<', $file_path or die "无法打开文件 $file_path: $!";

    # 读取文件内容
    my $content = do { local $/; <$file_fh> };

    # 关闭文件
    close $file_fh;

    # 检查文件内容并记录结果
    if ($content =~ /TEST PASS/) {
        $results{$pure_filename} = 'TEST PASS';
        $result_count{'TEST PASS'}++;
    } elsif ($content =~ /TEST FAIL/) {
        $results{$pure_filename} = 'TEST FAIL';
        $result_count{'TEST FAIL'}++;
    } elsif ($content =~ /TEST NA/) {
        $results{$pure_filename} = 'TEST NA';
        $result_count{'TEST NA'}++;
    }
}

# 在 regress_report 文件中写入文件名、测试结果和序号
my $line_number = 1;
foreach my $file (keys %results) {
    printf $report_fh "%-11s%-44s%-10s\n", $line_number, $file, $results{$file};
    $line_number++;
}

# 在 regress_report 文件中写入 "TEST PASS", "TEST FAIL" 和 "TEST NA" 的数量统计
print $report_fh "\n";
printf $report_fh "%-20s%-10s\n", 'TEST PASS  数量:', $result_count{'TEST PASS'};
printf $report_fh "%-20s%-10s\n", 'TEST FAIL  数量:', $result_count{'TEST FAIL'};
printf $report_fh "%-20s%-10s\n", 'TEST NA    数量:', $result_count{'TEST NA'};
printf $report_fh "%-20s%-10s\n", 'TEST Total 数量:', $result_count{'TEST PASS'}+$result_count{'TEST FAIL'}+$result_count{'TEST NA'};

# 关闭文件句柄
close $report_fh;

print "Case 执行完成。\n";

