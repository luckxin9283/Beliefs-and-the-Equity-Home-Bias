use Experiment_data.dta, clear


**********************
***Table 1*** 
**********************

eststo clear
eststo: estpost summarize Losspro Remu Sigma Skewness Kurtosis, detail
esttab using "Table1.tex", replace ///
    cells("mean(fmt(2)) sd(fmt(2)) p25(fmt(2)) p50(fmt(2)) p75(fmt(2)) min(fmt(0)) max(fmt(0)) count(fmt(0))") ///
    nonumber nomtitle booktabs noobs ///
    title("Summary Statistics\label{tabsummarystat}") ///
    collabels("Mean" "SD" "P25" "Median" "P75" "Min" "Max" "N") ///
    varlabels(Losspro "Loss probability" Remu "Mean" Sigma "Standard deviation" Skewness "Skewness" Kurtosis "Kurtosis")


**********************
***Table 2*** 
**********************
// Belief distribution parameters, risk perception, and investment behavior
preserve

    reg RiskPerception Losspro Remu Skewness Sigma Kurtosis Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 0, vce(cluster id)
    estadd local Control "Yes",replace       
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m1

    reg RiskPerception Losspro Remu Skewness Sigma Kurtosis Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random  if GeoInfo == 1, vce(cluster id)
    estadd local Control "Yes",replace       
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace

    est store m2

    reg RiskPerception Losspro Remu Skewness Sigma Kurtosis Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random, vce(cluster id)
    estadd local Control "Yes",replace       
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
 
    est store m3

    reg Investment Losspro Remu Skewness Sigma Kurtosis Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 0, vce(cluster id)
    estadd local Control "Yes",replace      
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m4

    reg Investment Losspro Remu Skewness Sigma Kurtosis Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random  if GeoInfo == 1, vce(cluster id)
    estadd local Control "Yes",replace      
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m5
    
    reg Investment Remu Losspro GeoTie Skewness Sigma Kurtosis Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random, vce(cluster id)
    estadd local Control "Yes",replace     
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
   
    est store m6
    
    esttab m1 m2 m3 m4 m5 m6, compress nogap replace se label nomtitle se(%9.3f) b(%9.3f) star(* 0.1 ** 0.05 *** 0.01) ar2 

restore


**********************
***Table 3*** 
**********************
// The impact of geographical information on beliefs
preserve

    reg Remu GeoTie Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 0, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace

    est store m1

    reg Remu GeoTie Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 1, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace

    est store m2

    reg Remu GeoTie i.GeoTie#i.GeoInfo GeoInfo Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m3

    reg RiskPerception GeoTie Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 0, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m4

    reg RiskPerception GeoTie Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 1, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m5

    reg RiskPerception GeoTie GeoInfo i.GeoTie#i.GeoInfo Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random, vce(cluster id)
    estadd local Control "Yes",replace
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m6

    reg Losspro GeoTie Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 0, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m7

    reg Losspro GeoTie Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 1, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m8

    reg Losspro GeoTie GeoInfo i.GeoTie#i.GeoInfo Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m9

    esttab m1 m2 m3 m4 m5 m6 m7 m8 m9, compress nogap replace se label nomtitle b(%9.3f) se(%9.3f) star(* 0.1 ** 0.05 *** 0.01) ar2 

restore


**********************
***Figure 1*** 
**********************

// Figure, Investment
preserve 
    
    collapse (mean)  Investment = Investment (sd) Investment_sd = Investment  (count) n = Investment , by(GeoInfo GeoTie) 
    // format donation_mean donation_sd %9.2f
    gen ul = Investment + invttail(n-1,0.025)*(Investment_sd / sqrt(n))
    gen ll = Investment - invttail(n-1,0.025)*(Investment_sd / sqrt(n))
    
    list

    gen offset = . 
    replace offset = -0.2 + GeoInfo if GeoTie == 1
    replace offset = 0.2 + GeoInfo if GeoTie == 0

    twoway (bar Investment offset if GeoTie == 1, barwidth(0.4) color(gray) lcolor(black)) ///
        (rcap ul ll offset if GeoTie == 1, lcolor(black))  ///
        (bar Investment offset if GeoTie == 0, barwidth(0.4) color("223 224 225") lcolor(black)) /// 
        (rcap ul ll offset if GeoTie == 0, lcolor(black))  , ///
            xtitle("") ytitle("Investment", size(large)) xscale(noline)  ///
            xlabel(0 "NoGeoInfo" 1 "GeoInfo",  labsize(large) tlcolor(%0) nogrid)  /// 
            scheme(plotplain) /// 
            ylabel(0(100)500, labsize(large) format(%9.0f) nogrid)  legen(order(1 "GeoTie" 3 "NoGeoTie") size(large) pos(6) row(1)) ///
            xscale(noline) yscale(lcolor(black)) 

restore

// Figure, CE
preserve 

    collapse (mean) CE = CE (sd) CE_sd = CE  (count) n = CE , by(GeoInfo GeoTie) 

    replace CE = CE * 100
    replace CE_sd = CE_sd * 100
    gen ul = CE + invttail(n-1,0.025)*(CE_sd / sqrt(n))
    gen ll = CE - invttail(n-1,0.025)*(CE_sd / sqrt(n))

    gen offset = . 
    replace offset = -0.2 + GeoInfo if GeoTie == 1
    replace offset = 0.2 + GeoInfo if GeoTie == 0

    twoway (bar CE offset if GeoTie == 1, barwidth(0.4) color(gray) lcolor(black)) ///
        (rcap ul ll offset if GeoTie == 1, lcolor(black))  ///
        (bar CE offset if GeoTie == 0, barwidth(0.4) color("223 224 225") lcolor(black)) /// 
        (rcap ul ll offset if GeoTie == 0, lcolor(black))  , ///
            xtitle("") ytitle("Certainty equivalent (%)", size(large)) xscale(noline)  ///
            xlabel(0 "NoGeoInfo" 1 "GeoInfo",  labsize(large) tlcolor(%0) nogrid)  /// 
            scheme(plotplain)  /// 
            ylabel(0(1)5, labsize(large) format(%9.0f) nogrid)  legen(order(1 "GeoTie" 3 "NoGeoTie") size(large) pos(6) row(1)) ///
            xscale(noline) yscale(lcolor(black)) 

restore


**********************
***Table A.1*** 
**********************

// Distribution
preserve 

    // Requirement: Stata 18, 
    // Package: wmt install wmttest, https://github.com/Meiting-Wang/wmttest

    dtable Remu Sigma Skewness Kurtosis Losspro RiskPerception

    wmttest Remu Sigma Skewness Kurtosis Losspro RiskPerception if GeoInfo == 0 using "T_test_GeoIno.tex", replace by(GeoTie)

    wmttest Remu Sigma Skewness Kurtosis Losspro RiskPerception if GeoInfo == 1 using "T_test_NonGeoIno.tex", replace by(GeoTie)

restore     


**********************
***Table A.2*** 
**********************
// The Impact of Geographical Information on Beliefs
preserve

    reg Investment GeoTie Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 0, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m1

    reg Investment GeoTie Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 1, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m2
     
    reg Investment GeoTie GeoInfo i.GeoTie#i.GeoInfo Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m3

    reg CE GeoTie Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 0, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m4

    reg CE GeoTie Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random if GeoInfo == 1, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m5

    reg CE GeoTie GeoInfo i.GeoTie#i.GeoInfo Risk_aversion Age Inves_expe Gender Major Cost Class Fin_Lite i.Order i.Random, vce(cluster id)
    estadd local Control "Yes",replace    
    estadd local Fixed_Effect_Order "Yes",replace
    estadd local Fixed_Effect_Random "Yes",replace
    
    est store m6

    esttab m1 m2 m3 m4 m5 m6, compress nogap replace se label nomtitle b(%9.3f) se(%9.3f) star(* 0.1 ** 0.05 *** 0.01) ar2 

restore
