% 读取数据
clear
load data.mat

% % 评委姓名
% name = {'艾鑫','李金武','宁丹麦','李学伟','王震','贾高萌','曾祥云','朱翠艳',...
%     '覃太贵','陈江宏','张小华','王卫华','马德宜','杨志巧'};
% 
% % 试评人数
% judgeNum = length(name);
% % 试卷总数
% paperNum = 90;

% 获取论文路径与文件名
% % 获取论文目录
% paperDir = uigetdir;
% % 获取论文文件名
% paperName = ls(strcat(paperDir,'\*.pdf'));
% if isempty(paperName)
%     warndlg('错误: 没有在目录中发现发现PDF文件, 请重新选择目录!')
% end


%% 分配每人阅卷数目
readPaperNum = paperNum * 3;
initNum = floor(readPaperNum / judgeNum);
left = readPaperNum - initNum * judgeNum;
judgePaperNum = ones(judgeNum,1).*initNum;
if left~=0
    judgePaperNum(1:left) = judgePaperNum(1:left) + 1;
end
disp('每个评委阅卷份数为:')
disp(judgePaperNum)
disp('请将上述数据复制到LINGO代码中JNUM变量赋值语句中!')
disp('记得修改最开始的论文数和评委数!')
fprintf('论文数为: %d 评委数为: %d\n\n', paperNum, judgeNum);

%% 分配试卷, 并生成评分表
% LINGO分配试卷
X = textread('X.txt');
if length(X) ~= judgeNum * paperNum
    error('错误: X矩阵数据与当前的评委数和论文数不符, 请确保按照要求修改LINGO代码并运行.')
else
    X = reshape(X,judgeNum,paperNum);


    judgePaperVec = cell(1,judgeNum);
    for i = 1:judgeNum
        judgePaperVec{i} = find(X(i,:));
    end
    % 将分配的试卷复制到指定的文件夹
    for i = 1:judgeNum
        mkdir(['正式/',name{i},'正式阅卷'])
        temp = judgePaperVec{i};
        for j = 1:judgePaperNum(i)
            copyfile([paperDir,'/',int2str(temp(j)),'.pdf'],['正式/',name{i},'正式阅卷','/'])
        end
    end

    % 生成评分表
    form = cell(1,judgeNum);
    mkdir('评分表')
    for i = 1:judgeNum
        tempjudgePaperNum = judgePaperNum(i);
        form{i} = cell(tempjudgePaperNum+1,2);
        form{i}{1,1} = '论文编号';
        form{i}{1,2} = '打分';
        form{i}(2:end,1) = num2cell(judgePaperVec{i}(:));
        xlswrite(['评分表/',name{i},'评分表.xls'],form{i})
    end

end

% 保存数据
save data.mat