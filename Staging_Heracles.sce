// Script to show staging optima for two staging (vacuum/simplified problem)
// for launcher like two stage configuration: 
// One payload to given delta v
//
// Problem: Optimal delta-V distribution on stage 1 and stage 2 
//-----------------------------------------------------------------------------
clear
Samples = 15                            // Sample mass [kg]
Sample_Container = 7;                   // Sample container (empty) mass [kg]
mpayload = Sample_Container + Samples;  // Payload Stage 2
Rover = 0;                            // Rover mass [kg]
Garage = 0 ;                          // Garage mass [kg]
m_mid_payload = Rover + Garage          // Payload ejected at stage separation
//-----------------------------------------------------------------------------
ISP_1 = 360;                // First stage ISP [s]
ISP_2 = 330;                // Second stage ISP [s]
PMF1 = 0.82;                // PMF stage 1 [-]
PMF2 = 0.82;                // PMF stage 2 [-]
str1 = (1 - PMF1);          // First stage structural factor m_dry/m_wet [-]
str2 = (1 - PMF2);          // Second stage structural factor m_dry/m_wet [-]
g_0 = 9.80665;              // Average gravitational acceleration (Earth) [m/s]
dv = 5000;                  // Total delta-V [m/s]           
k=1;
for i=0.0:0.01:1
        x = i;
     dv1 = x * dv;
     dv2 = (1-x) * dv ;
     A = exp( dv1 / (ISP_1 * g_0) );
     B = exp( dv2 / (ISP_2 * g_0) );
     mf21 = mpayload * (1 - str2) * B / ( 1 - str2 * B)  ;   // Wet mass stage 2 including payload 
     m2x = (mf21 + m_mid_payload);
     m_0 =  m2x      * (1 - str1) * A / ( 1 - str1 * A)  ;                 // Total launch mass 
     mf1 = m_0 / A ;
     RES(k,1)= x *100 ;
     RES(k,2)= m_0;
    //--------------------------------------------------------------------------
     mw1 = (m_0 - m2x);                    // wet mass stage 1
     ms2 = (mf21 - mpayload) * str2;        // structural mass stage 2
     ms1 = mw1 * str1 ;                  // structural mass stage 1 
     mp2 =  mf21 - mpayload - ms2;        // prop mass stage 2
     mp1 =  mw1 - ms1 ;             // prop mass stage 1
     mw2 = ms2 + mp2;                 // wet mass stage 2 
    RES(k,3)= ms1;
    RES(k,4)= ms2;
    RES(k,5)= mp1;
    RES(k,6)= mp2;
    RES(k,7)= mw1;
    RES(k,8)= mw2;
    RES(k,9)= dv1;
    RES(k,10) = dv2;                // delta v stage 2 
    RES(k,11) = mw1 + mw2 + mpayload + m_mid_payload;        // Total wet mass (control field) 
    RES(k,12)= mp1/mw1;        // PMF stage 1
    RES(k,13)= mp2/mw2;        // PMF stage 2
    k=k+1;
end
 [m,n]=min(RES(:,2)); 
  Optimal_Distribution = RES(n,1);
    format('v',10);Optimal_Distribution
//------------------------------------------------------------------------------
//              PLOT 
//------------------------------------------------------------------------------
subplot(3,1,1)
//plot(RES(:,1),RES(:,2),'red',"linewidth", 3);
plot(RES(:,1),RES(:,3),'blue',"linewidth", 3);
plot(RES(:,1),RES(:,4),'green',"linewidth", 3);
xlabel('Distribution [percent]',"linewidth", 3);
ylabel('Mass [kg]',"linewidth", 3);
subplot(3,1,2)
plot(RES(:,1),RES(:,9),'blue',"linewidth", 3);
plot(RES(:,1),RES(:,10),'green',"linewidth", 3);
xlabel('Distribution [percent]',"linewidth", 3);
ylabel('Delta-V [m/s]',"linewidth", 3);
hl=legend(['Delta-V Stage 1';'Delta-V Stage 2']);
subplot(3,1,3)
plot(RES(:,1),RES(:,7),'blue',"linewidth", 3);
plot(RES(:,1),RES(:,8),'green',"linewidth", 3);
plot(RES(:,1),RES(:,11),'red',"linewidth", 3);
xtitle('Optimum ' + string(Optimal_Distribution) );
xlabel('Distribution [percent]',"linewidth", 3);
ylabel('Mass [kg]',"linewidth", 3);
hl=legend(['Wet mass Stage 1';'Wet mass Stage 2';'Total (wet) mass']);
