PRO line_vabs_ks_revise_sigma, line=line, phaserange=phaserange,xmeanIb,pmeanIb,sigmamIb,psigmamIb,sigmadIb,psigmadIb,xmeanIc,pmeanIc,sigmamIc,psigmamIc,sigmadIc, psigmadIc, n_Ib,n_Ic,p_IbIc

;use weighted mean value with asymmetirc errors (see Roger Barlow 2003) to represent each SN and then do KS test
;calculate weighted mean, standard deviation and median of these mean values
;we can adjust phase range of KS test 

;KS test over this phase range
if not keyword_set(phaserange) then phaserange=[-2, 2]
if not keyword_set(line) then line='FeII5169' ; choose from FeII5169 and SiII
if line eq 'HeI5876' then line='HeI5875'
model_label=1 ; 1 to use model 1, 2 to use model 2

readcol,'Fe_nogrb_list', velocityIb, FORMAT='A',/SILENT
readcol,'Fe_sngrb_list', velocityIc, FORMAT='A',/SILENT
nvelocityIb=n_elements(velocityIb)
nvelocityIc=n_elements(velocityIc)

meanIb=fltarr(20)
meanIc=fltarr(20)
meanIIb=fltarr(20)
meanIcbl=fltarr(20)
meanIb_sigma=fltarr(20)
meanIc_sigma=fltarr(20)
meanIIb_sigma=fltarr(20)
meanIcbl_sigma=fltarr(20)
phaseIb=fltarr(20)
phaseIc=fltarr(20)
phaseIIb=fltarr(20)
phaseIcbl=fltarr(20)
phaseIb_sigma=fltarr(20)
phaseIc_sigma=fltarr(20)
phaseIIb_sigma=fltarr(20)
phaseIcbl_sigma=fltarr(20)
i=0
j=0
k=0
l=0

For n=0, nvelocityIb-1 Do Begin
readcol, gettok(velocityIb[n],'_')+'_'+line+'_sigma_conv.dat', spectra, phase, vel, velerr_1, velerr_2, FORMAT='A, F, F, F, F',/SILENT
if model_label eq 1 then begin
velerr_m=(velerr_1+velerr_2)/2.0 ; mean
velerr_d=(velerr_2-velerr_1)/2.0 ; difference
velerr_b=(velerr_2-velerr_1)/sqrt(2.0*!pi) 
vel=vel-velerr_b
velerr=sqrt(velerr_m^2+(1-2.0/!pi)*velerr_d^2)
endif
if model_label eq 2 then begin
velerr_m=(velerr_1+velerr_2)/2.0 ; mean
velerr_d=(velerr_2-velerr_1)/2.0 ; difference
vel=vel-velerr_d
velerr=sqrt(velerr_m^2+2*velerr_d^2)  
endif
vel=vel[where(phase LT phaserange[1] and phase GT phaserange[0],num)]
velerr=velerr[where(phase LT phaserange[1] and phase GT phaserange[0])]
phase_use=phase[where(phase LT phaserange[1] and phase GT phaserange[0])]
If num NE 0 then begin
meanerr,vel,velerr,xmean,sigmam,sigmad
meanIb[i]=xmean
meanIb_sigma[i]=sigmam
phaseIb[i]=mean(phase_use)
if num eq 1 then begin
  phaseIb_sigma[i]=0.5
endif
if num gt 1 then begin  
phaseIb_sigma[i]=stddev(phase_use)
endif
if phaseIb_sigma[i] eq 0 then phaseIb_sigma[i]=0.5
i=i+1
Endif
End

For n=0, nvelocityIc-1 Do Begin
readcol, gettok(velocityIc[n], '_')+'_'+line+'_sigma_conv.dat', spectra, phase, vel, velerr_1, velerr_2, FORMAT='A, F, F, F, F',/SILENT
if model_label eq 1 then begin
velerr_m=(velerr_1+velerr_2)/2.0 ; mean
velerr_d=(velerr_2-velerr_1)/2.0 ; difference
velerr_b=(velerr_2-velerr_1)/sqrt(2.0*!pi) 
vel=vel-velerr_b
velerr=sqrt(velerr_m^2+(1-2.0/!pi)*velerr_d^2)
endif
if model_label eq 2 then begin
velerr_m=(velerr_1+velerr_2)/2.0 ; mean
velerr_d=(velerr_2-velerr_1)/2.0 ; difference
vel=vel-velerr_d
velerr=sqrt(velerr_m^2+2*velerr_d^2)  
endif
vel=vel[where(phase LT phaserange[1] and phase GT phaserange[0],num)]
velerr=velerr[where(phase LT phaserange[1] and phase GT phaserange[0])]
phase_use=phase[where(phase LT phaserange[1] and phase GT phaserange[0])]
If num NE 0 then begin
meanerr,vel,velerr,xmean,sigmam,sigmad
meanIc[j]=xmean
meanIc_sigma[j]=sigmam
phaseIc[j]=mean(phase_use)
if num eq 1 then begin
  phaseIc_sigma[j]=0.5
endif
if num gt 1 then begin  
phaseIc_sigma[j]=stddev(phase_use)
endif
if phaseIc_sigma[j] eq 0 then phaseIc_sigma[j]=0.5
j=j+1
Endif
End

meanIb=meanIb[0:i-1]
meanIc=meanIc[0:j-1]
meanIb_sigma=meanIb_sigma[0:i-1]
meanIc_sigma=meanIc_sigma[0:j-1]
phaseIb=phaseIb[0:i-1]
phaseIc=phaseIc[0:j-1]
phaseIb_sigma=phaseIb_sigma[0:i-1]
phaseIc_sigma=phaseIc_sigma[0:j-1]
n_Ib=i
n_Ic=j

;print, 'phase range: ', phaserange
;print, 'number of SN Ib: ', i
meanerr,meanIb,meanIb_sigma,xmeanIb,sigmamIb,sigmadIb
meanerr,phaseIb, phaseIb_sigma, pmeanIb, psigmamIb, psigmadIb
;print, 'weighted mean of these weighted mean values:', xmeanIb,'  +/-',sigmamIb
;print, 'median of these mean values:', median(meanIb)
;print, 'number of SN Ic: ', j
meanerr,meanIc,meanIc_sigma,xmeanIc,sigmamIc,sigmadIc
meanerr,phaseIc, phaseIc_sigma, pmeanIc, psigmamIc, psigmadIc
;print, 'weighted mean of these weighted mean values:', xmeanIc,'  +/-',sigmamIc
;print, 'median of these mean values:', median(meanIc)

if i GE 4 and j GE 4 then begin
kstwo, meanIb, meanIc, d, p
;print, 'probability that Ib and Ic are same:', p
p_IbIc=p
endif else begin
p_IbIc='999'
endelse

END
