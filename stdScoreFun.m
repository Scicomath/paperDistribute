function [ stdScore ] = stdScoreFun( oriScore )
%stdScoreFun 计算标准分函数
%   输入原始分，返回标准分

ave = mean(oriScore);
sigma = std(oriScore);

stdScore = ((oriScore - ave) ./sigma) .* 8 + 60;

end

