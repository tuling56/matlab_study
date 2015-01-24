clc;clear
t=cputime;
disp('islem yapiliyor. Lutfen bekleyiniz...')
son=4;
for snr=0:son
    hata(snr+1)=0;
    snr
    carpan=[100 100 1000 1000 10000 100000];
    for j=1:carpan(snr+1)        
        n=100;
        u=randint(1,n-2);
        u(n)=0;
        kafes=poly2trellis(3,[5 7]);
        v=convenc(u,kafes);
        for i=1:2*n
            s(i)=2*v(i)-1;
        end
        r = awgn(s,snr,'measured');
        %Asagidaki x degerleri BPSK modülasyona göre bulunmustur.
        x111=-1;x112=-1;x121=1;x122=1;
        x231=-1;x232=1;x241=1;x242=-1;
        x311=1;x312=1;x321=-1;x322=-1;
        x431=1;x432=-1;x441=-1;x442=1;
        %gamalarin hesabi
        k=0;
       Eb=2;N0=Eb/(10^(snr/10));sigma=N0/2;
       for i=1:2:2*n
            k=k+1;
            gama11(k)=exp((-(r(i)-x111)^2-(r(i+1)-x112)^2)/2/sigma);
            gama12(k)=exp((-(r(i)-x121)^2-(r(i+1)-x122)^2)/2/sigma);
            gama23(k)=exp((-(r(i)-x231)^2-(r(i+1)-x232)^2)/2/sigma);
            gama24(k)=exp((-(r(i)-x241)^2-(r(i+1)-x242)^2)/2/sigma);
            gama31(k)=exp((-(r(i)-x311)^2-(r(i+1)-x312)^2)/2/sigma);
            gama32(k)=exp((-(r(i)-x321)^2-(r(i+1)-x322)^2)/2/sigma);
            gama43(k)=exp((-(r(i)-x431)^2-(r(i+1)-x432)^2)/2/sigma);
            gama44(k)=exp((-(r(i)-x441)^2-(r(i+1)-x442)^2)/2/sigma);
        end
        %alfalarin hesabi:
        alfa1(1)=gama11(1);alfa2(1)=gama12(1);alfa3(1)=0;alfa4(1)=0;
        for i=2:n
            alfa1(i)=alfa1(i-1)*gama11(i)+alfa3(i-1)*gama31(i);
            alfa2(i)=alfa1(i-1)*gama12(i)+alfa3(i-1)*gama32(i);
            alfa3(i)=alfa2(i-1)*gama23(i)+alfa4(i-1)*gama43(i);
            alfa4(i)=alfa2(i-1)*gama24(i)+alfa4(i-1)*gama44(i);
        end
        %Betalarin hesabi
        beta1(n-1)=gama11(n);beta3(n-1)=gama31(n);beta2(n-1)=0;beta4(n-1)=0;
        for i=n-2:-1:1
            beta1(i)=beta1(i+1)*gama11(i+1)+beta2(i+1)*gama12(i+1);
            beta2(i)=beta3(i+1)*gama23(i+1)+beta4(i+1)*gama24(i+1);
            beta3(i)=beta1(i+1)*gama31(i+1)+beta2(i+1)*gama32(i+1);
            beta4(i)=beta3(i+1)*gama43(i+1)+beta4(i+1)*gama44(i+1);
        end
        %L(ak)larin hesabi
        payda=gama12(1)*beta2(1);
                L_a(1)=log((gama11(1)*beta1(1))/(payda));
        for i=2:n-2
            pay=(alfa1(i-1)*gama11(i)*beta1(i)+alfa2(i-1)*gama23(i)*beta3(i)+...
                 alfa3(i-1)*gama31(i)*beta1(i)+alfa4(i-1)*gama43(i)*beta3(i));
            payda=(alfa1(i-1)*gama12(i)*beta2(i)+alfa2(i-1)*gama24(i)*beta4(i)+...
                   alfa3(i-1)*gama32(i)*beta2(i)+alfa4(i-1)*gama44(i)*beta4(i));
            L_a(i)=log(pay/payda);
        end 
        for i=1:n-2
            if L_a(i)>0
                a(i)=0;
            else
                a(i)=1;
            end
        end
        a(n)=0;
        hata(snr+1)=hata(snr+1)+sum(abs(u-a));
    end    
    hata(snr+1);
    bit_hata_orani(snr+1)=hata(snr+1)/100/carpan(snr+1)
end
snr=0:son;
semilogy(snr,bit_hata_orani),grid
title('MAP');xlabel('Eb/N0(dB)');ylabel('Bit Error Rate');
zaman=cputime-t

%For further infornation: gedikbey@gyte.edu.tr