% ���������ű�
%% ������ί��ÿ����������
% ��ί����
name = {'����','�����','������','��ѧΰ','����','�ָ���','������','�����',...
    '��̫��','�½���','��С��','������','�����','��־��'};
% ��������
judgeNum = length(name);
% ÿ����������
m = 5;
%% ��ȡ����·�����ļ���
% ��ȡ����Ŀ¼
paperDir = uigetdir;
% ��ȡ�����ļ���
paperName = ls(strcat(paperDir,'\*.pdf'));
if isempty(paperName)
    warndlg('����: û����Ŀ¼�з��ַ���PDF�ļ�, ������ѡ��Ŀ¼!')
end

% �Ծ�����
paperNum = size(paperName,1);

count = 0;
temp = randperm(paperNum);
for i = 1:judgeNum
    mkdir(['����/',name{i}])
    for j = 1:m
        count = count + 1;
        if count <= paperNum % ȷ��������������������
            index = temp(count);
            fileName = strtrim(paperName(index,:));
            fileDir = [paperDir,'\',fileName];
            copyfile(fileDir, ['����/',name{i},'/'])
        end
    end
end

