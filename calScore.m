%% ������ί
% ��ί����
name = {'����','�����','������','��ѧΰ','����','�ָ���','������','�����',...
    '��̫��','�½���','��С��','������','�����','��־��'};
% ��������
judgeNum = length(name);

%% ��ȡ����
judgeScore = cell(1,judgeNum);
for i = 1:judgeNum
    judgeScore{i} = xlsread(['���ֱ�/',name{i},'���ֱ�.xls'],['B2:B',int2str(judgePaperNum(i)+1)]);
end

%% �����׼��
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


%result(:,1) = {k.name}';
[~,paperName] = xlsread('�ڰ��ֱ��.xls');
result(:,1) = paperName;
result(:,2) = num2cell(meanStdScore);

xlswrite('���ս��.xls',result)