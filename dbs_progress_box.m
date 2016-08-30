function [reverseStr, msg] = dbs_progress_box(i, max, t1, reverseStr)
% DBS_PROGRESS_BOX    
% ================================================================================================================ 
% [ INPUTS ]
%     i, max, t1, reverseStr
% ----------------------------------------------------------------------------------------------------------------
% [ OUTPUTS ]
%     reverseStr, msg
% ----------------------------------------------------------------------------------------------------------------
% Last update: Aug 30, 2016.
% 
% Copyright 2016. Kwangsun Yoo (K Yoo), PhD
%     E-mail: rayksyoo@gmail.com / raybeam2kaist.ac.kr
%     Laboratory for Cognitive Neuroscience and NeuroImaging (CNI)
%     Department of Bio and Brain Engineering
%     Korea Advanced Instititue of Science and Technology (KAIST)
%     Daejeon, Republic of Korea
% ================================================================================================================

t2 = clock;     t3 = (etime(t2,t1)/i) * (max-i);
perc = 100*i/max;

msg = sprintf('\t\t[ Running %d permutations >>>  %.1f percent done, %.0f seconds left. ]', max, perc, t3);
fprintf([reverseStr, msg])
reverseStr = repmat(sprintf('\b'), 1, length(msg));