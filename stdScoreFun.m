function [ stdScore ] = stdScoreFun( oriScore )
%stdScoreFun �����׼�ֺ���
%   ����ԭʼ�֣����ر�׼��

ave = mean(oriScore);
sigma = std(oriScore);

stdScore = ((oriScore - ave) ./sigma) .* 8 + 60;

end

