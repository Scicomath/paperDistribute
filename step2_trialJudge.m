% 上午试评脚本
clear
load data.mat
%% 设置评委及每人试评份数
% 评委姓名
name = {'艾鑫','李金武','宁丹麦','李学伟','王震','贾高萌','曾祥云','朱翠艳',...
    '覃太贵','陈江宏','张小华','王卫华','马德宜','杨志巧'};
% 试评人数
judgeNum = length(name);
% 每人试评份数
m = 5;
%% 获取论文路径与文件名
% 由于在renamePaper脚本中已经获取了论文目录, 故现在不需要再次获取
% 获取论文目录
%paperDir = uigetdir; 

% 获取论文文件名
paperName = ls(strcat(paperDir,'\*.pdf'));
if isempty(paperName)
    warndlg('错误: 没有在目录中发现发现PDF文件, 请重新选择目录!')
else
    % 试卷总数
    paperNum = size(paperName,1);
    % 方法一: 每个评委随机抽m份论文后放回, 可能出现一个论文被多个评委选中
%     if paperNum < m
%         disp('错误: 论文数小于试评份数!');
%     else
%         for i = 1:judgeNum
%             mkdir(['试评/',name{i}])
%             temp = randperm(paperNum);
%             for j = 1:m
%                 index = temp(j);
%                 fileName = strtrim(paperName(index, :));
%                 fileDir = [paperDir,'\',fileName];
%                 copyfile(fileDir, ['试评/',name{i},'/']);
%             end
%         end
%     end
    % 方法二: 每个评委随机抽取m份论文后不放回, 若论文不够分,则可能出现评委没有论文的情况
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
            else
                if (j-1) == 0
                    fprintf('警告: 论文数不够, %s没有分配论文!\n', name{i})
                else
                    fprintf('警告: 论文数不够, %s分配了%d份论文!\n', name{i},j-1)
                end
                break;
            end
        end
    end
end

% 保存数据
save data.mat