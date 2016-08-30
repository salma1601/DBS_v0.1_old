function [dbs_estm, s3] = dbs_estm_dgr (p, s, thr_p, thr_s)
% DBS_ESTM_DGR    Estimation of the degree in connectivitiy matrix for a initial cluster-forming threshold.
% ================================================================================================================ 
% [ INPUTS ]
%     p, s, thre_p, thr_s
% ----------------------------------------------------------------------------------------------------------------
% [ OUTPUTS ]
%     dbs_estm, s3
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

p2 = p;
p2(isnan(p2)) = 1;
p2(p2 > thr_p) = 1;
dbs_estm.h = 1- p2;
dbs_estm.h(dbs_estm.h > 0) = 1;

dbs_estm.bd.org = sum(dbs_estm.h)';
dbs_estm.bd.max = max(dbs_estm.bd.org);

s2 = s;
s2(isnan(s2)) = 0;
s2(dbs_estm.h == 0) = 0;
s3 = abs(s2);
s3(s3 > 0) = s3(s3 > 0) - abs(thr_s);

dbs_estm.wd.org = sum(s3)';
dbs_estm.wd.max = max(dbs_estm.wd.org);
