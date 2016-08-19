%% 读取论文文件名
% 获取论文目录
paperDir = uigetdir;
% 获取论文文件名
paperName = ls(strcat(paperDir,'\*.pdf'));
if isempty(paperName)
    warndlg('错误: 没有在目录中发现发现PDF文件, 请重新选择目录!')
end

%% 论文编号
[N, M] = size(paperName);
% 打乱论文排序
paperName = paperName(randperm(N),:);
% 将论文编号写入Excel
id = num2cell((1:N)');
nameCell = mat2cell(paperName, ones(1,N), M);
title = {'ID', 'filename'};
paperID = cell2table([id, nameCell], 'VariableNames',title);
writetable(paperID, '论文编号.csv');

%% 论文文件重命名
% 备份原始文件
copyfile(paperDir, '原始论文备份');
for i = 1:N
    movefile(strcat(paperDir,'\',strtrim(paperName(i,:))), ...
        strcat(paperDir,'\',num2str(i),'.pdf'));
end