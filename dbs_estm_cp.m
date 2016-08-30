function cpMat = dbs_estm_cp(wd_org, initthre_range, thre_limit, numnode, pwr)
% DBS_ESTM_CP    
% ================================================================================================================ 
% [ INPUTS ]
%     wd_org, initthre_range, thre_limit, numnode, pwer% 
% ----------------------------------------------------------------------------------------------------------------
% [ OUTPUTS ]
%     cpMat
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

cpMat = zeros(numnode,1);

for thre = 1 : thre_limit
    if thre == thre_limit
        cpMat = cpMat + (wd_org{thre} .^ pwr.dgr * initthre_range(thre) ^ pwr.thr * (initthre_range(thre) - initthre_range(thre-1)) ) ;
    else
        cpMat = cpMat + (wd_org{thre} .^ pwr.dgr * initthre_range(thre) ^ pwr.thr * (initthre_range(thre+1) - initthre_range(thre)) ) ;
    end
end