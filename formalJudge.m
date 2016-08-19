% 评委姓名
name = {'艾鑫','李金武','宁丹麦','李学伟','王震','贾高萌','曾祥云','朱翠艳',...
    '覃太贵','陈江宏','张小华','王卫华','马德宜','杨志巧'};

% 试评人数
judgeNum = length(name);
% 试卷总数
paperNum = 90;

%% 获取论文路径与文件名
% 获取论文目录
paperDir = uigetdir;
% 获取论文文件名
paperName = ls(strcat(paperDir,'\*.pdf'));
if isempty(paperName)
    warndlg('错误: 没有在目录中发现发现PDF文件, 请重新选择目录!')
end


%% 下午正式评卷
readPaperNum = paperNum * 3;
initNum = floor(readPaperNum / judgeNum);
left = readPaperNum - initNum * judgeNum;
judgePaperNum = ones(judgeNum,1).*initNum;
if left~=0
%     temp = randperm(judgeNum);
%     judgePaperNum(temp(1:left)) = initNum + 1;
    judgePaperNum(1:left) = judgePaperNum(1:left) + 1;
end

X = textread('X.txt');
X = reshape(X,judgeNum,paperNum);


judgePaperVec = cell(1,judgeNum);
for i = 1:judgeNum
    judgePaperVec{i} = find(X(i,:));
end
%% 分配试卷
for i = 1:judgeNum
    mkdir(['正式/',name{i},'正式阅卷'])
    temp = judgePaperVec{i};
    for j = 1:judgePaperNum(i)
        copyfile([paperDir,'/',int2str(temp(j)),'.pdf'],['正式/',name{i},'正式阅卷','/'])
    end
end

%% 生成评分表
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

