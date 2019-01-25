clear 
//------------------------------------------------------------------------------
Descender_PMF = 0.79;
Descender_deltaV=2143;
TUG_deltaV=864;
g=9.81;
mw_ascender= 9939;
    
    for k=320:0.5:420
        Descender_ISP(k-319)=k;
    end
ISP_Tug=440;
//------------------------------------------------------------------------------
PMFstart=80;
for i=1:100
        TUG_PMF(i)=(i/10+PMFstart)/100;
                    for j=1:1:length(Descender_ISP)
                    E_Descender=exp(Descender_deltaV/(Descender_ISP(j)*g));
                    mw_descender(i,j)=mw_ascender*(1-E_Descender)/(E_Descender*(1-Descender_PMF)-1);
                    E_Tug=exp(TUG_deltaV/(ISP_Tug*g));
                    mw_stage(i,j)=(mw_descender(i,j)+mw_ascender)*(1-E_Tug)/(E_Tug*(1-TUG_PMF(i))-1);
                    mNRHO(i,j)=mw_descender(i,j)+mw_ascender+mw_stage(i,j);
                    end
end
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
f = gcf();
Sgrayplot(TUG_PMF*100,Descender_ISP,mNRHO);
//grayplot(TUG_PMF*100,Descender_ISP,mNRHO);
//f.color_map = rainbowcolormap(64);
f.color_map=jetcolormap(64);
colorbar(20000,35000);
xlabel("TUG PMF [%]");
ylabel("Descender ISP [s]");
//------------------------------------------------------------------------------
