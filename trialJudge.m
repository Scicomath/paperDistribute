% 上午试评脚本
%% 设置评委及每人试评份数
% 评委姓名
name = {'艾鑫','李金武','宁丹麦','李学伟','王震','贾高萌','曾祥云','朱翠艳',...
    '覃太贵','陈江宏','张小华','王卫华','马德宜','杨志巧'};
% 试评人数
judgeNum = length(name);
% 每人试评份数
m = 5;
%% 获取论文路径与文件名
% 获取论文目录
paperDir = uigetdir;
% 获取论文文件名
paperName = ls(strcat(paperDir,'\*.pdf'));
if isempty(paperName)
    warndlg('错误: 没有在目录中发现发现PDF文件, 请重新选择目录!')
end

% 试卷总数
paperNum = size(paperName,1);

count = 0;
temp = randperm(paperNum);
for i = 1:judgeNum
    mkdir(['试评/',name{i}])
    for j = 1:m
        count = count + 1;
        if count <= paperNum % 确保不超过论文总数限制
            index = temp(count);
            fileName = strtrim(paperName(index,:));
            fileDir = [paperDir,'\',fileName];
            copyfile(fileDir, ['试评/',name{i},'/'])
        end
    end
end

