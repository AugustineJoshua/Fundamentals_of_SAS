/*Import Data*/
FILENAME REFFILE 'T:\MyFolder\MyDataFile';
PROC IMPORT DATAFILE=REFFILE
       DBMS=XLSX
       OUT=WORK.IMPORT;
       GETNAMES=YES;
RUN;

/*See Contents*/
proc contents data=WORK.IMPORT;
run;

/*Summary Statistics*/
proc means data=WORK.IMPORT chartype mean std min max n;
       var DiseaseType Age;
       class Sex;
run;

/*Distribution Analysis*/
proc univariate data=WORK.IMPORT;
       var DiseaseType Age;
       histogram DiseaseType Age;
run;

/*One-way Frequencies*/
proc freq data=WORK.IMPORT;
       tables DiseaseType Age / plots=(freqplot cumfreqplot);
run;

/*Correlation Analysis*/
proc corr data=WORK.IMPORT pearson spearman;
       var DiseaseType Age;
run;

/*Paired t-test*/
proc ttest data=WORK.IMPORT;
       paired DiseaseType Age;
run;

/*Parametric One-way ANOVA*/
proc glm data=WORK.IMPORT;
       model DiseaseType=Age;
run;

/*Non-parametric One-way ANOVA*/
proc npar1way data=WORK.IMPORT;
       class DiseaseType;
       var Age;
run;

/* Linear Regression */
proc reg data=WORK.IMPORT;
       model DiseaseType=Age;
run;

/* Linear Regression - stepwise */
proc glmselect data=WORK.IMPORT;
         model DiseaseType=Age Sex YearsOfEducation SocialStatus PreMorbidResidence PreMorbidEmployment / selection=stepwise (select=sl slentry=0.50 slstay=0.20) showpvalues;
run;

/* Logistic Regression */
proc logistic data=WORK.IMPORT;
         model Sex(event='1')=L_BasalGanglia L_Cerebellum L_Frontal L_InternalCapsule L_Medulla L_Midbrain L_Occipital L_Parietal L_Pons L_Prefrontal L_Temporal_lateral L_Temporal_medial L_Thalamus / link=logit;
run;

/* Logistic Regression */
proc logistic data=WORK.IMPORT;
         model Sex(event='1')=R_BasalGanglia R_Cerebellum R_Frontal R_InternalCapsule R_Medulla R_Midbrain R_Occipital R_Parietal R_Pons R_Prefrontal R_Temporal_lateral R_Temporal_medial R_Thalamus / link=logit;
run;

/* Logistic Regression - stepwise */
proc logistic data=WORK.IMPORT;
       model Sex(event='1')=L_BasalGanglia L_Cerebellum L_Frontal L_InternalCapsule L_Medulla L_Midbrain L_Occipital L_Parietal L_Pons L_Prefrontal L_Temporal_lateral L_Temporal_medial L_Thalamus / link=logit selection=stepwise slentry=0.05 slstay=0.05 details;
run;

/* Logistic Regression - stepwise */
proc logistic data=WORK.IMPORT;
       model Sex(event='1')=R_BasalGanglia R_Cerebellum R_Frontal R_InternalCapsule R_Medulla R_Midbrain R_Occipital R_Parietal R_Pons R_Prefrontal R_Temporal_lateral R_Temporal_medial R_Thalamus / link=logit selection=stepwise slentry=0.05 slstay=0.05 details;
run;

/* Linear Regression */
proc reg data=WORK.IMPORT;
       model ExperimentalTreatmentOutcome=Age Sex YearsOfEducation SocialStatus PreMorbidResidence PreMorbidEmployment;
run;

/* Linear Regression - stepwise */
proc glmselect data=WORK.IMPORT;
       model ExperimentalTreatmentOutcome=Age Sex YearsOfEducation SocialStatus PreMorbidResidence PreMorbidEmployment / selection=stepwise (select=sl slentry=0.50 slstay=0.20) showpvalues;
run;

/* Logistic Regression */
proc logistic data=WORK.IMPORT;
       model ExperimentalTreatmentOutcome(event='1')=Age Sex YearsOfEducation SocialStatus PreMorbidResidence PreMorbidEmployment / link=logit;
run;

/* Logistic Regression - stepwise */
proc logistic data=WORK.IMPORT;
       model ExperimentalTreatmentOutcome(event='1')=Age Sex YearsOfEducation SocialStatus PreMorbidResidence PreMorbidEmployment / link=logit selection=stepwise slentry=0.05 slstay=0.05 details;
run;
