C
C Matlab Gateway Function for randomForest algorithm for 
C classification based on Breiman and Cutler's original 
C Fortran code version 3.3
C
C By Ting Wang,  Merck & Co. 
C Last Date : Jun 20, 2003
C
C-----------------------------------------------------------------
      subroutine mexFunction(nlhs, plhs, nrhs, prhs)
      integer plhs(*), prhs(*)
      integer mxGetPr, mxGetM, mxGetN, mxCreateDoubleMatrix
C
C input parameters
      integer param(31)
      integer mdim,nsample0,nclass,maxcat,ntest,
     +        labelts,iaddcl,jbt,mtry,look,
     +        ipi,ndsize,imp,iprox,ioutlier,
     +        iscale,mdimsc,ipc,mdimpc,inorm,
     +        irunf,iseed,isavef,ntrees,nsample,
     +        nrnodes,mopt,mimp,nimp,near,
     +        mred
C
C input matrix
      integer pPr,xPr,clPr,catPr,piPr,
     +        xtsPr,cltsPr,pidPr,treesPr,ndbtreesPr
C
C output matrix
      integer jestPr, jetPr, counttrPr, counttsPr, errtrAPr, 
     +        errtsAPr, mtabPr,mtabtsPr, nodestatusAPr, 
     +        bestvarAPr, treemapAPr, nodeclassAPr,xbestsplitAPr, 
     +        proxPr, outlierPr, errimpPr, diffmargPr, cntmargPr,
     +        tginiPr, prox2Pr
C
C temp matrix:real
      integer classpopPr,rmarginPr,smPr,tclasspopPr,
     +        txPr,winPr,wttPr,xbestsplitPr
      integer classpop,errimp,rmargin,sm,tclasspop,
     +        tx,win,wtt,xbestsplit
C
C temp matrx:integer
      integer aPr,atPr,bPr,bestsplitPr,bestsplitnextPr,bestvarPr,
     +        cbestsplitPr,clpPr,countimpPr,ctproxPr,idmovePr,
     +        isortPr,ivPr,jerrPr,jinPr,jtrPr,jtsPr,jvrPr,
     +        mtproxncasePr,ncasePr,ncpPr,ndblePr,
     +        nodeclassPr,nodepopPr,nodestartPr,nodestatusPr,
     +        nodexPr,nodextsPr,outPr,taPr,treemapPr
      integer a,at,b,bestsplit,bestsplitnext,bestvar,
     +        cbestsplit,clp,countimp,ctprox,idmove,
     +        isort,iv,jerr,jin,jtr,jts,jvr,
     +        mtproxncase,ncase,ncp,ndble,
     +        nodeclass,nodepop,nodestart,nodestatus,
     +        nodex,nodexts,out,ta,treemap
C
C Input [Parm] [X] [CL] [CAT] [PI] 
       pPr        = mxGetPr(prhs(1))
       xPr        = mxGetPr(prhs(2))
       clPr       = mxGetPr(prhs(3))
       catPr      = mxGetPr(prhs(4))
       piPr       = mxGetPr(prhs(5))
       xtsPr      = mxGetPr(prhs(6))
       cltsPr     = mxGetPr(prhs(7))
       pidPr      = mxGetPr(prhs(8))
       treesPr    = mxGetPr(prhs(9))
       ndbtreesPr = mxGetPr(prhs(10))
C
      call mxCopyPtrToInteger4(pPr,param,31)
        mdim      = param(1)
        nsample0  = param(2)
        nclass    = param(3)
        maxcat    = param(4)
        ntest     = param(5)
        labelts   = param(6)
        iaddcl    = param(7)
        jbt       = param(8)
        mtry      = param(9)
        look      = param(10)
        ipi       = param(11)
        ndsize    = param(12)
        imp       = param(13)
        iprox     = param(14)
        ioutlier  = param(15)
        iscale    = param(16)
        mdimsc    = param(17)
        ipc       = param(18)
        mdimpc    = param(19)
        inorm     = param(20)
        irunf     = param(21)
        iseed     = param(22)
        isavef    = param(23)
        ntrees    = param(24)
        nsample   = param(25)
        nrnodes   = param(26)
        mopt      = param(27)
        mimp      = param(28)
        nimp      = param(29)
        near      = param(30)
        mred      = param(31)
C
C Output [jest] [counttr] [errimp] [prox] [outlier]
      call Create2Int(jestPr,        plhs(1), 1,nsample)
      call Create2Int(jetPr,         plhs(2), 1,ntest)
      call Create2Int(counttrPr,     plhs(3), nclass,nsample)
      call Create2Sgl(counttsPr,     plhs(4), nclass,ntest)
      call Create2Sgl(errtrAPr,      plhs(5), 1,jbt)
      call Create2Sgl(errtsAPr,      plhs(6), 1,jbt)
      call Create2Int(mtabPr,        plhs(7), nclass,nclass)
      call Create2Int(mtabtsPr,      plhs(8), nclass,nclass)
      call Create2Int(nodestatusAPr, plhs(9), jbt,nrnodes)
      call Create2Int(bestvarAPr,    plhs(10),jbt,nrnodes)
      call Create3Int(treemapAPr,    plhs(11),jbt,2,nrnodes)
      call Create2Int(nodeclassAPr,  plhs(12),jbt,nrnodes)
      call Create2Sgl(xbestsplitAPr, plhs(13),jbt,nrnodes)
      call Create2Dbl(proxPr,        plhs(14),near,near)
      call Create2Sgl(outlierPr,     plhs(15),1,near)
      call Create2Sgl(errimpPr,      plhs(16),1,mimp)
      call Create2Sgl(diffmargPr,    plhs(17),1,mdim)
      call Create2Sgl(cntmargPr,     plhs(18),1,mdim)
      call Create2Sgl(tginiPr,       plhs(19),1,mdim)
      call Create2Dbl(prox2Pr,       plhs(20),near,near)
C
C Allocate memory for matrix in Fortran
      call Create2Sgl(classpopPr,    classpop,nclass,nrnodes)
      call Create2Sgl(rmarginPr,     rmargin,1,nsample)
      call Create2Sgl(smPr,          sm,1,nsample0)
      call Create2Sgl(tclasspopPr,   tclasspop,1,nclass)
      call Create2Sgl(txPr,          tx,1,nsample)
      call Create2Sgl(winPr,         win,1,nsample)
      call Create2Sgl(wttPr,         wtt,1,nsample)
      call Create2Sgl(xbestsplitPr,  xbestsplit,1,nrnodes)
      call Create2Int(aPr,           a,mdim,nsample)
      call Create2Int(atPr,          at,mdim,nsample)
      call Create2Int(bPr,           b,mdim,nsample)
      call Create2Int(bestsplitPr,   bestsplit,1,nrnodes)
      call Create2Int(bestsplitnextPr, bestsplitnext,1,nrnodes)
      call Create2Int(bestvarPr,     bestvar,1,nrnodes)
      call Create2Int(cbestsplitPr,  cbestsplit,maxcat,nrnodes)
      call Create2Int(clpPr,         clp,1,near)
      call Create3Int(countimpPr,    countimp,nclass,nimp,mimp)
      call Create2Int(ctproxPr,      ctprox,near,near)
      call Create2Int(idmovePr,      idmove,1,nsample)
      call Create2Int(isortPr,       isort,1,nsample)
      call Create2Int(ivPr,          iv,1,mred)
      call Create2Int(jerrPr,        jerr,1,nsample)
      call Create2Int(jinPr,         jin,1,nsample)
      call Create2Int(jtrPr,         jtr,1,nsample)
      call Create2Int(jtsPr,         jts,1,ntest)
      call Create2Int(jvrPr,         jvr,1,nsample)
      call Create2Int(mtproxPr,      mtprox,near,near)
      call Create2Int(ncasePr,       ncase,1,nsample)
      call Create2Int(ncpPr,         ncp,1,near)
      call Create2Int(ndblePr,       ndble,1,nsample0)
      call Create2Int(nodeclassPr,   nodeclass,1,nrnodes)
      call Create2Int(nodepopPr,     nodepop,1,nrnodes)
      call Create2Int(nodestartPr,   nodestart,1,nrnodes)
      call Create2Int(nodestatusPr,  nodestatus,1,nrnodes)
      call Create2Int(nodexPr,       nodex,1,nsample)
      call Create2Int(nodextsPr,     nodexts,1,ntest)
      call Create2Int(outPr,         out,1,nsample)
      call Create2Int(taPr,          ta,1,nsample)
      call Create2Int(treemapPr,     treemap,2,nrnodes)
C
C
C
      call rfc(mdim,nsample0,nclass,maxcat,ntest,
     +     labelts,iaddcl,jbt,mtry,look,
     +     ipi,ndsize,imp,iprox,ioutlier,
     +     iscale,mdimsc,ipc,mdimpc,inorm,
     +     irunf,iseed,isavef,ntrees,
     +     nsample,nrnodes,mopt,mimp,nimp,
     +     near,mred,
     + %val(xPr),%val(clPr),%val(catPr),%val(piPr),%val(xtsPr),
     + %val(cltsPr),%val(pidPr),%val(treesPr),%val(ndbtreesPr),
     + %val(jestPr),%val(jetPr),%val(counttrPr),%val(counttsPr),
     + %val(errtrAPr),%val(errtsAPr),%val(mtabPr),%val(mtabtsPr),
     + %val(nodestatusAPr),%val(bestvarAPr),%val(treemapAPr),
     + %val(nodeclassAPr),%val(xbestsplitAPr),%val(proxPr),
     + %val(outlierPr),%val(errimpPr),%val(diffmargPr),
     + %val(cntmargPr),%val(tginiPr),%val(prox2Pr),
     + %val(classpopPr),%val(rmarginPr),%val(smPr),
     + %val(tclasspopPr),%val(txPr),%val(winPr),%val(wttPr),
     + %val(xbestsplitPr),%val(aPr),%val(atPr),%val(bPr),
     + %val(bestsplitPr),%val(bestsplitnextPr),%val(bestvarPr),
     + %val(cbestsplitPr),%val(clpPr),%val(countimpPr),
     + %val(ctproxPr),%val(idmovePr),%val(isortPr),%val(ivPr),
     + %val(jerrPr),%val(jinPr),%val(jtrPr),%val(jtsPr),
     + %val(jvrPr),%val(mtproxPr),
     + %val(ncasePr),%val(ncpPr),%val(ndblePr),%val(nodeclassPr),
     + %val(nodepopPr),%val(nodestartPr),%val(nodestatusPr),
     + %val(nodexPr),%val(nodextsPr),%val(outPr),%val(taPr),
     + %val(treemapPr) )

      return
      end
C
C Dynamic allocate memory functions 
C
      subroutine Create2Int(Pr,Id,m,n)
        integer Pr,Id,m,n,d(2)
        d(1)=m
        d(2)=n
        Id=mxCreateNumericArray(2,d,
     +       mxClassIDFromClassName('int32'),0)
        Pr=mxGetPr(Id)
      return
      end
C
      subroutine Create3Int(Pr,Id,m,n,r)
        integer Pr,Id,m,n,r,d(3)
        d(1)=m
        d(2)=n
        d(3)=r
        Id=mxCreateNumericArray(3,d,
     +       mxClassIDFromClassName('int32'),0)
        Pr=mxGetPr(Id)
      return
      end
C
      subroutine Create2Sgl(Pr,Id,m,n)
        integer Pr,Id,m,n,d(2)
        d(1)=m
        d(2)=n
        Id=mxCreateNumericArray(2,d,
     +       mxClassIDFromClassName('single'),0)
        Pr=mxGetPr(Id)
      return
      end
C
      subroutine Create3Sgl(Pr,Id,m,n,r)
        integer Pr,Id,m,n,r,d(3)
        d(1)=m
        d(2)=n
        d(3)=r
        Id=mxCreateNumericArray(3,d,
     +       mxClassIDFromClassName('single'),0)
        Pr=mxGetPr(Id)
      return
      end
C
      subroutine Create2Dbl(Pr,Id,m,n)
        integer Pr,Id,m,n,d(2)
        d(1)=m
        d(2)=n
        Id=mxCreateNumericArray(2,d,
     +       mxClassIDFromClassName('double'),0)
        Pr=mxGetPr(Id)
      return
      end

C----------------------------------------------------------------
C RANDOM FOREST Classification
C----------------------------------------------------------------
      subroutine rfc(mdim,nsample0,nclass,maxcat,ntest,
     +     labelts,iaddcl,jbt,mtry,look,
     +     ipi,ndsize,imp,iprox,ioutlier,
     +     iscale,mdimsc,ipc,mdimpc,inorm,
     +     irunf,iseed,isavef,ntrees,
     +     nsample,nrnodes,mopt,mimp,nimp,
     +     near,mred,
     + x,cl,cat,pi,xts,clts,pid,trees,ndbtrees,jest,jet,counttr,
     + countts,errtrA,errtsA,mtab,mtabts,nodestatusA,bestvarA,
     + treemapA,nodeclassA,xbestsplitA,ox,outlier,errimp,diffmarg,
     + cntmarg,tgini,ox2,classpop,rmargin,sm,tclasspop,tx,win,wtt,
     + xbestsplit,a,at,b,bestsplit,bestsplitnext,bestvar,
     + cbestsplit,clp,countimp,ctox,idmove,isort,iv,jerr,jin,jtr,
     + jts,jvr,mtox,ncase,ncp,ndble,nodeclass,nodepop,
     + nodestart,nodestatus,nodex,nodexts,out,ta,treemap )

      implicit real(a-h,o-z)

      integer mdim,nsample0,nclass,maxcat,ntest,
     +     labelts,iaddcl,jbt,mtry,look,
     +     ipi,ndsize,imp,iprox,ioutlier,
     +     iscale,mdimsc,ipc,mdimpc,inorm,
     +     irunf,iseed,isavef,ntrees,
     +     nsample,nrnodes,mopt,mimp,nimp,
     +     near,mred

      real classpop(nclass,nrnodes),cntmarg(mdim), 
     +     countts(nclass,ntest),diffmarg(mdim),errimp(mimp), 
     +     errtrA(jbt),errtsA(jbt),outlier(near),pi(nclass), 
     +     pid(nclass),rmargin(nsample),sm(nsample0),
     +     tclasspop(nclass),tgini(mdim),trees(6,ntrees),
     +     tx(nsample),win(nsample),wtt(nsample),
     +     x(mdim,nsample),xbestsplit(nrnodes),
     +     xbestsplitA(jbt,nrnodes),xts(mdim,ntest)
    
      integer a(mdim,nsample),at(mdim,nsample),b(mdim,nsample),
     +     bestsplit(nrnodes),bestsplitnext(nrnodes),
     +     bestvar(nrnodes),bestvarA(jbt,nrnodes),cat(mdim),
     +     cbestsplit(maxcat,nrnodes),cl(nsample),clp(near),
     +     clts(ntest),countimp(nclass,nimp,mimp),
     +     counttr(nclass,nsample),ctprox(near,near),
     +     idmove(nsample),isort(nsample),
     +     iv(mred),jerr(nsample),jest(nsample),jet(ntest),
     +     jin(nsample),jtr(nsample),jts(ntest),jvr(nsample),
     +     mtab(nclass,nclass),mtabts(nclass,nclass),mtprox(near,near),
     +     ncase(nsample),ncp(near),ndble(nsample0),ndbtrees(jbt),
     +     nodeclass(nrnodes),nodeclassA(jbt,nrnodes),
     +     nodepop(nrnodes),nodestart(nrnodes),nodestatus(nrnodes),
     +     nodestatusA(jbt,nrnodes),nodex(nsample),nodexts(ntest),
     +     out(nsample),ta(nsample),treemap(2,nrnodes),
     +     treemapA(jbt,2,nrnodes)
    
      real*8 prox(near,near),prox2(near,near)
       
C----+|----------------------------------------------------------

      if(irunf.eq.1) goto 900
      if(isavef.eq.2) open(9,file='cforest.txt',status='new')

c SET CATEGORICAL VALUES
        
      if(maxcat.eq.1) then
          do m=1,mdim
            cat(m)=1
          end do
      end if

C SET UP DATA TO ADD A CLASS 
    
      if(iaddcl.ge.1) then
        call createclass(x,cl,nsample0,nsample,mdim,
     +                   sm,ndble,iaddcl,iseed)
      end if

C TRANSFORM TO PRINCIPAL COMPONENTS

      if(ipc.eq.1) then
        call pcomp(x,xts,mdim,nsample,ntest,inorm,mdimpc)
        end if

C INITIALIZE FOR RUN
 
        call zermr(countts,nclass,ntest)
        call zerm(counttr,nclass,nsample)
        call zerv(out,nsample)
        call zervr(tgini,mdim)
      call zermd(prox,near,near)

        if(imp.eq.1) then
          do j=1,nclass
            do n=1,nsample
              do m=1,mdim
                countimp(j,n,m)=0
              end do
            end do
          end do
        end if
        
        call prep(cl,nsample,nclass,ipi,pi,pid,wtt)
        call makea(x,mdim,nsample,cat,isort,at,b,mred)

C START RUN  
      
      do jb=1,jbt
        
        call zerv(nodestatus,nrnodes)
      call zerm(treemap,2,nrnodes)
      call zervr(xbestsplit,nrnodes)
      call zerv(nodeclass,nrnodes)
        call zerv(jin,nsample)
        call zervr(tclasspop,nclass)
        call zervr(win,nsample)
        call zerv(bestvar,nrnodes)

        do n=1,nsample
          k=int(ran(iseed)*nsample)+1
        tclasspop(cl(k))=tclasspop(cl(k))+wtt(k)
        win(k)=win(k)+wtt(k)
          jin(k)=1
        end do
    
      call eqm(a,at,mdim,nsample)
      call moda(a,nuse,nsample,mdim,cat,maxcat,ncase,jin,ta)

      call buildtree(a,b,cl,cat,mdim,nsample,nclass,treemap,
     +  bestvar,bestsplit,bestsplitnext,tgini,nodestatus,nodepop,
     +  nodestart,classpop,tclasspop,ta,nrnodes,idmove,
     +  ndsize,ncase,jin,mtry,iv,nodeclass,ndbigtree,win,
     +  mred,nuse,iseed)

      call xtranslate(x,mdim,nrnodes,nsample,bestvar,bestsplit,
     1  bestsplitnext,xbestsplit,nodestatus,cat,ndbigtree)

C GET TEST SET ERROR ESTIMATES
        
      if(ntest.gt.1) then
        call testreebag(xts,ntest,mdim,treemap,nodestatus,
     +    xbestsplit,cbestsplit,bestvar,nodeclass,nrnodes,
     +    ndbigtree,cat,nclass,jts,nodexts,maxcat)
        call comptserr(countts,jts,clts,jet,ntest,nclass,
     +    errts,pid,labelts)
      end if
        
C GET OUT-OF-BAG ESTIMATES
        
      call testreebag(x,nsample,mdim,treemap,nodestatus,
     +  xbestsplit,cbestsplit,bestvar,nodeclass,nrnodes,
     +  ndbigtree,cat,nclass,jtr,nodex,maxcat)
     
        do n=1,nsample
          if(jin(n).eq.0) then
          counttr(jtr(n),n)=counttr(jtr(n),n)+1
            out(n)=out(n)+1
          end if
        end do
     
      if (mod(jb,look).eq.0.or.jb.eq.jbt) then
        call oob(nsample,nclass,jin,cl,jtr,jerr,
     +    counttr,out,errtr,errc,rmargin,jest,wtt)
      endif

C DO VARIABLE IMPORTANCE 

      if(imp.eq.1) then
        call zerv(iv,mdim)
        do kt=1,ndbigtree
          if(nodestatus(kt).ne.-1) then
            iv(bestvar(kt))=1
C            msum(bestvar(kt))=msum(bestvar(kt))+1
          end if
        end do
        do mr=1,mred
          if(iv(mr).eq.1) then
        call permobmr(mr,x,tx,jin,nsample,mdim,iseed)
        call testreebag(x,nsample,mdim,treemap,nodestatus,
     +    xbestsplit,cbestsplit,bestvar,nodeclass,nrnodes,
     +    ndbigtree,cat,nclass,jvr,nodex,maxcat)
            do n=1,nsample
            if(jin(n).eq.0.and.jtr(n).ne.jvr(n)) then
        countimp(jvr(n),n,mr)=countimp(jvr(n),n,mr)+1
        countimp(jtr(n),n,mr)=countimp(jtr(n),n,mr)-1
            end if
            end do
            do n=1,nsample
              x(mr,n)=tx(n)
            end do
          end if
        end do 
      end if 
        
C DO PROXIMITIES

      if(iprox.eq.1) then
        do n=1,near
          do k=1,near
        if(nodex(k).eq.nodex(n)) prox(n,k)=prox(n,k)+dble(1.0)
          end do
        end do 
C Proximities (proxx) for In-bag (top-triangle) and OOB (lower-triangle)
        do n=1,near
          do k=(n+1),near
            if (jin(n).eq.1 .and. jin(k).eq.1) then
        ctprox(n,k)=ctprox(n,k)+1
      if (nodex(n).eq.nodex(k)) mtprox(n,k)=mtprox(n,k)+1
      prox2(n,k)=dble(mtprox(n,k))/dble(ctprox(n,k))
            elseif (jin(n).eq.0 .and. jin(k).eq.0) then 
        ctprox(k,n)=ctprox(k,n)+1
        if (nodex(n).eq.nodex(k)) mtprox(k,n)=mtprox(k,n)+1
      prox2(k,n)=dble(mtprox(k,n))/dble(ctprox(k,n))
            end if
          end do
        end do
      end if
        
C GIVE RUNNING OUTPUT

        ndbtrees(jb) = ndbigtree
        errtrA(jb)=100*errtr
        errtsA(jb)=100*errts
        if (isavef.eq.1) then
          ndbtrees(jb)=ndbigtree
          do i=1,nrnodes
            nodestatusA(jb,i) = nodestatus(i)
            bestvarA(jb,i)    = bestvar(i)
            treemapA(jb,1,i)  = treemap(1,i)
            treemapA(jb,2,i)  = treemap(2,i)
            nodeclassA(jb,i)  = nodeclass(i)
            xbestsplitA(jb,i) = xbestsplit(i)
          end do
        end if
        if (isavef.eq.2) then
          do n=1,ndbigtree
            write(9,'(5i6,f8.2)') nodestatus(n),bestvar(n),
     +        treemap(1,n),treemap(2,n),nodeclass(n),
     +        xbestsplit(n)
          end do
        endif
C <loop-jb>
      end do
      if (isavef.eq.2) close(9)

C ==== OUTPUT OUTPUT OUTPUT ====

C TRUE CLASS

      call zerm(mtab,nclass,nclass)
      do n=1,nsample
        if(jest(n).gt.0) then
          mtab(cl(n),jest(n)) = mtab(cl(n),jest(n))+1
        endif
      end do
      call zerm(mtabts,nclass,nclass)
      do n=1,ntest
        if(jet(n).gt.0) then
          mtabts(clts(n),jet(n))=mtabts(clts(n),jet(n))+1
        endif
      end do

C PROXIMITY DATA 

      if(iprox.eq.1) then
        do n=1,near
          do k=1,near
            prox(n,k)=prox(n,k)/(2*jbt)
            if(k.eq.n) prox(n,k)=1
          end do
        end do
      end if  

C SCALING DATA
        
      if(iscale.eq.1) call myscale(prox,near,mdimsc)

C OUTLIER DATA 

      if(ioutlier.eq.1) then
        call locateout(prox,cl,near,nsample,nclass,ncp,
     +                 iaddcl,outlier,isort,clp)
      end if

C IMP DATA 
        
      if (imp.eq.1) then
        call finishimp(countimp,out,cl,nclass,
     +    mdim,nsample,errimp,diffmarg,cntmarg,
     +    rmargin,counttr,jest,errtr)
      end if

C RERUN SAVED RANDOM FOREST

900   continue
      if(irunf.eq.1) then
      call runforest(mdim,ntest,nclass,maxcat,nrnodes,labelts,
     +    jbt,clts,xts,xbestsplit,pid,countts,treemap,nodestatus,
     +    cat,cbestsplit,nodeclass,jts,jet,bestvar,nodexts,
     +    errtsA,mtabts,trees,ntrees,ndbtrees)
      end if 

999      return
      end 
                
C------ END MAIN ------





C--------------------------------------------------------------
C       SUBROUTINE MAKEA
C--------------------------------------------------------------
      subroutine makea(x,mdim,nsample,cat,isort,a,b,mred)       
      real    x(mdim,nsample),v(nsample)
      integer cat(mdim),isort(nsample),a(mdim,nsample),
     +        b(mdim,nsample)
        
c  submakea constructs the mdim x nsample integer array a.if there are less than
c  32,000 cases, this can be declared integer*2, otherwise integer*4. For each 
c  numerical variable with values x(m,n), n=1,...,nsample, the x-values are sorted
c  from lowest to highest.  Denote these by xs(m,n).  Then a(m,n) is the case 
c  number in which xs(m,n) occurs. The b matrix is also contructed here. 
c  if the mth variable is categorical, then a(m,n) is the category of the nth case 
c  number.  

        do 10 mvar=1,mred

        if (cat(mvar).eq.1) then
                do 20 n=1, nsample
                v(n)=x(mvar,n)
                isort(n)=n
20              continue
                call quicksort(v,isort,1,nsample,nsample)
                
        
        
c  this sorts the v(n) in ascending order. isort(n) is the case number 
c  of that v(n) nth from the lowest (assume the original case numbers 
c  are 1,2,...).  
        
        
                do 35 n=1,nsample-1
                n1=isort(n)
                n2=isort(n+1)
                a(mvar,n)=n1
        if(n.eq.1) b(mvar,n1)=1
                if (v(n).lt.v(n+1)) then
                        b(mvar,n2)=b(mvar,n1)+1
                else
                        b(mvar,n2)=b(mvar,n1)
                endif
35              continue
                a(mvar,nsample)=isort(nsample)

        else

                do 40 ncat=1,nsample
                a(mvar,ncat)=nint(x(mvar,ncat))
40              continue

        endif
10      continue

        do 50 n=1,nsample
        isort(n)=n
50      continue
        end
        
C--------------------------------------------------------------
c       SUBROUTINE PREP
C--------------------------------------------------------------      
        subroutine prep(cl,nsample,nclass,ipi,pi,pid,wtt)
        real pi(nclass),pid(nclass),wtt(nsample)
        integer nc(nclass),cl(nsample)
        
        call zerv(nc,nclass)
        do n=1,nsample
          nc(cl(n))=nc(cl(n))+1
        end do
        
        if (ipi.eq.0) then
        do 20 j=1,nclass
        pi(j)=real(nc(j))/nsample
20      continue
        endif
        
        sp=0
        do j=1,nclass
        sp=sp+pi(j)
        end do
        do j=1,nclass
        pi(j)=pi(j)/sp
        end do
        
        
        do 30 j=1,nclass
        if(nc(j).ge.1) then
        pid(j)=pi(j)*nsample/nc(j)
        else
        pid(j)=0
        end if
        
        do n=1,nsample
        wtt(n)=pid(cl(n))
        end do
        
30      continue
        end

C--------------------------------------------------------------
c   SUBROUTINE MODA
C--------------------------------------------------------------
      subroutine moda(a,nuse,nsample,mdim,cat,maxcat,
     1  ncase,jin,ta)
      integer a(mdim,nsample),cat(mdim),jin(nsample),
     1  ncase(nsample),ta(nsample)
    
      nuse=0
      do n=1,nsample
        if(jin(n).eq.1) nuse=nuse+1
      end do
    
      do m=1,mdim
      k=1
      nt=1
      if(cat(m).eq.1) then
        do n=1,nsample
          if(jin(a(m,k)).eq.1) then
            a(m,nt)=a(m,k)
            k=k+1
          else
            do j=1,nsample-k
              if(jin(a(m,k+j)).eq.1) then
                a(m,nt)=a(m,k+j)
                k=k+j+1
                goto 28
              end if
            end do
          end if
28        continue
          nt=nt+1
          if(nt.gt.nuse) goto 31
        end do
31      continue
      end if
      end do
    
      if(maxcat.gt.1) then
        k=1
        nt=1
        do n=1,nsample
          if(jin(k).eq.1) then
            ncase(nt)=k
            k=k+1
          else
            do j=1,nsample-k
              if(jin(k+j).eq.1) then
                ncase(nt)=k+j
                k=k+j+1
                goto 58
              end if
            end do
          end if
58        continue
          nt=nt+1
          if(nt.gt.nuse) goto 61
        end do
61      continue
        end if
      end
        
        

C--------------------------------------------------------------        
c       SUBROUTINE BUILDTREE
C--------------------------------------------------------------        
      subroutine buildtree(a,b,cl,cat,mdim,nsample,nclass,treemap,
     1  bestvar,bestsplit,bestsplitnext,tgini,nodestatus,nodepop,
     1  nodestart,classpop,tclasspop,ta,nrnodes,idmove,
     1  ndsize,ncase,jin,mtry,iv,nodeclass,ndbigtree,win,
     1  mred,nuse,iseed)
        
c       Buildtree consists of repeated calls to two subroutines, Findbestsplit and Movedata.
c       Findbestsplit does just that--it finds the best split of the current 
c       node.  Movedata moves the data in the split node right and left so that the data
c       corresponding to each child node is contiguous.  
c
c       The buildtree bookkeeping is different from that in Friedman's original CART program. 
c       ncur is the total number of nodes to date.  nodestatus(k)=1 if the kth node has been split.
c       nodestatus(k)=2 if the node exists but has not yet been split, and =-1 of the node is
c       terminal.  A node is terminal if its size is below a threshold value, or if it is all
c       one class, or if all the x-values are equal.  If the current node k is split, then its
c       children are numbered ncur+1 (left), and ncur+2(right), ncur increases to ncur+2 and
c       the next node to be split is numbered k+1.  When no more nodes can be split, buildtree
c       returns to the main program.
C
      integer a(mdim,nsample),cl(nsample),cat(mdim),
     1  treemap(2,nrnodes),bestvar(nrnodes),
     1  bestsplit(nrnodes), nodestatus(nrnodes),ta(nsample),
     1  nodepop(nrnodes),nodestart(nrnodes),
     1  bestsplitnext(nrnodes),idmove(nsample),
     1  ncase(nsample),parent(nrnodes),b(mdim,nsample),
     1  jin(nsample),iv(mred),nodeclass(nrnodes),iseed
        
      real tclasspop(nclass),classpop(nclass,nrnodes),
     1     tclasscat(nclass,32),win(nsample),wr(nclass),wc(nclass),
     +     wl(nclass),tgini(mdim)
        
        call zerv(nodestatus,nrnodes)
        call zerv(nodestart,nrnodes)
        call zerv(nodepop,nrnodes)
        call zermr(classpop,nclass,nrnodes)
        
        do 20 j=1,nclass
        classpop(j,1)=tclasspop(j)
20      continue

        ncur=1
        nodestart(1)=1
        nodepop(1)=nuse
        nodestatus(1)=2
        
c       start main loop

        do 30 kbuild=1,nrnodes

        if (kbuild.gt.ncur) goto 50
        if (nodestatus(kbuild).ne.2) goto 30
        
c initialize for next call to findbestsplit

        ndstart=nodestart(kbuild)
        ndend=ndstart+nodepop(kbuild)-1
        do 40 j=1,nclass
          tclasspop(j)=classpop(j,kbuild)
40      continue
        jstat=0
        call findbestsplit(a,b,cl,mdim,nsample,nclass,cat,ndstart,
     1    ndend,tclasspop,tclasscat,msplit,decsplit,nbest,ncase,
     1    jstat,jin,mtry,iv,win,wr,wc,wl,mred,kbuild,iseed)
        
        if(jstat.eq.1) then
          nodestatus(kbuild)=-1
          goto 30
        else
          bestvar(kbuild)=msplit
          tgini(msplit)=decsplit+tgini(msplit)
          if (cat(msplit).eq.1) then
            bestsplit(kbuild)=a(msplit,nbest)
            bestsplitnext(kbuild)=a(msplit,nbest+1)
          else
            bestsplit(kbuild)=nbest
            bestsplitnext(kbuild)=0
          endif
        endif
        
        call movedata(a,ta,mdim,nsample,ndstart,ndend,idmove,ncase,
     1  msplit,cat,nbest,ndendl)
     
c       leftnode no.= ncur+1, rightnode no. = ncur+2.

        nodepop(ncur+1)=ndendl-ndstart+1
        nodepop(ncur+2)=ndend-ndendl
        nodestart(ncur+1)=ndstart
        nodestart(ncur+2)=ndendl+1

C find class populations in both nodes
        
        do 60 n=ndstart,ndendl
          if(cat(msplit).gt.1)then
            nc=ncase(n)
         else
           nc=ncase(n)
        end if
        j=cl(nc)
        classpop(j,ncur+1)=classpop(j,ncur+1)+win(nc)
60      continue
        do 70 n=ndendl+1,ndend
          if(cat(msplit).gt.1) then
            nc=ncase(n)
          else
            nc=ncase(n)
          end if
          j=cl(nc)
          classpop(j,ncur+2)=classpop(j,ncur+2)+win(nc)
70      continue
C Check on nodestatus
        nodestatus(ncur+1)=2
        nodestatus(ncur+2)=2
        if (nodepop(ncur+1).le.ndsize) nodestatus(ncur+1)=-1
        if (nodepop(ncur+2).le.ndsize) nodestatus(ncur+2)=-1
        popt1=0
        popt2=0
        do j=1,nclass
        popt1=popt1+classpop(j,ncur+1)
        popt2=popt2+classpop(j,ncur+2)
        end do
        
        do j=1,nclass
        if (classpop(j,ncur+1).eq.popt1) nodestatus(ncur+1)=-1
        if (classpop(j,ncur+2).eq.popt2) nodestatus(ncur+2)=-1
        end do

        treemap(1,kbuild)=ncur+1
        treemap(2,kbuild)=ncur+2
        parent(ncur+1)=kbuild
        parent(ncur+2)=kbuild
        nodestatus(kbuild)=1
        ncur=ncur+2
        if (ncur.ge.nrnodes) goto 50
        
30      continue
50      continue

        ndbigtree=nrnodes
        do k=nrnodes,1,-1
        if (nodestatus(k).eq.0) ndbigtree=ndbigtree-1
        if (nodestatus(k).eq.2) nodestatus(k)=-1
        end do

        
        do kn=1,ndbigtree
        if(nodestatus(kn).eq.-1) then
        pp=0
        do j=1,nclass
        if(classpop(j,kn).gt.pp) then
        nodeclass(kn)=j
        pp=classpop(j,kn)
        end if
        end do
        end if
        end do
        
        
        
        end

C--------------------------------------------------------------
c       SUBROUTINE FINDBESTSPLIT
C--------------------------------------------------------------
c       For the best split, msplit is the variable split on. decsplit is the dec. in impurity. 
c       If msplit is numerical, nsplit is the case number of value of msplit split on,
c       and nsplitnext is the case number of the next larger value of msplit.  If msplit is
c       categorical, then nsplit is the coding into an integer of the categories going left.

        subroutine findbestsplit(a,b,cl,mdim,nsample,nclass,cat,
     1  ndstart,ndend,tclasspop,tclasscat,msplit,decsplit,nbest,
     1  ncase,jstat,jin,mtry,iv,win,wr,wc,wl,mred,kbuild,iseed)
        
        integer a(mdim,nsample),cl(nsample),cat(mdim),iv(mred),
     1  ncase(nsample),b(mdim,nsample),jin(nsample),mind(mred),nn
     
        real tclasspop(nclass),tclasscat(nclass,32),win(nsample),
     1  wr(nclass),wc(nclass),wl(nclass)
        
c       compute initial values of numerator and denominator of Gini
        
        pno=0
        pdo=0
        do 10 j=1,nclass
          pno=pno+tclasspop(j)*tclasspop(j)
          pdo=pdo+tclasspop(j)
10      continue
        crit0=pno/pdo
        jstat=0

        do 15 i=1,mred
          mind(i) = i
15      continue

c       start main loop through variables to find best split    
        critmax=-1.0e20
c        zz = ran(iseed)
        nn = mred       
        do 20 mt=1,mtry
200     continue
c       mvar=int(mred*ran(iseed))+1

c******************************************
c  sampling mtry variables w/o replacement.
c******************************************
c         zz = ran(iseed)
         j = int(nn*ran(iseed))+1
         mvar = mind(j)
         mind(j) = mind(nn)
         nn = nn - 1

        if(cat(mvar).eq.1) then
                rrn=pno
                rrd=pdo
                rln=0
                rld=0
                call zervr(wl,nclass)
                do 50 j=1,nclass
                wr(j)=tclasspop(j)
50              continue
                critvar=-1e20
        
        
        
                do 60 nsp=ndstart,ndend-1
                nc=a(mvar,nsp)
            u=win(nc)
                k=cl(nc)
                rln=rln+u*(2*wl(k)+u)
                rrn=rrn+u*(-2*wr(k)+u)
                rld=rld+u
                rrd=rrd-u
                wl(k)=wl(k)+u
                wr(k)=wr(k)-u
        
        
        if (b(mvar,nc).lt.b(mvar,a(mvar,nsp+1))) then
        if(amin1(rrd,rld).gt.1.0e-5) then
                crit=(rln/rld)+(rrn/rrd)
        if (crit.gt.critvar) then
                                nbestvar=nsp
                                critvar=crit
            endif
                end if
                end if
60              continue
65      continue

        if (critvar.gt.critmax) then
                        msplit=mvar
                        nbest=nbestvar
                        critmax=critvar
                 endif
        else

C compute the decrease in impurity given by categorical splits

                lcat=cat(mvar)
                call zermr(tclasscat,nclass,32)
                do 70 nsp=ndstart,ndend
                nc=ncase(nsp)
        l=a(mvar,ncase(nsp))
                tclasscat(cl(nc),l)=tclasscat(cl(nc),l)+win(nc)
70              continue
                nnz=0
                do i=1,lcat
                su=0
                do j=1,nclass
                su=su+tclasscat(j,i)
                end do
                if(su.gt.0) nnz=nnz+1
                end do
                if (nnz.eq.1) then
                critvar=-1.0e25
                else
                call catmax(pno,pdo,tclasscat,tclasspop,nclass,lcat,
     1          nbestvar,critvar)
                end if
                
        
c       this last subroutine returns those categories going left in the best split. 
c       This is coded into a long integer (see under subroutine catmax below for details). 

                
                if (critvar.gt.critmax) then
                        msplit=mvar
                        nbest=nbestvar
                        critmax=critvar
            endif
            endif
20              continue
25      continue                
                decsplit=critmax-crit0
                if (critmax.lt.-1.0e10) jstat=1
        
        end
C--------------------------------------------------------------
C       SUBROUTINE CATMAX
C--------------------------------------------------------------
        subroutine catmax(pno,pdo,tclasscat,tclasspop,nclass,lcat,
     1  ncatsplit,rmaxdec)
        
c       this subroutine finds the best categorical split of a categorical variable
c       with lcat categories, nclass classes and tclasscat(j,l) is the number of cases in
c       class j with category value l. The method used is an exhaustive search over all
c       partitions of the category values.  For the two class problem, there is a
c       faster exact algorithm we will add later.  If lcat.ge.10, the exhaustive search
c       gets slow and there is a faster iterative algorithm we can add later.
        
        parameter(jmax=100)
        real tclasscat(nclass,32),tclasspop(nclass),tmpclass(jmax)
        integer icat(32) 
        
        rmaxdec=-1e20
        do 10 n=1,(2**(lcat-1))-1
        call myunpack(lcat,n,icat)
        call zervr(tmpclass,jmax)
        do 20 l=1,lcat
        if(icat(l).eq.1) then
                do 30 j=1, nclass
                tmpclass(j)=tmpclass(j)+tclasscat(j,l)
30              continue
        endif
20      continue
        pln=0
        pld=0
        do 40 j=1,nclass
        pln=pln+tmpclass(j)*tmpclass(j)
        pld=pld+tmpclass(j)
40      continue
        prn=0
        do 50 j=1,nclass
        tmpclass(j)=tclasspop(j)-tmpclass(j)
        prn=prn+tmpclass(j)*tmpclass(j)
50      continue
        tdec=(pln/pld)+((prn)/(pdo-pld))
        if (tdec.gt.rmaxdec) then
                rmaxdec=tdec
                ncatsplit=n
        endif
10      continue
        
        end

C--------------------------------------------------------------        
c       SUBROUTINE MOVEDATA     
C--------------------------------------------------------------
c       This subroutine is the heart of the buildtree construction. Based on the best split 
c       the data in the part of the a matrix corresponding to the current node is moved to the 
c       left if it belongs to the left child and right if it belongs to the right child.

      subroutine movedata(a,ta,mdim,nsample,ndstart,ndend,idmove,
     1        ncase,msplit,cat,nbest,ndendl)
      integer a(mdim,nsample),ta(nsample),idmove(nsample),
     1        ncase(nsample),cat(mdim),icat(32)
        
c       compute idmove=indicator of case nos. going left

        if (cat(msplit).eq.1) then
                do 10 nsp=ndstart,nbest
                nc=a(msplit,nsp)
                idmove(nc)=1
10              continue
                do 20 nsp=nbest+1, ndend
                nc=a(msplit,nsp)
                idmove(nc)=0
20              continue
                ndendl=nbest
        else
                ndendl=ndstart-1
                l=cat(msplit)
                call myunpack(l,nbest,icat)
                do 30 nsp=ndstart,ndend
        nc=ncase(nsp)
                if (icat(a(msplit,nc)).eq.1) then
                        idmove(nc)=1
                        ndendl=ndendl+1
                else
                        idmove(nc)=0
                endif
30              continue
        endif
        
c       shift case. nos. right and left for numerical variables.        
        
        do 40 msh=1,mdim
        if (cat(msh).eq.1) then
                k=ndstart-1
                do 50 n=ndstart,ndend
                ih=a(msh,n)
                if (idmove(ih).eq.1) then
                        k=k+1
                        ta(k)=a(msh,n)
                endif
50      continue
        do 60 n=ndstart,ndend
        ih=a(msh,n)
        if (idmove(ih).eq.0) then 
                k=k+1
                ta(k)=a(msh,n)
        endif
60      continue

        do 70 k=ndstart,ndend
        a(msh,k)=ta(k)
70      continue
        endif

40      continue
        ndo=0
        if(ndo.eq.1) then
        do 140 msh=1,mdim
        if (cat(msh).gt.1) then
                k=ndstart-1
                do 150 n=ndstart,ndend
                ih=ncase(n)
                if (idmove(ih).eq.1) then
                        k=k+1
                        ta(k)=a(msh,ih)
                endif
150      continue
        do 160 n=ndstart,ndend
        ih=ncase(n)
        if (idmove(ih).eq.0) then 
                k=k+1
                ta(k)=a(msh,ih)
        endif
160      continue

        do 170 k=ndstart,ndend
        a(msh,k)=ta(k)
170      continue
        endif

140      continue
      end if

    

c       compute case nos. for right and left nodes.
        
        if (cat(msplit).eq.1) then
                do 80 n=ndstart,ndend
                ncase(n)=a(msplit,n)
80              continue
        else
                k=ndstart-1
                do 90 n=ndstart, ndend
                if (idmove(ncase(n)).eq.1) then
                        k=k+1
                        ta(k)=ncase(n)
                endif
90              continue
                do 100 n=ndstart,ndend
                if (idmove(ncase(n)).eq.0) then
                        k=k+1
                        ta(k)=ncase(n)
                endif
100             continue
                do 110 k=ndstart,ndend
                ncase(k)=ta(k)
110             continue
        endif
                
        end
        
C--------------------------------------------------------------
c       SUBROUTINE XTRANSLATE
C--------------------------------------------------------------
c       this subroutine takes the splits on numerical variables and translates them
c       back into x-values.  It also unpacks each categorical split into a 32-dimensional 
c       vector with components of zero or one--a one indicates that the corresponding
c       category goes left in the split.

        subroutine xtranslate(x,mdim,nrnodes,nsample,bestvar,
     1  bestsplit,bestsplitnext,xbestsplit,nodestatus,cat,
     1  ndbigtree)
    
        integer cat(mdim),bestvar(nrnodes),bestsplitnext(nrnodes),
     1  nodestatus(nrnodes),bestsplit(nrnodes)
        real x(mdim,nsample),xbestsplit(nrnodes)

        do 10 k=1,ndbigtree
        if (nodestatus(k).eq.1) then
                m=bestvar(k)
                if (cat(m).eq.1) then
                        xbestsplit(k)=(x(m,bestsplit(k))+
     1                                 x(m,bestsplitnext(k)))/2
            else
            xbestsplit(k)=real(bestsplit(k))
                endif
        endif
10      continue
        end

C-----------------------------------------------------------------
C       SUBROUTINE TESTREEBAG
C-----------------------------------------------------------------
      subroutine testreebag(xts,nts,mdim,treemap,nodestatus,
     +  xbestsplit,cbestsplit,bestvar,nodeclass,nrnodes,
     +  ndbigtree,cat,nclass,jts,nodex,maxcat)
        
        real xts(mdim,nts),xbestsplit(nrnodes)
    
        integer treemap(2,nrnodes),bestvar(nrnodes),
     +  nodeclass(nrnodes),cat(mdim),nodestatus(nrnodes),jts(nts),
     +  nodex(nts),cbestsplit(maxcat,nrnodes),icat(32)

      call zerv(jts,nts)
      call zerv(nodex,nts)
      
C
C      goto 999
C
C iaddcl BOMB here

      do k=1,ndbigtree
      if(bestvar(k).gt.0) l=cat(bestvar(k))
      if(l.gt.1) then
        ncat=nint(xbestsplit(k))
        call myunpack(l,ncat,icat)
        do j=1,l
          cbestsplit(j,k)=icat(j)
        end do
      end if
      end do
    
      do n=1,nts
        kt=1
        do k=1,ndbigtree
        if (nodestatus(kt).eq.-1) then
            jts(n)=nodeclass(kt)
            nodex(n)=kt
            goto 100
          end if
          m=bestvar(kt)
          if (cat(m).eq.1) then
            if (xts(m,n).le.xbestsplit(kt)) then 
              kt=treemap(1,kt)
          else
              kt=treemap(2,kt)
          endif 
          else
            jcat=nint(xts(m,n))
            if (cbestsplit(jcat,kt).eq.1) then
              kt=treemap(1,kt)
            else
              kt=treemap(2,kt)
            endif
          endif
        end do
100     continue
C<n>
        end do
999     return
        end
        
C-------------------------------------------------------------------
C       SUBROUTINE COMPTSERR
C-------------------------------------------------------------------
      subroutine comptserr(countts,jts,clts,jet,ntest,nclass,errts,
     +                     pid,labelts)
        integer jts(ntest),clts(ntest),jet(ntest)
        real countts(nclass,ntest),pid(nclass)
        
        rmissts=0
      do n=1,ntest
        countts(jts(n),n)=countts(jts(n),n)+1
      end do
      if(labelts.eq.1) then
        do n=1,ntest
          cmax=0
          do j=1,nclass
            if (countts(j,n).gt.cmax) then
              jet(n)=j
              cmax=countts(j,n)
            end if
          end do
          if (jet(n).ne.clts(n)) rmissts=rmissts+1
        end do
        errts=real(rmissts)/ntest
      end if
      end

C-------------------------------------------------------------------
C   SUBROUTINE UNIF & FUNCTION NSELECT
C-------------------------------------------------------------------
      subroutine createclass(x,cl,ns,nsample,mdim,
     +                       sm,ndble,iaddcl,iseed)
      real    x(mdim,nsample),tx(ns),sm(ns),p(ns)
        integer ndble(ns),cl(nsample)
    
      do n=1,ns
      cl(n)=1
      end do
      do n=ns+1,nsample
      cl(n)=2
      end do
     
      if(iaddcl.eq.1) then
       do n=ns+1,nsample
        do m=1,mdim
          k=int(ran(iseed)*ns)+1
          x(m,n)=x(m,k)
        end do
      end do
      end if
    
      if(iaddcl.eq.2) then
      do m=1,mdim
        do n=1,ns
          tx(n)=x(m,n)
        end do
        call quicksort(tx,ndble,1,ns,ns)
        do k=2,ns-1
          p(k)=.5*(tx(k+1)-tx(k-1))/(tx(ns)-tx(1))
        end do
        p(ns)=.5*(tx(2)-tx(1))/(tx(ns)-tx(1))
        sm(1)=p(1)
        do k=2,ns
          sm(k)=sm(k-1)+p(k)
        end do
        do n=ns+1,nsample
          k=nselect(ns,sm,iseed)
          x(m,n)=tx(k)
        end do
      end do 
      end if 
      end

C----------
C NSELECT
C----------
      integer function nselect(ns,sm,iseed)
      real sm(ns)
      u=ran(iseed)
      kp=ns
      km=0
      do j=1,1000
      kt=nint(real(kp+km)/2)
      if (u.lt.sm(kt)) then
      kp=kt
      else
      km=kt
      end if
      if (kp-km.eq.1) then
      nselect=kp
      goto 69
      end if
      end do
69    return
      end
    
C        
C SUBROUTINE OOB
C        
      subroutine oob(nsample,nclass,jin,cl,jtr,jerr,counttr,out,
     +        errtr,errc,rmargin,jest,wtt)
      integer jin(nsample),cl(nsample),jtr(nsample),out(nsample),
     +        jerr(nsample),jest(nsample),counttr(nclass,nsample)
      real    rmargin(nsample),q(nclass,nsample),wtt(nsample)

        
        inderr=1
        if(inderr.eq.1) then
        outc=0
        rmissc=0
        do n=1,nsample
        if(jin(n).eq.0) then
        outc=outc+1.
      if(jtr(n).ne.cl(n)) rmissc=rmissc+1.
        end if
        end do
        errc=100*rmissc/outc
      end if
        
        call zerv(jerr,nsample)
        
        rmiss=0
      do n=1,nsample
      if(out(n).gt.0) then
      smax=0
        smaxtr=0
        do j=1,nclass
      q(j,n)=real(counttr(j,n))/out(n)
        if(j.ne.cl(n)) smax=amax1(q(j,n),smax)
        if (q(j,n).gt.smaxtr) then
        smaxtr=q(j,n)
        jest(n)=j
        end if
        end do
        if(jest(n).ne.cl(n)) then
        rmiss=rmiss+1.0
        jerr(n)=1
        end if
        pth=q(cl(n),n)
        rmargin(n)=pth-smax
      end if
        end do
        errtr=rmiss/nsample
      end
C--------------------------------------------------------------
C SUBROUTINE PERMOBAR
C--------------------------------------------------------------
      subroutine permobmr(mr,x,tx,jin,nsample,mdim,iseed)
      dimension x(mdim,nsample), tp(nsample),tx(nsample),jin(nsample)
        kout=0
        call zervr(tp,nsample)
        do n=1,nsample
        if(jin(n).eq.0) then
        kout=kout+1
        tp(kout)=x(mr,n)
        end if
        end do 
        call perm1(kout,nsample,tp,iseed)
        iout=0
        do n=1,nsample
        tx(n)=x(mr,n)
        if(jin(n).eq.0) then
        iout=iout+1
        x(mr,n)=tp(iout)
        end if
        end do
        end
        

C--------------------------------------------------------------
C SUBROUTINE FINISHIMP
C--------------------------------------------------------------
      subroutine finishimp(countimp,out,cl,nclass,mdim,
     +    nsample,errimp,diffmarg,cntmarg,
     +    rmargin,counttr,jest,errtr)
     
      integer cl(nsample),countimp(nclass,nsample,mdim),
     1  counttr(nclass,nsample),out(nsample),jest(nsample)
     
      real errimp(mdim),rimpmarg(mdim,nsample),rmissimp(mdim),
     +     diffmarg(mdim),cntmarg(mdim),rmargin(nsample),
     +     graph(nclass,nsample,mdim)
     
        call zervr(rmissimp,mdim)
      call zervr(errimp,mdim)
    
      do m1=1,mdim
      do n=1,nsample
        if(out(n).ge.1) then
        lmax=0
        kmax=0
        do j=1,nclass
      ks=countimp(j,n,m1)+counttr(j,n)
        if (ks.gt.kmax) then
        kmax=ks
        imax=j
        end if
      if(j.ne.cl(n)) lmax=max0(lmax,ks)
      if(j.eq.cl(n)) ks0=ks
        end do
      if(imax.ne.cl(n)) rmissimp(m1)=rmissimp(m1)+1
        rimpmarg(m1,n)=real(ks0-lmax)/out(n)
        end if
        end do 
        end do 
        do m1=1,mdim
      errimp(m1)=rmissimp(m1)/nsample
      errimp(m1)=100*(errimp(m1)-errtr)/errtr
      errimp(m1)=amax1(0.0,errimp(m1))
      end do
        do m=1,mdim
        diffmarg(m)=0
        cntmarg(m)=0
        do n=1,nsample
        diffmarg(m)=diffmarg(m)+(rmargin(n)-rimpmarg(m,n))
        if(rimpmarg(m,n).lt.rmargin(n)) cntmarg(m)=cntmarg(m)+1 
        if(rimpmarg(m,n).gt.rmargin(n)) cntmarg(m)=cntmarg(m)-1
        end do
        diffmarg(m)=100*diffmarg(m)/nsample
      cntmarg(m)=cntmarg(m)/nsample
        end do
    
       
C      do m=1,mdim
C   do n=1,nsample
C   do j=1,nclass
C   graph(j,n,m)=real(counttr(j,n)-countimp(j,n,m))/(out(n)+.01)
C   end do 
C   end do
C   end do
    
      end

C--------------------------------------------------------------
C   SUBROUTINE LOCATEOUT
C--------------------------------------------------------------
       subroutine locateout(prox,cl,near,nsample,nclass,ncp,
     +        iaddcl,outlier,isort,clp)
       real*8  prox(near,near)
       real    outlier(near),tout(near)
       integer ncp(near),cl(nsample),isort(nsample),ntt(0:30),
     +        clp(near)
    
      call zervr(outlier,near)
      if (iaddcl.eq.1) then
      jpclass=1
      else
      jpclass=nclass
      end if
      ntt(0)=0
      nt=0
      do jp=1,jpclass
      
      do n=1,near
      if(cl(n).eq.jp) then
      nt=nt+1
      ncp(nt)=n
      end if
      end do
      ntt(jp)=nt
      n1=ntt(jp-1)+1
      n2=ntt(jp)
      
      do i=n1,n2
      outlier(i)=0
      do j=n1,n2
      if(j.ne.i) then
        outlier(i)=outlier(i)+(real(prox(ncp(i),ncp(j))))**2
      end if
      end do
      end do
      
      do i=n1,n2
      outlier(i)=1.0/outlier(i)
      tout(i)=outlier(i)
      clp(i)=jp
      end do
      
      call quicksort(tout,isort,n1,n2,nsample)
      rmed=tout((n1+n2)/2)
      dev=0
      do i=n1,n2
      dev=dev+abs(tout(i)-rmed)
      end do
      dev=dev/(n2-n1+1)
      do i=n1,n2
      outlier(i)=(outlier(i)-rmed)/dev
      outlier(i)=amax1(outlier(i),0.0)
      end do
      
      end do
      
      end
    
    
     
C----------------------------------------------------
C SUNROUTINE MYSCALE
C----------------------------------------------------
      subroutine myscale(s,ns,nn)
      implicit double precision (a-h,o-z)
      double precision  s(ns,ns),y(ns),u(ns),dl(ns),
     +       xsc(ns,nn),red(ns) 
    
      do j=1,ns
        red(j)=0
        do i=1,ns
          red(j)=red(j)+s(i,j)
        end do
        red(j)=red(j)/ns
      end do
  
      sred=0
      do j=1,ns
        sred=sred+red(j)
      end do
      sred=sred/ns
      do i=1,ns
        do j=1,ns
          s(i,j)=(s(i,j)-red(j)-red(i)+sred)/2
        end do
      end do
C
      open(1,file='iscale-out.txt',status='new')


      do it=1,nn
      do n=1,ns
        if(mod(n,2).eq.0) then
          y(n)=1
        else
          y(n)=-1
        end if
      end do

      do jit=1,1000
        y2=0
        do n=1,ns
          y2=y2+y(n)**2
        end do
C
       write(1,*) it,jit,y2

        y2=dsqrt(y2)
        do n=1,ns
          u(n)=y(n)/y2
        end do
        do n=1,ns
          y(n)=0
          do k=1,ns
            y(n)=y(n)+s(n,k)*u(k)
          end do
        end do
        ra=0
        do n=1,ns
         ra=ra+y(n)*u(n)
        end do 
        ynorm=0
        do n=1,ns
          ynorm=ynorm+(y(n)-ra*u(n))**2
        end do
        if(ynorm.lt.1.0e-7*ra)then
          do n=1,ns
            xsc(n,it)=dsqrt(ra)*u(n)
          end do
          dl(it)=ra
      goto 34
        end if
      end do

34      continue
      do n=1,ns
        do k=1,ns
          s(n,k)=s(n,k)-ra*u(n)*u(k)
        end do
      end do
      end do 
C
      close(1)

999      return
      end
    
C---------------------------------------------------------------
C   SUBROUTINE RUNFOREST
C---------------------------------------------------------------
      subroutine runforest(mdim,ntest,nclass,maxcat,nrnodes,
     1 labelts,jbt,clts,xts,xbestsplit,pid,countts,treemap,
     1 nodestatus,cat,cbestsplit,nodeclass,jts,jet,bestvar,
     1 nodexts,errtsA,mtabts,trees,ntrees,ndbtrees)
    
       integer treemap(2,nrnodes),nodestatus(nrnodes),
     1 cat(mdim),cbestsplit(maxcat,nrnodes),nodeclass(nrnodes),
     1 bestvar(nrnodes),jts(ntest),clts(ntest),jet(ntest),
     1 nodexts(ntest),nbuffer,
     + ntrees,mtabts(nclass,nclass),ndbtrees(jbt)

      real xts(mdim,ntest),xbestsplit(nrnodes),pid(nclass),
     1 countts(nclass,ntest),errtsA(jbt),trees(6,ntrees)
     
      call zermr(countts,nclass,ntest)

          nbuffer=0
      do jb=1,jbt
          ndbigtree=ndbtrees(jb)
        do n=1,ndbigtree
          nodestatus(n)=int(trees(1,nbuffer+n))
          bestvar(n)   =int(trees(2,nbuffer+n))
          treemap(1,n) =int(trees(3,nbuffer+n))
          treemap(2,n) =int(trees(4,nbuffer+n))
          nodeclass(n) =int(trees(5,nbuffer+n))
          xbestsplit(n)=trees(6,nbuffer+n)
        end do
        do n=(ndbigtree+1),nrnodes
          nodestatus(n)=0
          bestvar(n)   =0
          treemap(1,n) =0
          treemap(2,n) =0
          nodeclass(n) =0
          xbestsplit(n)=0
        end do
        nbuffer=nbuffer+ndbigtree

      call testreebag(xts,ntest,mdim,treemap,nodestatus,
     +    xbestsplit,cbestsplit,bestvar,nodeclass,nrnodes,
     +    ndbigtree,cat,nclass,jts,nodexts,maxcat)
        
          call comptserr(countts,jts,clts,jet,ntest,nclass,
     +    errts,pid,labelts)
        
C OUTPUT        
        call zerm(mtabts,nclass,nclass)
        do n=1,ntest
          if(jet(n).gt.0) then
        mtabts(clts(n),jet(n))=mtabts(clts(n),jet(n))+1
          endif
        end do
C
        errtsA(jb)=errts
C<jb>     
        end do  
      end

C--------------------------------------------------------------
C SUBROUTINE PCOMP
C--------------------------------------------------------------
      subroutine pcomp(x,xts,mdim,nsample,ntest,inorm,mdimpc)
      real x(mdim,nsample),xts(mdim,ntest),
     +     xor(mdimpc,nsample),xorts(mdimpc,ntest)
      double precision cv(mdim,mdim),y(mdim),u(mdim),ra,y2,ynorm
    
      do m=1,mdim
      av=0
      sq=0
      xmax=0
      do n=1,nsample
        sq=sq+((n-1)*(x(m,n)-av)**2)/n
        av=((n-1)*av+x(m,n))/n
        xmax=amax1(xmax,abs(x(m,n)))
      end do
      sdt=sqrt(sq/nsample)
      if(sdt.le..00001*xmax)then
        do n=1,nsample
          x(m,n)=0
        end do
        do n=1,ntest 
          xts(m,n)=0
        end do
      else
        if(inorm.eq.0) sdt=1
        do n=1,nsample
          x(m,n)=(x(m,n)-av)/sdt
        end do
        do n=1,ntest
          xts(m,n)=(xts(m,n)-av)/sdt
        end do
      end if
      end do
    
      do m=1,mdim
      do k=1,mdim
        xx=0
        do n=1,nsample
          xx=xx+x(m,n)*x(k,n)
        end do
        cv(m,k)=dble(xx)
      end do
      end do
      do it=1,mdimpc
      do n=1,mdim
        if(mod(n,2).eq.0) then
          y(n)=1
        else
          y(n)=-1
        end if
      end do
      do jit=1,1000
        y2=0
        do n=1,mdim
          y2=y2+y(n)**2
        end do
        y2=dsqrt(y2)
        do n=1,mdim
          u(n)=y(n)/y2
        end do
        do n=1,mdim
          y(n)=0
          do k=1,mdim
            y(n)=y(n)+cv(n,k)*u(k)
          end do
        end do
        ra=0
        do n=1,mdim
          ra=ra+y(n)*u(n)
        end do 
        ynorm=0
        do n=1,mdim
          ynorm=ynorm+(y(n)-ra*u(n))**2
        end do
        if(ynorm.lt.1.0e-6*ra) goto 17
      end do
17    continue
      do n=1,nsample
        xor(it,n)=0
        do m=1,mdim
        xor(it,n)=xor(it,n)+dble(u(m))*x(m,n)
        end do
      end do
      do n=1,ntest
        xorts(it,n)=0
        do m=1,mdim
      xorts(it,n)=xorts(it,n)+real(u(m))*xts(m,n)
        end do
      end do
CCC   write(*,'(2i6,f12.3)') it,jit,ra
      do m=1,mdim
        do k=1,mdim
          cv(m,k)=cv(m,k)-ra*u(m)*u(k)
        end do
      end do
      end do 
      do m=1,mdimpc
      do n=1,nsample
        x(m,n)=xor(m,n)
      end do
      do n=1,ntest
        xts(m,n)=xorts(m,n)
      end do
      end do
      end
C<sub pcomp>    
      
        
C--------------------------------------------------------------
C       SUBROUTINE QUICKSORT
C--------------------------------------------------------------
        subroutine quicksort (v,iperm,ii,jj,kk)
c
c     puts into iperm the permutation vector which sorts v into
c     increasing order.  only elementest from ii to jj are considered.
c     array iu(k) and array il(k) permit sorting up to 2**(k+1)-1 elements
c
c     this is a modification of acm algorithm #347 by r. c. singleton,
c     which is a modified hoare quicksort.
c
      dimension iperm(kk),v(kk),iu(32),il(32)
      integer t,tt
     
      m=1
      i=ii
      j=jj
 10   if (i.ge.j) go to 80
 20   k=i
      ij=(j+i)/2
      t=iperm(ij)
      vt=v(ij)
      if (v(i).le.vt) go to 30
      iperm(ij)=iperm(i)
      iperm(i)=t
      t=iperm(ij)
      v(ij)=v(i)
      v(i)=vt
      vt=v(ij)
 30   l=j
      if (v(j).ge.vt) go to 50
      iperm(ij)=iperm(j)
      iperm(j)=t
      t=iperm(ij)
      v(ij)=v(j)
      v(j)=vt
      vt=v(ij)
      if (v(i).le.vt) go to 50
      iperm(ij)=iperm(i)
      iperm(i)=t
      t=iperm(ij)
      v(ij)=v(i)
      v(i)=vt
      vt=v(ij)
      go to 50
 40   iperm(l)=iperm(k)
      iperm(k)=tt
      v(l)=v(k)
      v(k)=vtt
 50   l=l-1
      if (v(l).gt.vt) go to 50
      tt=iperm(l)
      vtt=v(l)
 60   k=k+1
      if (v(k).lt.vt) go to 60
      if (k.le.l) go to 40
      if (l-i.le.j-k) go to 70
      il(m)=i
      iu(m)=l
      i=k
      m=m+1
      go to 90
 70   il(m)=k
      iu(m)=j
      j=l
      m=m+1
      go to 90
 80   m=m-1
      if (m.eq.0) return
      i=il(m)
      j=iu(m)
 90   if (j-i.gt.10) go to 20
      if (i.eq.ii) go to 10
      i=i-1
 100  i=i+1
      if (i.eq.j) go to 80
      t=iperm(i+1)
      vt=v(i+1)
      if (v(i).le.vt) go to 100
      k=i
 110  iperm(k+1)=iperm(k)
      v(k+1)=v(k)
      k=k-1
      if (vt.lt.v(k)) go to 110
      iperm(k+1)=t
      v(k+1)=vt
      go to 100
      end

c       MISCELLANOUS SMALL SUBROUTINES


C--------------------------------------------------------------
C SUBROUTINE MYUNPACK
C--------------------------------------------------------------
        subroutine myunpack(l,npack,icat)
c  Unpack is a long integer.  The sub. returns icat, an integer of zeroes and
c  ones corresponding to the coefficients in the binary expansion of npack.
        integer icat(32),npack
        do j=1,32
        icat(j)=0
        end do
        n=npack
        icat(1)=mod(n,2)
        do 10 k=2,l
        n=(n-icat(k-1))/2
        icat(k)=mod(n,2)
10      continue
        end
C
C
C       
        subroutine zerv(ix,m1)
        integer ix(m1)
        do 10 n=1,m1
          ix(n)=0
10      continue
        end
        
        subroutine zervr(rx,m1)
        real rx(m1)
        do 10 n=1,m1
          rx(n)=0
10      continue
        end
        
        subroutine zerm(mx,m1,m2)
        integer mx(m1,m2)
        do 10 i=1,m1
        do 20 j=1,m2
        mx(i,j)=0
20      continue
10      continue
        end
        
        subroutine zermr(rx,m1,m2)
        real rx(m1,m2)
        do 10 i=1,m1
        do 20 j=1,m2
        rx(i,j)=0
20      continue
10      continue
        end
        
      subroutine zermd(dx,m1,m2)
        double precision dx(m1,m2)
        do 10 i=1,m1
        do 20 j=1,m2
        dx(i,j)=0.0d0
20      continue
10      continue
        end

        subroutine eqm(j,k,m,n)
        integer j(m,n),k(m,n)
        do m1=1,m
        do n1=1,n
        j(m1,n1)=k(m1,n1)
        end do
        end do
        end
        
        
                  
        real function rrand(j)
        double precision dseed,u
        save dseed
        data dseed /17395/
        call lrnd(dseed,u)
        rrand=real(u)
        end
        
        
        subroutine lrnd(dseed,u)
        double precision dseed, d31m1,u
        data d31m1 /2147483647/
        dseed=dmod(16087*dseed,d31m1)
        u=dseed/d31m1
        return
        end
        
        
        
        subroutine perm1(np,ns,tp,iseed)
        real tp(ns), rnd
        j=np
11      rnd = ran(iseed)
        k=int(j*rnd)+1
        tx=tp(j)
        tp(j)=tp(k)
        tp(k)=tx
        j=j-1
        if(j.gt.1) go to 11
        end

     
