function dgr_range = dbs_estm_dgr_range (p, s, icft)
% DBS_ESTM_DGR_RANGE    
% ================================================================================================================ 
% [ INPUTS ]
%     p, s, icft
% ----------------------------------------------------------------------------------------------------------------
% [ OUTPUTS ]
%     dgr_range
% ----------------------------------------------------------------------------------------------------------------
% Last update: Aug 30, 2016.
% 
% Copyright 2016. Kwangsun Yoo (K Yoo), PhD
%     E-mail: rayksyoo@gmail.com / raybeam@kaist.ac.kr
%     Laboratory for Cognitive Neuroscience and NeuroImaging (CNI)
%     Department of Bio and Brain Engineering
%     Korea Advanced Instititue of Science and Technology (KAIST)
%     Daejeon, Republic of Korea
% ================================================================================================================

for thre = 1:length(icft.s.range)
    clear a
    a = dbs_estm_dgr(p, s, icft.p.range(thre), icft.s.range(thre)); 
    dgr_range.bd.max{thre}(i_perm,1) = a.bd.max;
    dgr_range.bd.org{thre} = a.bd.org;
    dgr_range.wd.max{thre}(i_perm,1) = a.wd.max;
    dgr_range.wd.org{thre} = a.wd.org;
end