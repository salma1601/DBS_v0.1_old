function dbs = dbs_estm_sig(bdgr, bdgr_thre, wdgr, wdgr_thre)
% DBS_ESTM_SIG    Estimation of the FWE-corrected significance of degree and cluster persistency of every node
% ================================================================================================================ 
% [ INPUTS ]
%     bdgr, bdgr_thre, wdgr, wdgr_thr
% ----------------------------------------------------------------------------------------------------------------
% [ OUTPUTS ]
%     dbs
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

bdgr_sig = bdgr;
bdgr_sig (bdgr < bdgr_thre) = 0;
dbs.bd.clst(:,1) = find(bdgr_sig > 0);
dbs.bd.clst(:,2) = bdgr(bdgr_sig > 0);

wdgr_sig = wdgr;
wdgr_sig (wdgr <= wdgr_thre) = 0;
dbs.wd.clst(:,1) = find(wdgr_sig > 0);
dbs.wd.clst(:,2) = wdgr(wdgr_sig > 0);
