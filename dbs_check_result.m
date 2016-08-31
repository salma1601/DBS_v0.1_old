function resultSum = dbs_check_result(dbs_result, thrCFT, thrClst)
% DBS_check_result    
% ================================================================================================================ 
% [ INPUTS ]
%     dbs_result, thrCFT, thrClst
% ----------------------------------------------------------------------------------------------------------------
% [ OUTPUTS ]
%     resultSum
% ----------------------------------------------------------------------------------------------------------------
% Last update: Aug 31, 2016.
% 
% Copyright 2016. Kwangsun Yoo (K Yoo), PhD
%     E-mail: rayksyoo@gmail.com / raybeam@kaist.ac.kr
%     Laboratory for Cognitive Neuroscience and NeuroImaging (CNI)
%     Department of Bio and Brain Engineering
%     Korea Advanced Instititue of Science and Technology (KAIST)
%     Daejeon, Republic of Korea
% 
%     Paper: Degree-based statistic and center persistency for brain connectivity analysis (2016) Human Brain Mapping.
% ================================================================================================================

thrCFT2 = thrCFT + min(abs( thrCFT - dbs_result.icft.p.range));
indCFT = find(dbs_result.icft.p.range == thrCFT2);

wdNodeCent = find(dbs_result.wd.org{indCFT} > dbs_result.wd.max_sort{indCFT}(floor(thrClst * length(dbs_result.wd.max_sort{indCFT})) ));
thrClst2 = floor(thrClst * length(dbs_result.wd.max_sort{indCFT})) / length(dbs_result.wd.max_sort{indCFT});

if isempty(wdNodeCent)
    fprintf('    no edge was significant (FWE p-value = %f.4, icft p-value = %f.4).\n', thrClst2, thrCFT2)
    wdNodePeri = [];
else
    for i = 1:length(wdNodeCent);     wdNodePeri{i,1} = find(dbs_result.s{indCFT}(wdNodeCent(i),:));     end
    if i > 1;     display('    There are significant clusters. Check the result file')
    else     display('    There is one significant cluster. Check the result file.');     end
end

for thre = 1 : length(dbs_result.icft.p.range)
    temp(thre,1) = dbs_result.bd.thre{thre};
end
if temp(end) > 1
    cpNode = dbs_result.cp.clst{end}(:,1);
else     indCPthre = find((temp == 1), 1) - 1;
    cpNode = dbs_result.cp.clst{indCPthre}(:,1);
end

resultSum.wdNodeCent = wdNodeCent;     resultSum.wdNodePeri = wdNodePeri;
resultSum.cpNode = cpNode;
