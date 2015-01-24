C
C Matlab Gateway Function for randomForest algorithm for 
C regression based on Breiman and Cutler's original 
C Fortran code version 3.3
C
C By Ting Wang,  Merck & Co. 
C Last Date : May 30, 2003
C             -- Sampling w/o replacement
C             -- Prediction(TS) for each Tree
C-----------------------------------------------------------------
      subroutine mexFunction(nlhs, plhs, nrhs, prhs)
      integer plhs(*), prhs(*)
      integer mxGetPr, mxGetM, mxGetN, mxCreateDoubleMatrix

      integer pPr,xPr,yPr,catPr,xtsPr,ytsPr,treesPr,ndbtreesPr
      integer yptrPr,ypredPr,errtsAPr,errbAPr,
     +        tginiPr,errimpPr,predimpPr,
     +        nodestatusAPr,upperAPr,treemapAPr,
     +        avnodeAPr,mbestAPr,ypredAPr 
      integer param(14)
      integer mdim,nsample,ntest,nthsize,nrnodes,
     +        jbt,mtry,imp,nimp,mimp,th,
     +        iseed,irunf,isavef,ntrees
C
C temp matrix
      integer avnodePr,bestcritPr,rsnodecostPr,upperPr,xbPr,
     +        xtPr,ybPr,ytrPr,ytreePr,isortPr,jinPr,mbestPr, 
     +        ncasePr,nodepopPr,nodestartPr,nodestatusPr,
     +        noutPr,parentPr,treemapPr
      integer avnode,bestcrit,rsnodecost,upper,xb,
     +        xt,yb,ytr,ytree,isort,jin,mbest,
     +        ncase,nodepop,nodestart,nodestatus,
     +        nout,parent,treemap

       pPr    = mxGetPr(prhs(1))
       xPr    = mxGetPr(prhs(2))
       yPr    = mxGetPr(prhs(3))
       catPr  = mxGetPr(prhs(4))
       xtsPr  = mxGetPr(prhs(5))
       ytsPr  = mxGetPr(prhs(6))
       treesPr    = mxGetPr(prhs(7))
       ndbtreesPr = mxGetPr(prhs(8))

      call mxCopyPtrToInteger4(pPr,param,14)
        mdim    = param(1)
        nsample = param(2)
        ntest   = param(3)
        jbt     = param(4)
        mtry    = param(5)
        nthsize = param(6)
        nimp    = param(7)
        mimp    = param(8)
        nrnodes = param(9)
        imp     = param(10)
        iseed   = param(11)
        irunf   = param(12)
        isavef  = param(13)
        ntrees  = param(14)

      call Create2Sgl(yptrPr,        plhs(1),1,nsample)
      call Create2Sgl(ypredPr,       plhs(2),1,ntest)
      call Create2Sgl(errtsAPr,      plhs(3),1,jbt)
      call Create2Sgl(errbAPr,       plhs(4),1,jbt)
      call Create2Sgl(tginiPr,       plhs(5),1,mdim)
      call Create2Sgl(errimpPr,      plhs(6),1,mimp)
      call Create2Sgl(predimpPr,     plhs(7),nimp,mimp)
      call Create2Int(nodestatusAPr, plhs(8),jbt,nrnodes)
      call Create2Sgl(upperAPr,      plhs(9),jbt,nrnodes)
      call Create3Int(treemapAPr,    plhs(10),jbt,2,nrnodes)
      call Create2Sgl(avnodeAPr,     plhs(11),jbt,nrnodes)
      call Create2Int(mbestAPr,      plhs(12),jbt,nrnodes)
      call Create2Sgl(ypredAPr,      plhs(13),jbt,ntest)
C
C Allocate memory for temp matrix in Fortran
      call Create2Sgl(avnodePr,      avnode,1,nrnodes)
	call Create2Sgl(bestcritPr,    bestcrit,1,nrnodes)
	call Create2Sgl(rsnodecostPr,  rsnodecost,1,nrnodes)
	call Create2Sgl(upperPr,       upper,1,nrnodes)
	call Create2Sgl(xbPr,          xb,mdim,nsample)
	call Create2Sgl(xtPr,          xt,1,nsample)	
	call Create2Sgl(ybPr,          yb,1,nsample)
	call Create2Sgl(ytrPr,         ytr,1,nsample)
	call Create2Sgl(ytreePr,       ytree,1,ntest)
      call Create2Int(isortPr,       isort,1,nsample)
      call Create2Int(jinPr,         jin,1,nsample)
	call Create2Int(mbestPr,       mbest,1,nrnodes)
	call Create2Int(ncasePr,       ncase,1,nsample)
	call Create2Int(nodepopPr,     nodepop,1,nrnodes)
	call Create2Int(nodestartPr,   nodestart,1,nrnodes)
	call Create2Int(nodestatusPr,  nodestatus,1,nrnodes)
	call Create2Int(noutPr,        nout,1,nsample)
	call Create2Int(parentPr,      parent,1,nrnodes)
	call Create2Int(treemapPr,     treemap,2,nrnodes)

      call rfr(mdim,nsample,ntest,nthsize,nrnodes,
     +  jbt,mtry,imp,nimp,mimp,
     +  iseed,irunf,isavef,ntrees,
     +  %val(xPr),%val(yPr),%val(catPr),
     +  %val(xtsPr),%val(ytsPr),
     +  %val(treesPr),%val(ndbtreesPr),
     +  %val(yptrPr),%val(ypredPr),
     +  %val(errtsAPr),%val(errbAPr),
     +  %val(tginiPr),%val(errimpPr),%val(predimpPr),
     +  %val(nodestatusAPr),%val(upperAPr),%val(treemapAPr),
     +  %val(avnodeAPr),%val(mbestAPr),%val(ypredAPr),
     +  %val(avnodePr),%val(bestcritPr),%val(rsnodecostPr),
     +  %val(upperPr),%val(xbPr),%val(xtPr),%val(ybPr),%val(ytrPr),
     +  %val(ytreePr),%val(isortPr),%val(jinPr),%val(mbestPr),
     +  %val(ncasePr),%val(nodepopPr),%val(nodestartPr),
     +  %val(nodestatusPr),%val(noutPr),%val(parentPr),
     +  %val(treemapPr)   )

      return
      end

C Functions to dynamically allocate memory 

      subroutine Create2Int(Pr,Id,m,n)
        integer Pr,Id,m,n,d(2)
        d(1)=m
        d(2)=n
        Id=mxCreateNumericArray(2,d,
     +       mxClassIDFromClassName('int32'),0)
        Pr=mxGetPr(Id)
      return
      end

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

      subroutine Create2Sgl(Pr,Id,m,n)
        integer Pr,Id,m,n,d(2)
        d(1)=m
        d(2)=n
        Id=mxCreateNumericArray(2,d,
     +       mxClassIDFromClassName('single'),0)
        Pr=mxGetPr(Id)
      return
      end

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
C
C RANDOM FOREST Regression Main Subroutine
C
C----------------------------------------------------------------
      subroutine rfr(mdim,nsample,ntest,nthsize,nrnodes,
     +  jbt,mtry,imp,nimp,mimp,
     +  iseed,irunf,isavef,ntrees,
     +  x,y,cat,xts,yts,trees,ndbtrees,
     +  yptr,ypred,errtsA,errbA,
     +  tgini,errimp,predimp,
     +  nodestatusA,upperA,treemapA,
     +  avnodeA,mbestA,ypredA,
     +  avnode,bestcrit,rsnodecost,
     +  upper,xb,xt,yb,ytr,
     +  ytree,isort,jin,mbest,
     +  ncase,nodepop,nodestart,
     +  nodestatus,nout,parent,
     +  treemap ) 

      implicit real(a-h,o-z)

      integer mdim,nsample,ntest,nthsize,nrnodes,
     +  jbt,mtry,imp,nimp,mimp,th,
     +  iseed,irunf,isavef,ntrees

	real x(mdim,nsample),y(nsample),yb(nsample),
     +  rsnodecost(nrnodes),
     +  bestcrit(nrnodes),v(nsample),
     +  ut(nsample),xt(nsample),xb(mdim,nsample),
     +  ytr(nsample),yl(nsample),
     +  avnode(nrnodes),utr(nsample),za(mdim),
     +  upper(nrnodes),ytree(ntest),
     +  xts(mdim,ntest),yts(ntest),
     +  yptr(nsample),ypred(ntest),ypredA(jbt,ntest),
     +  errtsA(jbt),errbA(jbt),
     +  tgini(mdim),errimp(mimp),predimp(nimp,mimp),
     +  upperA(jbt,nrnodes),avnodeA(jbt,nrnodes),
     +  trees(6,ntrees)
     	
	integer jdex(nsample),treemap(2,nrnodes),
     +  nodestatus(nrnodes),nodepop(nrnodes),
     +  ip(mdim),parent(nrnodes),
     +  cat(mdim),nout(nsample),jin(nsample),
     +  isort(nsample),nodestart(nrnodes),ncase(nsample),
     +  nbrterm(nrnodes),mbest(nrnodes),incl(mdim),
     +  nodestatusA(jbt,nrnodes),
     +  treemapA(jbt,2,nrnodes),mbestA(jbt,nrnodes),
     +  ndbtrees(jbt)

C----+|----------------------------------------------------------

	call zervr(yptr,nsample)
	call zerv(nout,nsample)

      if (irunf.eq.1) goto 900

        if (isavef.eq.2) then
          open(9,file='rforest.txt',status='new')
        endif

	  qverrts=0
	  averrb=0
	  astr=0
	  asd=0

C TREE ITERATION 

	do jb=1,jbt
        call zerv(jin,nsample)
	  do n=1,nsample
	    k=int(ran(iseed)*nsample)+1
	    jin(k)=1
	    yb(n)=y(k)
	    do m=1,mdim
	      xb(m,n)=x(m,k)
	    end do
	  end do
	  nls=nsample
	
	  call buildtree(xb,yb,yl,mdim,nls,nsample,treemap,jdex,
     +    upper,avnode,bestcrit,nodestatus,nodepop,nodestart,
     +    nrnodes,nthsize,rsnodecost,ncase,parent,ut,v,iprint,
     +    xt,mtry,ip,nlim,mbest,cat,tgini,iseed)

	  ndbigtree=nrnodes
	  do k=nrnodes,1,-1
	    if (nodestatus(k).eq.0) ndbigtree=ndbigtree-1
	    if (nodestatus(k).eq.2) nodestatus(k)=-1
	  end do

	  call zervr(ytr,nsample)
	  call testreebag(x,nsample,mdim,treemap,nodestatus,
     +    nrnodes,ndbigtree,ytr,upper,avnode,mbest,cat)

        errb=0
	  jout=0
	  do n=1,nsample
	    if(jin(n).eq.0) then
	      yptr(n)=(nout(n)*yptr(n)+ytr(n))/(nout(n)+1)
	      nout(n)=nout(n)+1
	    end if
	    if(nout(n).gt.0) jout=jout+1
	    errb=errb+(y(n)-yptr(n))**2
	  end do
	  errb=errb/nsample

	  call zervr(ytree,ntest)
	  call testreebag(xts,ntest,mdim,treemap,nodestatus,
     +         nrnodes,ndbigtree,ytree,upper,avnode,mbest,cat)
	  errts=0
	  do n=1,ntest
	    ypred(n)=((jb-1)*ypred(n)+ytree(n))/jb
	    errts=errts+(yts(n)-ypred(n))**2
C
C Save prediction for each tree
          ypredA(jb,n)=ytree(n)
	  end do
	  errts=errts/ntest
	
        if(imp.eq.1) then
          do mr=1,mdim
	      call permobmr(mr,x,utr,xt,jin,nsample,mdim,iseed)
	      call testreebag(x,nsample,mdim,treemap,nodestatus,
     +        nrnodes,ndbigtree,ytr,upper,avnode,mbest,cat)
	      do n=1,nsample
	        x(mr,n)=xt(n)
	      end do
	      em=0
	      do n=1,nsample
	        if(jin(n).eq.0) then
	          predimp(n,mr)=(nout(n)*predimp(n,mr)+ytr(n))
     +                        /(nout(n)+1)
	        end if
	        em=em+(y(n)-predimp(n,mr))**2
	      end do
	      errimp(mr)=em/nsample
     	    end do 
	  end if

C GIVE RUNNING OUTPUT 

        errtsA(jb)=errts
        errbA(jb)=errb

        if (isavef.eq.1) then
          ndbtrees(jb)=ndbigtree
          do i=1,nrnodes
            nodestatusA(jb,i) = nodestatus(i)
            upperA(jb,i)      = upper(i)
            treemapA(jb,1,i)  = treemap(1,i)
            treemapA(jb,2,i)  = treemap(2,i)
            avnodeA(jb,i)     = avnode(i)
            mbestA(jb,i)      = mbest(i)
          end do
        end if

        if (isavef.eq.2) then
          do n=1,ndbigtree
            write(9,'(i6,f8.2,2i6,f8.2,i6)') 
     +        nodestatus(n),upper(n),
     +        treemap(1,n),treemap(2,n),avnode(n),
     +        mbest(n)
          end do
        end if
C<jb>	
	end do


      if (isavef.eq.2) then
        close(9)
      end if

C RERUN SAVED RANDOM FOREST

900   continue
      if (irunf.eq.1) then 
          ipos=0
        do jb=1,jbt
          ndbigtree=ndbtrees(jb)
          do i=1,ndbigtree
            nodestatus(i)=int(trees(1,ipos+i))
            upper(i)     =    trees(2,ipos+i)
            treemap(1,i) =int(trees(3,ipos+i))
            treemap(2,i) =int(trees(4,ipos+i))
            avnode(i)    =    trees(5,ipos+i)
            mbest(i)     =int(trees(6,ipos+i))
          end do
          do i=(ndbigtree+1),nrnodes
            nodestatus(i)=0
            upper(i)     =0
            treemap(1,i) =0
            treemap(2,i) =0
            avnode(i)    =0
            mbest(i)     =0
          end do
          ipos=ipos+ndbigtree

	    call zervr(ytree,ntest)
	    call testreebag(xts,ntest,mdim,treemap,nodestatus,
     +      nrnodes,ndbigtree,ytree,upper,avnode,mbest,cat)

	      errts=0
	    do n=1,ntest
	      ypred(n)=((jb-1)*ypred(n)+ytree(n))/jb
	      errts=errts+(yts(n)-ypred(n))**2
	    end do
	      errts=errts/ntest
            errtsA(jb)=errts
        end do
      end if

	end

C END MAIN 
	
C----+|----------------------------------------------------------
C     SUBROUTINE BUILDTREE
C----+|----------------------------------------------------------
	subroutine buildtree(x,y,yl,mdim,nls,nsample,treemap,
     1  jdex,upper,avnode,bestcrit,nodestatus,
     1  nodepop,nodestart,nrnodes,nthsize,rsnodecost,
     1  ncase,parent,ut,v,iprint,xt,mtry,ip,nlim,
     1  mbest,cat,tgini,iseed)
	
	integer treemap(2,nrnodes),parent(nrnodes),
     1  nodestatus(nrnodes),ip(mdim),nodepop(nrnodes),
     1  nodestart(nrnodes),jdex(nsample),ncase(nsample),
     1  mbest(nrnodes),cat(mdim),iseed
	
	real y(nsample),bestcrit(nrnodes),x(mdim,nsample),
     1  avnode(nrnodes),xt(nsample),upper(nrnodes),
     1  v(nsample),ut(nsample),rsnodecost(nrnodes),
     1  yl(nsample),tgini(mdim)
	
	call zerv(nodestatus,nrnodes)
	call zerv(nodestart,nrnodes)
	call zerv(nodepop,nrnodes)
	call zervr(avnode,nrnodes)
	call zerv(mbest,nrnodes)
	call zervr(upper,nrnodes)

      do n=1,nrnodes
        treemap(1,n)=0
        treemap(2,n)=0
      end do
	
	do n=1,nsample
	  ut(n)=0
	  jdex(n)=n
	end do

	ncur=1
	nodestart(1)=1
	nodepop(1)=nls
	nodestatus(1)=2

	av=0
	ss=0

	do n=1,nls
	  d=y(jdex(n))
	  ss=ss+(n-1)*(av-d)*(av-d)/n
	  av=((n-1)*av+d)/n
	end do !n

	avnode(1)=av
	rsnodecost(1)=ss/nls
	
c---- start main loop ----

	do 30 kbuild=1,nrnodes
	  if (kbuild.gt.ncur) goto 50
	  if (nodestatus(kbuild).ne.2) goto 30

	  ndstart=nodestart(kbuild)
	  ndend=ndstart+nodepop(kbuild)-1
	  nodecnt=nodepop(kbuild)
	  sumnode=nodecnt*avnode(kbuild)
	  jstat=0

	  call findbestsplit(x,xt,ut,jdex,y,mdim,nsample,
     1    ndstart,ndend,msplit,decsplit,ubest,ncase,ndendl,
     1    jstat,v,mtry,ip,nlim,sumnode,nodecnt,yl,cat,iseed)

	  if (jstat.eq.1) then
	    nodestatus(kbuild)=-1
	    go to 30
	  else
	    mbest(kbuild)=msplit
	    upper(kbuild)=ubest
	    bestcrit(kbuild)=decsplit
        end if

	  tgini(msplit)=tgini(msplit)+decsplit

	  nodepop(ncur+1)=ndendl-ndstart+1
	  nodepop(ncur+2)=ndend-ndendl
	  nodestart(ncur+1)=ndstart
	  nodestart(ncur+2)=ndendl+1

	  av=0
	  ss=0

	  do n=ndstart,ndendl
	    d=y(jdex(n))
	    k=n-ndstart
	    ss=ss+k*(av-d)*(av-d)/(k+1)
	    av=(k*av+d)/(k+1)
	  end do !n

	  avnode(ncur+1)=av
	  rsnodecost(ncur+1)=ss/nls
	
	  av=0
	  ss=0

	  do n=ndendl+1,ndend
	    d=y(jdex(n))
	    k=n-ndendl-1
	    ss=ss+k*(av-d)*(av-d)/(k+1)
	    av=(k*av+d)/(k+1)
	  end do !n

	  avnode(ncur+2)=av
	  rsnodecost(ncur+2)=ss/nls

	  nodestatus(ncur+1)=2
	  nodestatus(ncur+2)=2

	  if (nodepop(ncur+1).le.nthsize)
     1    nodestatus(ncur+1)=-1
	  if (nodepop(ncur+2).le.nthsize)
     1    nodestatus(ncur+2)=-1

	  treemap(1,kbuild)=ncur+1
	  treemap(2,kbuild)=ncur+2
	  parent(ncur+1)=kbuild
	  parent(ncur+2)=kbuild
	  nodestatus(kbuild)=1
	  ncur=ncur+2
	  if (ncur.ge.nrnodes) goto 50
30	continue
50	continue
	end

C----+|----------------------------------------------------------
C	SUBROUTINE FINDBESTSPLIT
C----+|----------------------------------------------------------
	subroutine findbestsplit(x,xt,ut,jdex,y,mdim,
     1  nsample,ndstart,ndend,msplit,decsplit,ubest,
     1  ncase,ndendl,jstat,v,mtry,ip,nlim,
     1	sumnode,nodecnt,yl,cat,iseed)
	
	integer ncase(nsample),jdex(nsample),ip(mdim),
     1  ncat(32),icat(32),cat(mdim),iseed,mind(mdim),nn
		
	real x(mdim,nsample),ut(nsample),xt(nsample),
     1  v(nsample),y(nsample),yl(nsample),
     1  sumcat(32),avcat(32),tavcat(32)
	
c START BIG LOOP
c -- Modified by Andy Liaw --
      
      msplit = 0
      decsplit = 0.0
      critmax=0
      ubestt = 0.0
c 200  call zerv(ip,mdim)
      non=0
      do k = 1, mdim
	  mind(k) = k
      end do

      nn = mdim
      do mt=1,mtry
         critvar=0.0
c 100     call ran(rnd)
100	 j=int(nn*ran(iseed)) + 1
	 kv=mind(j)
	 mind(j)=mind(nn)
	 nn=nn-1

c	 if(ip(kv).eq.1) goto 100
c	 ip(kv) = 1
	 lc=cat(kv)
         if(lc.eq.1) then
            do n=ndstart,ndend
               xt(n)=x(kv,jdex(n))
               yl(n)=y(jdex(n))
            end do
            
         else
            
            call zervr(sumcat,32)
            call zerv(ncat,32)
            do n=ndstart,ndend
               l=nint(x(kv,jdex(n)))
               d=y(jdex(n))
               sumcat(l)=sumcat(l)+d
               ncat(l)=ncat(l)+1
            end do
            do  j=1,lc
               if(ncat(j).gt.0) then
                  avcat(j)=sumcat(j)/ncat(j)
               else
                  avcat(j)=0
               end if
            end do
            do n=1,nsample
               xt(n)=avcat(nint(x(kv,jdex(n))))
               yl(n)=y(jdex(n))
            end do
         end if
         
         do n=ndstart,ndend
            v(n)=xt(n)
         end do

         do n=1,nsample
            ncase(n)=n
         end do

         call quicksort (v,ncase,ndstart,ndend,nsample)
         if(v(ndstart).ge.v(ndend)) then
            non=non+1
            if(non .ge. 3*mdim) then
               jstat=1
               return
            end if
c            goto 100
	    continue
         end if
         
c     ncase(n)=case number of v nth from bottom
         
         suml=0.0
         sumr=sumnode
         npopl=0
         npopr=nodecnt
	 crit = 0.0
	 do nsp=ndstart,ndend-1
            d=yl(ncase(nsp))
            suml=suml+d
            sumr=sumr-d
            npopl=npopl+1
            npopr=npopr-1
            if (v(nsp) .lt. v(nsp+1)) then
               crit=(suml*suml/npopl)+(sumr*sumr/npopr)
               if (crit .gt. critvar) then
                  ubestt=(v(nsp)+v(nsp+1))/2.0
                  critvar=crit
                  nbestt=nsp
               endif
            end if
         end do
         
         if(critvar.gt.critmax) then
            ubest=ubestt
            nbest=nbestt
            msplit=kv
            critmax=critvar
            do n=ndstart,ndend
               ut(n)=xt(n)
            end do
            if (cat(kv).gt.1) then
               ic=cat(kv)
               do j=1,ic
                  tavcat(j)=avcat(j)
               end do
            end if
         end if

      end do
      decsplit = critmax - (sumnode*sumnode / nodecnt)      
c
c If best split can not be found, set to terminal node and return.
c
      if (msplit .eq. 0) then
	 jstat = 1
	 return
      end if

      nl=ndstart-1
      do nsp=ndstart,ndend
         if(ut(nsp).le.ubest) then
            nl=nl+1
            ncase(nl)=jdex(nsp)
         end if
      end do
      
      ndendl=max0(nl,ndstart+1)
      nr=ndendl
      do nsp=ndstart,ndend
         if(ut(nsp).gt.ubest) then
            nr=nr+1
            if(nr.gt.nsample) goto 765
            ncase(nr)=jdex(nsp)
         end if
      end do
 765  continue
      
      if(ndendl.ge.ndend) ndendl=ndend-1
      
      
      do n=ndstart,ndend
         jdex(n)=ncase(n)
      end do
      lc=cat(msplit)
      if(lc.gt.1) then
         do j=1,lc
            if(tavcat(j).lt.ubest) then
               icat(j)=1
            else
               icat(j)=0
            end if
         end do
         call mypack(lc,icat,nubest)
         ubest=dble(nubest)
      end if
      
      return
      end
		
C------------------------------------------------------------
C     SUBROUTINE TESTREEBAG
C------------------------------------------------------------
	subroutine testreebag(x,nsample,mdim,treemap,nodestatus,
     +   nrnodes,ndbigtree,ytree,upper,avnode,mbest,cat)
	
	real x(mdim,nsample),
     +     upper(nrnodes),avnode(nrnodes),ytree(nsample)
	
	integer treemap(2,nrnodes),nodestatus(nrnodes),
     +        mbest(nrnodes),cat(mdim),icat(32)
     	
	do n=1,nsample
	  kt=1
	  do k=1,ndbigtree
	    if(nodestatus(kt).eq.-1) then
	      ytree(n)=avnode(kt)
	      goto 100
	    end if

	    m=mbest(kt)
	    lc=cat(m)
	    if(lc.eq.1) then
	      if (x(m,n).le.upper(kt)) then 
		  kt=treemap(1,kt)
	      else
	  	  kt=treemap(2,kt)
	      endif 
	    else
	      mm=nint(upper(kt))
	      call unpacklb(lc,mm,icat)
	      j=nint(x(m,n))
	      if(icat(j).eq.1) then 
		  kt=treemap(1,kt)
	      else
	 	  kt=treemap(2,kt)
	      endif
	    end if
	  end do
100	continue
	end do
	end
	


	subroutine permobmr(mr,x,tp,tx,jin,nsample,mdim,iseed)
	dimension x(mdim,nsample), tp(nsample),tx(nsample),
     1  jin(nsample)
	kout=0
	call zervr(tp,nsample)
	do n=1,nsample
	if(jin(n).eq.0) then
	kout=kout+1
	tp(kout)=x(mr,n)
	end if
	end do !n
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
	
	
c	MISCELLANOUS SMALL SUBROUTINES	

	subroutine zerv(ix,m1)
	integer ix(m1)
	do 10 n=1,m1
	ix(n)=0
10	continue
	end
	
	subroutine zervr(rx,m1)
	real rx(m1)
	do 10 n=1,m1
	rx(n)=0
10	continue
	end
	
	subroutine zerm(mx,m1,m2)
	integer mx(m1,m2)
	do 10 i=1,m1
	do 20 j=1,m2
	mx(i,j)=0
20	continue
10	continue
	end
	
	subroutine packlb(l,icat,npack)
	integer icat(32)
	
c	icat is a binary integer with ones for categories going left
c	and zeroes for those going right.  The sub returns npack- the integer 
c	corresponding whose binary expansion is icat.
	
	npack=0
	do 10,k=1,l
	npack=npack+icat(k)*(2**(k-1))
10	continue
	end
	
	subroutine unpacklb(l,npack,icat)
	
c	npack is a long integer.  The sub. returns icat, an integer of zeroes and
c	ones corresponding to the coefficients in the binary expansion of npack.
	
	integer icat(32)
	call zerv(icat,32)
	n=npack
	icat(1)=mod(n,2)
	do 10 k=2,l
	n=(n-icat(k-1))/2
	icat(k)=mod(n,2)
10	continue
	end
	
	
C
C QUICKSORT
C
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
      
      subroutine perm1(np,ns,tp,iseed)
	real tp(ns)
	j=np
11	rnd = ran(iseed)
	k=int(j*rnd)+1
	tx=tp(j)
	tp(j)=tp(k)
	tp(k)=tx
	j=j-1
	if(j.gt.1) go to 11
	end

	
	subroutine perm(ns,ntp,iseed)
	integer ntp(ns)
	do 1 n= 1,ns
	ntp(n)=n
1	continue        
	j=ns
11	rnd = ran(iseed)
	k=int(j*rnd)+1
	jx=ntp(j)
	ntp(j)=ntp(k)
	ntp(k)=jx
	j=j-1
	if(j.gt.1) go to 11
	end
	
C
C  MYPACK
C
      subroutine mypack(l,icat,npack)
      integer*4 icat(32),npack
      
c     icat is a binary integer with ones for categories going left
c     and zeroes for those going right.  The sub returns npack- the integer 
c     corresponding whose binary expansion is icat.
      
      npack=0
      do 10,k=1,l
         npack=npack+icat(k)*(2**(k-1))
10    continue
      end
