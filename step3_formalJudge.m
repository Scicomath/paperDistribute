% ��ȡ����
clear
load data.mat

% % ��ί����
% name = {'����','�����','������','��ѧΰ','����','�ָ���','������','�����',...
%     '��̫��','�½���','��С��','������','�����','��־��'};
% 
% % ��������
% judgeNum = length(name);
% % �Ծ�����
% paperNum = 90;

% ��ȡ����·�����ļ���
% % ��ȡ����Ŀ¼
% paperDir = uigetdir;
% % ��ȡ�����ļ���
% paperName = ls(strcat(paperDir,'\*.pdf'));
% if isempty(paperName)
%     warndlg('����: û����Ŀ¼�з��ַ���PDF�ļ�, ������ѡ��Ŀ¼!')
% end


%% ����ÿ���ľ���Ŀ
readPaperNum = paperNum * 3;
initNum = floor(readPaperNum / judgeNum);
left = readPaperNum - initNum * judgeNum;
judgePaperNum = ones(judgeNum,1).*initNum;
if left~=0
    judgePaperNum(1:left) = judgePaperNum(1:left) + 1;
end
disp('ÿ����ί�ľ����Ϊ:')
disp(judgePaperNum)
disp('�뽫�������ݸ��Ƶ�LINGO������JNUM������ֵ�����!')
disp('�ǵ��޸��ʼ������������ί��!')
fprintf('������Ϊ: %d ��ί��Ϊ: %d\n\n', paperNum, judgeNum);

%% �����Ծ�, ���������ֱ�
% LINGO�����Ծ�
X = textread('X.txt');
if length(X) ~= judgeNum * paperNum
    error('����: X���������뵱ǰ����ί��������������, ��ȷ������Ҫ���޸�LINGO���벢����.')
else
    X = reshape(X,judgeNum,paperNum);


    judgePaperVec = cell(1,judgeNum);
    for i = 1:judgeNum
        judgePaperVec{i} = find(X(i,:));
    end
    % ��������Ծ��Ƶ�ָ�����ļ���
    for i = 1:judgeNum
        mkdir(['��ʽ/',name{i},'��ʽ�ľ�'])
        temp = judgePaperVec{i};
        for j = 1:judgePaperNum(i)
            copyfile([paperDir,'/',int2str(temp(j)),'.pdf'],['��ʽ/',name{i},'��ʽ�ľ�','/'])
        end
    end

    % �������ֱ�
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

end

% ��������
save data.mat