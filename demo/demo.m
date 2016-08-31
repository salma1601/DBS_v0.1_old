% ======================================================= %
%  Example using DBS for the brain connectivity analysis  %
% ======================================================= %
% DEMO
% --------------------------------------------------------------------
% Last update: Aug 31, 2016.
% 
% Copyright 2016. Kwangsun Yoo (K Yoo), PhD
%     E-mail: rayksyoo@gmail.com / raybeam@kaist.ac.kr
%     Laboratory for Cognitive Neuroscience and NeuroImaging (CNI)
%     Department of Bio and Brain Engineering
%     Korea Advanced Instititue of Science and Technology (KAIST)
%     Daejeon, Republic of Korea
% ====================================================================

%% Load the demo.mat file provided.
load('./demo/demo.mat');
% aa : a label information of connectivity matrices
% s_all : 3-D connectivity matrix of 116x116x16
%         116x116 : AAL parcellation based connectivity matrix. 
%         16 : two matrices for each of 8 subjects (1,9 : 1st subject / ... / 8,16 : 8nd subject
% roi_name : an ordered list of AAL ROI

%% Run the dbs_main for the paired t-test with default options.
DBSrunned = dbs_main(s_all, aa, 0);

%% We want to check DBS-based FWE-corrected significance.
DBSresultSum = dbs_check_result(DBSrunned, 0.001, 0.05); 
% ICFT (initial cluster forming threshold p-value) = 0.001.
% DBS-based FWE-corrected cluster-wise threshold p-value = 0.05

%% Check the result.
% 
% DBSresultSum.wdNodeCent(i) represents a node shown to be a center of a
%     significant edge cluster, respectively, given the ICFT 0.001 and
%     cluster-wise threshold 0.05.
% 
% DBSresultSum.wdNodePeri{i}(:) represents nodes having significant
%     connections with DBSresultSum.wdNodeCent(i). given the above thresholds.
% 
% DBSresultSum.cpNode(i) represents a node shown to have a significant CP
%     score, for a threshold p-value of 0.05.
%%
