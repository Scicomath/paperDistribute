%% ��ȡ�����ļ���
% ��ȡ����Ŀ¼
paperDir = uigetdir;
% ��ȡ�����ļ���
paperName = ls(strcat(paperDir,'\*.pdf'));
if isempty(paperName)
    warndlg('����: û����Ŀ¼�з��ַ���PDF�ļ�, ������ѡ��Ŀ¼!')
end

%% ���ı��
[N, M] = size(paperName);
% ������������
paperName = paperName(randperm(N),:);
% �����ı��д��Excel
id = num2cell((1:N)');
nameCell = mat2cell(paperName, ones(1,N), M);
title = {'ID', 'filename'};
paperID = cell2table([id, nameCell], 'VariableNames',title);
writetable(paperID, '���ı��.csv');

%% �����ļ�������
% ����ԭʼ�ļ�
copyfile(paperDir, 'ԭʼ���ı���');
for i = 1:N
    movefile(strcat(paperDir,'\',strtrim(paperName(i,:))), ...
        strcat(paperDir,'\',num2str(i),'.pdf'));
end