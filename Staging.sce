// Script to show staging optima for two staging (vacuum/simplified problem)
// for launcher like two stage configuration: 
// One payload to given delta v
//
// Problem: Optimal delta-V distribution on stage 1 and stage 2 
//-----------------------------------------------------------------------------
clear
Samples = 15                // Sample mass [kg]
Sample_Container = 7;       // Sample container (empty) mass [kg]
mpayload = Sample_Container + Samples; 
Rover = 500;                // Rover mass [kg]
Garage = 100 ;              // Garage mass [kg]
m_mid_payload = Rover + Garage // 
//-----------------------------------------------------------------------------
ISP_1 = 370;                // First stage ISP [s]
ISP_2 = 330;                // Second stage ISP [s]
PMF1 = 0.9;                // PMF stage 1 [-]
PMF2 = 0.9;                // PMF stage 2 [-]
str1 = (1 - PMF1);          // First stage structural factor m_dry/m_wet [-]
str2 = (1 - PMF2);          // Second stage structural factor m_dry/m_wet [-]
g_0 = 9.80665;              // Average gravitational acceleration (Earth) [m/s]
dv = 6500;                  // Total delta-V [m/s]           
k=1;
for i=0.0:0.02:1
        x = i;
     dv1 = x * dv;
     dv2 = (1-x) * dv ;
     A = exp( dv1 / (ISP_1 * g_0) );
     B = exp( dv2 / (ISP_2 * g_0) );
     C = (mf21 + m_mid_payload) * ( 1 - str1 );
     mf21 = mpayload * (1 - str2) * B /(1 - str2 * B);   // Wet mass stage 2 including payload 
     m_0 = A * C / ( 1 - str1 * A)                   // Total launch mass 
     mf1 = str1 * m_0 + C;
     RES(k,1)= x *100 ;
     RES(k,2)= m_0;
    //--------------------------------------------------------------------------
     ms2 = (mf21 - mpayload) * str2;        // structural mass stage 2
     ms1 = (mf1 - mf21) ;                  // structural mass stage 1 
     mp2 = mf21 - mpayload - ms2;        // prop mass stage 2
     mp1 = m_0 - mf1 ;             // prop mass stage 1
     mw1 = ms1 + mp1;                   // wet mass stage 1
     mw2 = (mf21 - mpayload);                 // wet mass stage 2 
    RES(k,3)= ms1;
    RES(k,4)= ms2;
    RES(k,5)= mp1;
    RES(k,6)= mp2;
    RES(k,7)= mw1;
    RES(k,8)= mw2;
    RES(k,9)= dv1;
    RES(k,10)= dv2;
    //RES(k,11)= mp1/mw1;        // PMF stage 1 
    //RES(k,12)= mp2/mw2;        // PMF stage 2
    k=k+1;
end
k=1;
for i=0.0:0.02:1
    if (i<1)
        RES(k,11) = ( RES(k+1,2) - RES(k,2) )/( RES(k+1,1) - RES(k,1) )
    end 
     k=k+1;
end
 [m,n]=min(RES(:,2)); 
  Optimal_Distribution = RES(n,1);
    format('v',10);Optimal_Distribution
//------------------------------------------------------------------------------
//              PLOT 
//------------------------------------------------------------------------------
subplot(3,1,1)
plot(RES(:,1),RES(:,2),'red',"linewidth", 3);
xtitle('Optimum ' + string(Optimal_Distribution) );
xlabel('Distribution [percent]',"linewidth", 3);
ylabel('Total mass [kg]',"linewidth", 3);
subplot(3,1,2)
plot(RES(:,1),RES(:,9),'blue',"linewidth", 3);
plot(RES(:,1),RES(:,10),'green',"linewidth", 3);
xlabel('Distribution [percent]',"linewidth", 3);
ylabel('Delta-V [m/s]',"linewidth", 3);
hl=legend(['Delta-V Stage 1';'Delta-V Stage 2']);
subplot(3,1,3)
plot(RES(:,1),RES(:,7),'blue',"linewidth", 3);
plot(RES(:,1),RES(:,8),'green',"linewidth", 3);
xlabel('Distribution [percent]',"linewidth", 3);
ylabel('Stage (wet) mass [kg]',"linewidth", 3);
hl=legend(['Wet mass Stage 1';'Wet mass Stage 2']);
