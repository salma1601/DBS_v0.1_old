function [dbs_perm] = dbs_perm(setmat, label, numperm, hypotest, direction, icft, pwr)
% DBS_PERM    Permutation to acquire an emprical null distributino of the maximum measures targeted.
%              for FWE correction using DBS in connectivity analysis
% ================================================================================================================ 
% [ INPUTS ]
%     setmat = 3-D matrix. a set of matrices from multiple subjects. One for each.
%         A size of setmat should be [N by N by M].
%             N: the number of nodes.
%             M: the number of subjects
% 
%     label = 1-D vector. a list of labels with a value 0 or 1, indicating in which group each subject is included (for hypotest = 0 or 2)
%                                     or with individual measures of all subjects for correlation (for hypotest = 1)
% 
%     numperm = # of permutations performed for family (default = 5000).
% 
%     hypotest = type of test (default = 0).
%         0: two-sample paired t-test (ttest)
%         1: correlation analysis (corr)
%         2: two-sample unpaired t-test (ttest2)
% 
%     icft = 1-D vector. a range of initial cluster-forming thresholds to test.
%               Refer function 'DBS_main'.
% 
%     pwr = the power of the threshold and the degree similar to the one in TFCE.
%           Refer function 'DBS_main'.
% ----------------------------------------------------------------------------------------------------------------
% [ OUTPUTS ]
%     dbs_perm
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

numsub = size(setmat,3);
numnode = size(setmat, 1); % or numnode = size(setmat,2);

for i_perm = 1 : numperm
    permlist(i_perm, :) = randperm(numsub); % permlist_uniq = unique(permlist,'rows');
end

t1 = clock;     reverseStr = '';    h = waitbar(0, 'DBS is running ...');

for i_perm = 1 : numperm
    temp_setmat = zeros(numnode, numnode, numsub );
    for j = 1:numsub
        temp_setmat(:,:,j) = setmat(:,:,permlist(i_perm,j));
    end
    [s, ~, p] = dbs_hypo_test(temp_setmat, label, hypotest, direction);
    
    for thre = 1:length(icft.s.range); clear a;
        a = dbs_estm_dgr(p, s, icft.p.range(thre), icft.s.range(thre)); 
        dbs_perm.bd.org{thre,1} = a.bd.org;     dbs_perm.bd.max{thre,1}(i_perm,1) = a.bd.max;
        dbs_perm.wd.org{thre,1} = a.wd.org;     dbs_perm.wd.max{thre,1}(i_perm,1) = a.wd.max;   
    end
    
    for thre_limit = 2 : length(icft.s.range)
        cpMat = dbs_estm_cp(dbs_perm.wd.org, icft.s.range, thre_limit, numnode, pwr);
        dbs_perm.cp.org{thre_limit,1} = cpMat;
        dbs_perm.cp.max{thre_limit,1}(i_perm,1) = max(dbs_perm.cp.org{thre_limit});
    end
    
    [reverseStr, msg] = dbs_progress_box(i_perm, numperm, t1, reverseStr);
    waitbar(i_perm/numperm, h, sprintf('DBS is running ...  %0.1f %%', 100*i_perm/numperm))
end
reverseStr = repmat(sprintf('\b'), 1, length(msg));     fprintf(reverseStr);    close(h);

for thre = 1:length(icft.s.range)
    dbs_perm.bd.max_sort{thre,1} = sort(dbs_perm.bd.max{thre,1}, 'descend');
    dbs_perm.wd.max_sort{thre,1} = sort(dbs_perm.wd.max{thre,1}, 'descend');
end

fprintf('\t[ %d permutations done ]', i_perm)
