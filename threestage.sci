//DvA=3000; // deltav ascender    
//DvD=2000; // deltav descender
DvT=1000; // deltav tug
IspA=320; // ISP ascender
IspD=450; // ISP descender
IspT=[320;360;450]; // ISP tug
g=9.81;
//assmumption:
mT_dry = 300:200:5000;

mA_dry=3.7; // Mass ascender dry 
mA_wet=10; // Mass ascender wet (LINDA)
mD_wet=(1.2804*mA_wet*1000+1018.6)/1000; // Mass descender wet - emp. correlation


ni=length(IspT);
m_stack=zeros(ni,length(mT_dry));
mT_wet=zeros(ni,length(mT_dry));
PMF=zeros(ni,length(mT_dry));

for i=1:ni
    mT_wet(i,:) = ((mT_dry + (mA_wet + mD_wet)) * exp(DvT/(IspT(i)*g)) ) - (mA_wet + mD_wet);
    m_stack(i,:)=mA_wet + mD_wet + mT_wet(i,:);
    PMF(i,:) = ((mT_wet(i,:) - mT_dry - (mA_wet + mD_wet))./(mT_wet(i,:) - (mA_wet + mD_wet))) * 100 ;
end


plot(PMF,m_stack);
//scatter(lam,mT_wet,'--');
xlabel('PMF [-]',"linewidth", 3);
ylabel('Stack Mass [kg]',"linewidth", 3);
