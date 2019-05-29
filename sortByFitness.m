function chroms = sortByFitness(chroms)
%{
重载函数：适应度值排序
首次不加入精英
之后用精英替换最差个体后再排序
%}

if nargin==1
    [~,n] = size(chroms);
    for i = n:-1:1
     %每一次由底至上地上升
         for j = 1:1:i-1
               if chroms{1,j+1}.Fitness > chroms{1,j}.Fitness
                   temp = chroms{1,j};
                   chroms{1,j} = chroms{1,j+1};
                   chroms{1,j+1} = temp;
               end
         end
    end
    
elseif  nargin==2
    chroms = varargin{1};
    [~,n] = size(chroms);
    chromBest = varargin{2};
    goal = varargin{3};
    chroms = sortByFitness(chroms,goal);
    chroms{1,n} = chromBest;
    chroms = sortByFitness(chroms,goal);
end
end
