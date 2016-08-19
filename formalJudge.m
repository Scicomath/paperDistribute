% ��ί����
name = {'����','�����','������','��ѧΰ','����','�ָ���','������','�����',...
    '��̫��','�½���','��С��','������','�����','��־��'};

% ��������
judgeNum = length(name);
% �Ծ�����
paperNum = 90;

%% ��ȡ����·�����ļ���
% ��ȡ����Ŀ¼
paperDir = uigetdir;
% ��ȡ�����ļ���
paperName = ls(strcat(paperDir,'\*.pdf'));
if isempty(paperName)
    warndlg('����: û����Ŀ¼�з��ַ���PDF�ļ�, ������ѡ��Ŀ¼!')
end


%% ������ʽ����
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
%% �����Ծ�
for i = 1:judgeNum
    mkdir(['��ʽ/',name{i},'��ʽ�ľ�'])
    temp = judgePaperVec{i};
    for j = 1:judgePaperNum(i)
        copyfile([paperDir,'/',int2str(temp(j)),'.pdf'],['��ʽ/',name{i},'��ʽ�ľ�','/'])
    end
end

%% �������ֱ�
form = cell(1,judgeNum);
mkdir('���ֱ�')
for i = 1:judgeNum
    tempjudgePaperNum = judgePaperNum(i);
    form{i} = cell(tempjudgePaperNum+1,2);
    form{i}{1,1} = '���ı��';
    form{i}{1,2} = '���';
    form{i}(2:end,1) = num2cell(judgePaperVec{i}(:));
    xlswrite(['���ֱ�/',name{i},'���ֱ�.xls'],form{i})
end

