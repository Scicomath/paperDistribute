# 数学建模论文阅卷系统

使用方法:
- 首先将所有的论文(PDF格式)放到某个文件夹(比如: 论文)中.
- 运行`step1_renamePaper.m`脚本, 选择论文所在的文件夹. 
  此脚本会将论文随机编号, 将编号结果保存到"论文编号.xls"中, 并将原论文备份到"原始论文备份"文件夹中.
- 运行`step2_trialJudge.m`脚本, 进行试评分卷. 脚本会建立一个"试评"文件夹, 并将所有评委的试评论文放到各自的子文件夹中. 将各个评委的试评文件夹打包发给评委即可.
- 运行`step3_formalJudge.m`脚本, 进行正式评卷分卷. 第一次运行可能会报错, 提示"X矩阵数据与...不符", 不用管它. 应为还要用LINGO生成相应的论文分配矩阵. 注意, 此脚本会在命令窗口输出每个评委评阅论文数, 论文总数, 评委数, 这些数据将在下一步用到.
- 打开LINGO软件, 选择"文件"->"打开", 选中LINGO文件"LINGO1.lg4", 然后按照之前脚本输出的数据, 对代码进行修改(具体修改方法见代码注释), 修改好后运行. 注意, 不能直接将LINGO文件拖入LINGO程序, 这样虽然可以运行, 但是不会将MATLAB所需X变量的结果保存到当前目录. 
- 再次运行`step3_formalJudge.m`脚本, 这次应该能够正常运行. 如果仍然报错"X矩阵数据与...不符", 则表明LINGO没有生成对应的"X.txt"文件, 请检查上一步. 如果运行没有问题, 脚本会生成"正式"文件夹和"评分表"文件夹, 各评委的评阅论文都放在"正式"文件夹下对应的子文件夹下. "评分表"文件夹则包含了各评委的评分表. 将各评委的论文文件夹打包, 将打包后的论文和评分表发给评委即可.
- 评委打分, 打分完后, 将所有的打分表收集起来, 放入"评分表"文件夹中, 覆盖原文件, 注意文件名必须跟原来一模一样.
- 运行`step4_calScore`脚本, 此脚本将读取"评分表"中的评分, 并计算每个评委的标准分, 将每个论文的标准分取平均后保存到"最终结果.xls"中.
