【功能描述】
遍历整个repo的所有工程，执行git status
 【路径】将脚本归档到gitrepo的根目录
【用法】 gitRepo_getStatus.sh
              或者gitRepo_getStatus.sh c
 【说明】
1.若不带参数c，若repolist.txt不存在，则自动执行repo list自动生成repolist.txt，并据此生成git status
                      若repolist.txt存在，则会依据已存在的repolist.txt，生成git status
2.若带参数c，则会自动执行repo list自动生成repolist.txt，并据此生成git status
【技巧】
1.gitRepo_getStatus.sh c生成整个repo的工程目录的列表到repolist.txt
2.若只想执行某些project(目录）下的git status，则通过定制repolist.txt（删改步骤1的文件内容，仅保留想要的project）并执行gitRepo_getStatus.sh实现。

【输出】
repolist.txt （首次执行，或带参数c）
gitstatus.txt

【约束】
对于没有加入到project的新增目录，不会遍历到。需要人工额外处理

【免责申明】水平有限，或有缺陷，仅供参考
   AndySun 2023-11-27