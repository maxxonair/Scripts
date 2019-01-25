clear 
//----------------------------------------------------
deltaV=2100;
g=9.81;
//m_pay=9939;
mpaystart=1;
mpayend=50;
for k=mpaystart:1:mpayend
    step = 200;
    m_pay(k)= 6800 + k*step;
end
ISP=[320,360,400];
//----------------------------------------------------
PMFstart=75;
PMFend=85;
for i=PMFstart:1:PMFend
    index=i-(PMFstart-1);
    PMF(index)=i/100;
        for j=1:3
        E=exp(deltaV/(ISP(j)*g));
                mw_stage(index,j)=m_pay(25)*(1-E)/(E*(1-PMF(index))-1);
               // mp_stage(j,k,index)=PMF*mw_stage(j,k,index);
              //  ms_stage(j,k,index)=mw_stage(j,k,index)-mp_stage(j,k,index);
        end
end

for k=1:1:mpayend
    PMFx=0.79;
    for j=1:3
                E=exp(deltaV/(ISP(j)*g));
                mw_stagex(k,j)=m_pay(k)*(1-E)/(E*(1-PMFx)-1);
    end
    
end
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
subplot(1,2,1)
plot(PMF*100,mw_stage);
xlabel("PMF [%]");
ylabel("Stage wet mass [kg]");
subplot(1,2,2)
plot(m_pay,mw_stagex);
xlabel("Payload mass [kg]");
ylabel("Stage wet mass [kg]");
//------------------------------------------------------------------------------