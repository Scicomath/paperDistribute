clear
load data.mat
% 设置评委
% % 评委姓名
% name = {'艾鑫','李金武','宁丹麦','李学伟','王震','贾高萌','曾祥云','朱翠艳',...
%     '覃太贵','陈江宏','张小华','王卫华','马德宜','杨志巧'};
% % 试评人数
% judgeNum = length(name);

%% 读取评分
judgeScore = cell(1,judgeNum);
for i = 1:judgeNum
    judgeScore{i} = xlsread(['评分表/',name{i},'评分表.xls'],['B2:B',int2str(judgePaperNum(i)+1)]);
end

%% 计算标准分
stdJudgeScore = cell(1,judgeNum);
for i = 1:judgeNum
    stdJudgeScore{i} = stdScoreFun(judgeScore{i});
end

scoreMat = zeros(size(X));
stdScoreMat = zeros(size(X));
for i = 1:judgeNum
    for j = 1:judgePaperNum(i)
        scoreMat(i,judgePaperVec{i}(j)) = judgeScore{i}(j);
        stdScoreMat(i,judgePaperVec{i}(j)) = stdJudgeScore{i}(j);
    end
end
scoreMat = scoreMat';
stdScoreMat = stdScoreMat';
meanScore = sum(scoreMat,2)./3;
meanStdScore = sum(stdScoreMat,2)./3;


[~,paperName] = xlsread('论文编号.xls');
result(:,1) = paperName(2:end,2);
result(:,2) = num2cell(meanStdScore);

xlswrite('最终结果.xls',result)