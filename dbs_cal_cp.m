function cp = dbs_cal_cp (numNode, numperm, thrClst, initthre_range, dbs, perm_cp, pwr)
% DBS_CAL_CP    
% ================================================================================================================ 
% [ INPUTS ]
%     numperm = the number of permutations performed for family (default = 5000).
%     thrClst = DBS-based FWE-corrected cluster-level threshold for significance  (default = 0.05) 
%     numNode, initthre_range, dbs, perm_cp, pwr
% ----------------------------------------------------------------------------------------------------------------
% [ OUTPUTS ]
%     cp
% ----------------------------------------------------------------------------------------------------------------
% Last update: Aug 31, 2016.
% 
% Copyright 2016. Kwangsun Yoo (K Yoo), PhD
%     E-mail: rayksyoo@gmail.com / raybeam@kaist.ac.kr
%     Laboratory for Cognitive Neuroscience and NeuroImaging (CNI)
%     Department of Bio and Brain Engineering
%     Korea Advanced Instititue of Science and Technology (KAIST)
%     Daejeon, Republic of Korea
% ================================================================================================================

for thre_limit = 2 : length(initthre_range)
    cpMat = dbs_estm_cp(dbs.wd.org, initthre_range, thre_limit, numNode, pwr);
    cp.org{thre_limit,1} = cpMat;
    cp.org_sort{thre_limit,1} = sort(cp.org{thre_limit}, 'descend');
    perm_cp.max_sort{thre_limit,1} = sort(perm_cp.max{thre_limit}, 'descend');
end

cp.max_sort = perm_cp.max_sort; % clear perm_cp

thrClst_int = ceil(thrClst * numperm);
cp.org_sig = cp.org;

for thre_limit = 2 : length(initthre_range)
    cp.thre(thre_limit,1) = perm_cp.max_sort{thre_limit}(thrClst_int);
    cp.norm{thre_limit,1} = cp.org{thre_limit,1} / cp.thre(thre_limit);
    cp.norm_sort{thre_limit,1} = sort(cp.norm{thre_limit,1}, 'descend');

    cp.org_sig{thre_limit,1} = cp.org{thre_limit};
    cp.org_sig{thre_limit}(cp.org_sig{thre_limit} <= cp.thre(thre_limit)) = 0;

    cp.norm_sig{thre_limit,1} = cp.norm{thre_limit};
    cp.norm_sig{thre_limit}(cp.norm_sig{thre_limit} <= 1) = 0;

    cp.clst{thre_limit,1}(:,1) = find(cp.org_sig{thre_limit} > 0);
    cp.clst{thre_limit,1}(:,2) = cp.org{thre_limit}(cp.org_sig{thre_limit} > 0);
    
    for i_cp = 1: size(cp.clst{thre_limit}, 1)
        for i_thre = 1:thre_limit
            cp.clstnode{thre_limit,1}{i_thre,i_cp}(:,1) = find(dbs.s{i_thre}(cp.clst{thre_limit}(i_cp,1), :) > 0);
        end
    end;
end;
