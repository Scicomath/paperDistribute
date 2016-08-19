% ���������ű�
clear
load data.mat
%% ������ί��ÿ����������
% ��ί����
name = {'����','�����','������','��ѧΰ','����','�ָ���','������','�����',...
    '��̫��','�½���','��С��','������','�����','��־��'};
% ��������
judgeNum = length(name);
% ÿ����������
m = 5;
%% ��ȡ����·�����ļ���
% ������renamePaper�ű����Ѿ���ȡ������Ŀ¼, �����ڲ���Ҫ�ٴλ�ȡ
% ��ȡ����Ŀ¼
%paperDir = uigetdir; 

% ��ȡ�����ļ���
paperName = ls(strcat(paperDir,'\*.pdf'));
if isempty(paperName)
    warndlg('����: û����Ŀ¼�з��ַ���PDF�ļ�, ������ѡ��Ŀ¼!')
else
    % �Ծ�����
    paperNum = size(paperName,1);
    % ����һ: ÿ����ί�����m�����ĺ�Ż�, ���ܳ���һ�����ı������ίѡ��
%     if paperNum < m
%         disp('����: ������С����������!');
%     else
%         for i = 1:judgeNum
%             mkdir(['����/',name{i}])
%             temp = randperm(paperNum);
%             for j = 1:m
%                 index = temp(j);
%                 fileName = strtrim(paperName(index, :));
%                 fileDir = [paperDir,'\',fileName];
%                 copyfile(fileDir, ['����/',name{i},'/']);
%             end
%         end
%     end
    % ������: ÿ����ί�����ȡm�����ĺ󲻷Ż�, �����Ĳ�����,����ܳ�����ίû�����ĵ����
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
            else
                if (j-1) == 0
                    fprintf('����: ����������, %sû�з�������!\n', name{i})
                else
                    fprintf('����: ����������, %s������%d������!\n', name{i},j-1)
                end
                break;
            end
        end
    end
end

% ��������
save data.mat