function a = dbs_set_p_range
% DBS_SET_P_RANGE    Set a range of the initial cluster-forming threshold p-value to be tested
% ================================================================================================================ 
% [ OUTPUTS ]
%     a.p.lb    = lower boundary of the range, p-value = 0.05.
%     a.p.hb    = higher boundary of the range, p-value = 0.0001.
%     a.p.range = the range between a.p.lb and a.p.hb
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

a.p.lb = 0.05; % lower boundary
a.p.hb = 0.0001; % higher boundary
log10p.lb = log10(a.p.lb);
log10p.hb = log10(a.p.hb);
log10p.range = [ log10(a.p.lb) : -0.1 : log10(a.p.hb)-0.1 ]';

temp1 = 10000 * (10.^(log10p.range));
temp2 = 10000 * [ a.p.lb : -0.005 : a.p.hb ]';

a.p.range = flipud(union(round(temp1), round(temp2)))/10000;
