function dbs = dbs_main(setmat, label, hypoTest, direction, numperm, thrClst)
% DBS_MAIN    FWE correction using Degree-based statistics (DBS) in connectivity analysis
% ================================================================================================================ 
% [ INPUTS ]
%     setmat = 3-D matrix which consists of a set of 2-D matrices from multiple subjects.
%         A size of setmat should be [N by N by M].
%             N: the number of nodes.
%             M: the number of subjects
% 
%     label = 1-D vector containing a list of labels 
%               with a value 0 (group 1) or 1 (group 2), indicating in which group each subject is included (for hypoTest = 0 or 1)
%               or with individual measures of behavioral performance from each subjects for correlation (for hypoTest = 2)
% 
%     hypoTest = type of test (default = 0).
%         0: two-sample paired t-test (ttest)
%         1: two-sample unpaired t-test (ttest2) (assumping the same variance for the two groups)
%         2: correlation analysis (corr)
% 
%     direction
%          0: g1 = g2 (two-tail)
%          1: g1 > g2 (one-tail)
%         -1: g2 < g1 (one-tail)
% 
%     numperm = the number of permutations performed for family (default = 5000).
% 
%     thrClst = DBS-based FWE-corrected cluster-level threshold for significance  (default = 0.05) 
% ----------------------------------------------------------------------------------------------------------------
% [ OUTPUTS ]
%     dbs.bd = DBS corrected results from the binary degree
%     dbs.wd = DBS corrected results from the wiehgted degree
%     dbs.cp = DBS corrected results using 'Cluster Persistency (cp) score' with the weighted degree
%
%     dbs.s    = 
%     dbs.org  = 
%     dbs.time = time taken to run DBS analysis
%     dbs.icft = a range of initial cluster-forming thresholds in analysis 
% ----------------------------------------------------------------------------------------------------------------
% Last update: Aug 30, 2016.
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

temp = clock;   fprintf('\n\t\t%d, %d/%d, %d:%2.0f:%2.0f\tProcess started\n', temp)

%% Check the input argument
if nargin < 3; error('Must input at least three parameters.\n'); end

if ~exist('direction'); direction = 0; 
elseif isempty(direction); direction = 0; end;

if ~exist('numperm'); numperm = 5000; 
elseif isempty(numperm); numperm = 5000;
else	if numperm < 1000; warning('You should run permutations more for the exact estimation (e.g. 1,000, 5,000, 10,000 times, or more.)'); end; end;

if ~exist('thrClst'); thrClst = 0.05; 
elseif isempty(thrClst); thrClst = 0.05; 
else	if thrClst >= 1; error('Cluster-wise threshold should be below one.'); end; end;

%% Set the default parameters & get the information from input
pwr.dgr = 1;    pwr.thr = 0; % two paramters described in the Discussion section of the original paper. This is for further development.
numSubj = size(setmat,3);    numNode = size(setmat, 1);

df = dbs_cal_df (hypoTest, numSubj); % calculate degree of freedom (DOF or DF) given a hypothesis and the number of subjects
icft = dbs_set_p_range (); % initial cluster-forming threshold (icft)
icft_temp = dbs_set_initrange (hypoTest, icft.p.range, df, direction);
icft.s.range =icft_temp;

%% Test the hypothesis
[s, ~, p] = dbs_hypo_test(setmat, label, hypoTest, direction);

%% Permutations for correction
tic;     
[perm_result] = dbs_perm(setmat, label, numperm, hypoTest, direction, icft, pwr);

thrClst1 = ceil(thrClst*numperm); thrClst2 = floor(thrClst*numperm);
for thre = 1 : length(icft.s.range)
    dbs_thre.bd.thre{thre,1} = perm_result.bd.max_sort{thre}(thrClst2);
    dbs_thre.wd.thre{thre,1} = perm_result.wd.max_sort{thre}(thrClst1);
end
temp_time = toc;
fprintf('\t( %.2f minutes elapsed. )\n', temp_time/60)

%% Correction with DBS
dbs = dbs_correction(dbs_thre, icft, s, p);
dbs.bd.max_sort = perm_result.bd.max_sort;    dbs.wd.max_sort = perm_result.wd.max_sort;

%% Calculate Center Persistency (CP) score
cp_result = dbs_cal_cp (numNode, numperm, thrClst, icft.s.range, dbs, perm_result.cp, pwr);
dbs.cp = cp_result;

%% Finish process
dbs.icft = icft;
dbs.time{1} = temp;     dbs.time{2,1} = clock;
fprintf('\n\t\t%d, %d/%d, %d:%2.0f:%2.0f\tProcess done\n\n', dbs.time{2})

