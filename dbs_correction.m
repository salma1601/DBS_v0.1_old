function dbs = dbs_correction(dbs_thre, icft, s, p)
% DBS_CORRECTION    
% ================================================================================================================ 
% [ INPUTS ]
%     dbs_thre, icft, s, p
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

s2 = abs(s);
for thre = 1:length(icft.s.range)
    clear a b s_thre
    [a, s_thre] = dbs_estm_dgr(p, s, icft.p.range(thre), icft.s.range(thre));
    dbs.bd.org{thre,1} = a.bd.org;
    dbs.wd.org{thre,1} = a.wd.org;
    dbs.s{thre,1} = s_thre;    
    
    b = dbs_estm_sig(dbs.bd.org{thre}, dbs_thre.bd.thre{thre}, dbs.wd.org{thre}, dbs_thre.wd.thre{thre});
    dbs.bd.clst{thre,1} = b.bd.clst;
    dbs.wd.clst{thre,1} = b.wd.clst;
    for i_clst = 1 : size(dbs.bd.clst{thre},1)
        dbs.bd.clstnode{thre,1}{i_clst,1}(:,1) = find(dbs.s{thre}(dbs.bd.clst{thre}(i_clst,1), :) );
        dbs.bd.clstnode{thre,1}{i_clst,1}(:,2) = s2(dbs.bd.clst{thre}(i_clst,1), dbs.bd.clstnode{thre,1}{i_clst,1}(:,1));
        dbs.bd.clstnode{thre,1}{i_clst,1}(:,3) = dbs.s{thre}(dbs.bd.clst{thre}(i_clst,1), dbs.bd.clstnode{thre,1}{i_clst,1}(:,1));
    end
    for i_clst = 1 : size(dbs.wd.clst{thre},1)
        dbs.wd.clstnode{thre,1}{i_clst,1}(:,1) = find(dbs.s{thre}(dbs.wd.clst{thre}(i_clst,1), :) ) ;
        dbs.wd.clstnode{thre,1}{i_clst,1}(:,2) = s2(dbs.wd.clst{thre}(i_clst,1), dbs.wd.clstnode{thre,1}{i_clst,1}(:,1));
        dbs.wd.clstnode{thre,1}{i_clst,1}(:,3) = dbs.s{thre}(dbs.wd.clst{thre}(i_clst,1), dbs.wd.clstnode{thre,1}{i_clst,1}(:,1));
    end
end

dbs.org.s{1,1} = s;    dbs.org.s{2,1} = abs(dbs.org.s{1});   dbs.org.p = p;
dbs.bd.thre = dbs_thre.bd.thre;     dbs.wd.thre = dbs_thre.wd.thre;
