clear 
//------------------------------------------------------------------------------
Descender_PMF = 0.75;
TUG_PMF=0.80; 
//Descender_deltaV=2143;
//TUG_deltaV=864;
Total_deltaV=2143+864;
g=9.81;
mw_ascender= 9939;
    //for k=320:0.5:420
        Descender_ISP=[320,360,400];
   // end
ISP_Tug=420;
Prop_margin_descender=200;
Prop_margin_tug=200;
//------------------------------------------------------------------------------
PMFstart=80;
//for i=1:100
        //TUG_PMF(i)=(i/10+PMFstart)/100;
                   // for j=1:1:length(Descender_ISP)
                   for i=1:100
                                for j=1:3
                                Descender_deltaV = (i)/100 * Total_deltaV;
                                TUG_deltaV = (100-i)/100 * Total_deltaV;
                                DDV(i)=  Descender_deltaV;
                                TDV(i)=  TUG_deltaV;
                                
                                E_Descender=exp(Descender_deltaV/(Descender_ISP(j)*g));
                                mw_descender(i,j)=(mw_ascender+Prop_margin_descender)*(1-E_Descender)/(E_Descender*(1-Descender_PMF)-1);
                                E_Tug=exp(TUG_deltaV/(ISP_Tug*g));
                                mw_tug(i,j)=(mw_descender(i,j)+mw_ascender + Prop_margin_tug)*(1-E_Tug)/(E_Tug*(1-TUG_PMF)-1);
                                mNRHO(i,j)=mw_descender(i,j) + mw_ascender + mw_tug(i,j);
                                end
                   end
                   // end
//end
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
f = gcf();
plot(DDV,mNRHO);
//grayplot(TUG_PMF*100,Descender_ISP,mNRHO);
//f.color_map = rainbowcolormap(64);
//f.color_map=jetcolormap(64);
//colorbar(20000,35000);
xlabel("Descender delta-V [m/s]");
ylabel("Mass in NRHO [kg]");
hl=legend(['Descender ISP = 320s';'Descender ISP = 360s';'Descender ISP = 400s']);
//------------------------------------------------------------------------------
