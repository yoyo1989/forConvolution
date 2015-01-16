PRO vel_final
;remember to change L4, 52, 54

Si_flag=0; 0 to compare Fe, 1 to compare Si
basicdir='/Users/yuqianliu/Desktop/regenerateSNID/'
readcol, basicdir+'vabs/TypeIcbl', snname, f='a' ,/SILENT

if Si_flag eq 0 then begin
readcol, 'mean_FeII5169_vabs.dat', mean_name, w_min, vel_min, f='a,f,f',/silent
readcol, 'mean_FeII5169_vabs_std.dat', phase_std, num_std, mean_std, err_std, f='f,f,f,f', /silent
endif else begin
readcol, 'mean_SiII_vabs.dat', mean_name, w_min, vel_min, f='a,f,f',/silent
readcol, 'mean_SiII_vabs_std.dat', phase_std, num_std, mean_std, err_std, f='f,f,f,f', /silent
endelse  

; plot vel vs phase
ntemp=n_elements(vel_min)
phasearr=fltarr(ntemp)
for j=0, ntemp-1 do begin
phasearr[j]=-10+j*2
endfor
plot, phasearr, -vel_min, psym=4
oploterror, phasearr, -vel_min, err_std, psym=3

nsn=n_elements(snname)

For i=1, 1 Do Begin
IF snname[i] EQ 'sn1993J' then cd,basicdir+snname[i]+'/spec/lick' ELSE if snname[i] EQ 'sn2007ru' then cd,basicdir+snname[i]+'_Sahu' ELSE if snname[i] EQ 'sn2010bh' then cd, basicdir+snname[i]+'/spec/Chornock' ELSE cd,basicdir+snname[i]+'/spec'
   print, snname[i]
   
   if Si_flag eq 0 then begin
    openw,2,'/Users/yuqianliu/Desktop/snidmeanspectra/templates-2.0_myself/forConvolution/'+snname[i]+'_FeII5169_vabs_conv.dat', width=120
    if snname[i] eq 'sn2010bh' or snname[i] eq 'sn2010ma' or snname[i] eq 'PTF10vgv' then begin
    readcol, 'Spec.JD.phases_FeII5169', spectra,jd,phase,FORMAT='A,D,D', /silent
    endif else begin
    readcol,  'Spec.JD.phases', spectra,jd,phase,FORMAT='A,D,D', /silent
    endelse
   endif
   if Si_flag eq 1 then begin
    openw,2,'/Users/yuqianliu/Desktop/snidmeanspectra/templates-2.0_myself/forConvolution/'+snname[i]+'_SiII_vabs_conv.dat', width=120
    if snname[i] eq 'sn2010bh' or snname[i] eq 'sn2010ma' or snname[i] eq 'PTF10vgv' then begin
    readcol,  'Spec.JD.phases_SiII', spectra,jd,phase,FORMAT='A,D,D', /silent
    endif else begin
    readcol,  'Spec.JD.phases', spectra,jd,phase,FORMAT='A,D,D', /silent
    endelse
   endif
   
   printf, 2, 'spec_name  ', 'phase        ','vel_50         ','velerr_16  ','vel_err_84   ','velerr_16_temperr   ', 'velerr_84_temperr'  
   phases=round(phase)
   nspec=n_elements(phases)
    for k=0, nspec-1 do begin   
      readcol, spectra[k], wave, flux, f='f,f'
      ;for Fe
      if min(wave)  lt 4800 and phases[k] lt 75 then begin
      ;for Si
      ;if max(wave)  gt 6400 and min(wave) lt 5800 and phases[k] lt 25 then begin
    if phases[k] le -10 then phase_use=-10 else if phases[k] eq 62 or phases[k] eq 63 then phase_use=60 else if phases[k] eq 64 or phases[k] eq 65 then phase_use=66 else if phases[k] ge 72 then phase_use=72 else if phases[k] lt 0 then phase_use=round(phases[k]/2.0)*2 else phase_use=phases[k]/2*2
    print, spectra[k]+'-flat.sav.dat'
    ;printf, 2, spectra[k]
    print, 'original phase ', phases[k]
    ;printf, 2, phases[k]
    print, 'phase in use ', phase_use
    vel_mean=vel_min(where(mean_name eq 'meanspecIc_'+strtrim(phase_use,1)+'.sav'))
    print, 'mean velocity ', vel_mean
    close, 1
    openr, 1, spectra[k]+'-flat.sav.dat'    
    dum1=''; for Fe
    dum2=''; initial wavelength range
    dum3=''; mean acceptance fraction
    dum4=''; names
    dum5=''; initial values
    dum6=''; best value
    dum7=''; percentile
    dum8=''; sigma
    dum9=''; v
    dum10=''; scale
    dum11=''; stretch
    
    readf, 1, dum1,dum2, dum3, dum4, dum5, dum6,dum7, dum8, dum9, dum10, dum11 ; read in row
    if Si_flag eq 0 then begin
    dum6 = strsplit(dum6,/extract)
    vel_conv=-(dum6[4]*1000.0+8409)
    ;print, dum6[4]*1000.0+8409+vel[position[0]]
    ;print, vel_conv
    ;print, vel[position[0]]
    ;print, velerr[position[0]]
    dum9 = strsplit(dum9,/extract)   
    dum9_0=strsplit(dum9[0], /extract, '[')
    vel_conv_1=-gettok(dum9_0, ',')*1000.0 ; 16 percentile
    vel_conv_2=-gettok(dum9[2], ',')*1000.0 ; 84 percentile
    vel_conv_12=-gettok(dum9[1], ',')*1000.0 ; 50 percentile
    vel_total=vel_conv_12+vel_mean
    vel_err1=float(vel_conv_1-vel_conv_12)
    vel_err2=float(vel_conv_12-vel_conv_2)
    vel_err1_temperr=sqrt(vel_err1^2+err_std(where(phase_std eq phase_use))^2)
    vel_err2_temperr=sqrt(vel_err2^2+err_std(where(phase_std eq phase_use))^2)    
    ;print, gettok(dum9[2], ']')*1000.0-gettok(dum9_0, ',')*1000.0
    ;print, vel_conv_1-vel_conv
    printf, 2, spectra[k], phase[k], vel_total, vel_err1, vel_err2, vel_err1_temperr, vel_err2_temperr,$
      format='(a, f16.1, f16.1, f16.1, f16.1, f16.1, f16.1)'
    ;print, vel_conv_1-vel_conv_12
    ;print, gettok(dum9[1], ',')*1000.0
    ;print, vel_conv_2-vel_conv
    ;print, vel_conv_12-vel_conv_2
    ;print, velerr[position[0]]
    endif
    
    if Si_flag eq 1 then begin
    dum1=''; for Si
    dum2=''; initial wavelength range
    dum3=''; mean acceptance fraction
    dum4=''; names
    dum5=''; initial values
    dum6=''; best value
    dum7=''; percentile
    dum8=''; sigma
    dum9=''; v
    dum10=''; scale
    dum11=''; stretch
    
    readf, 1, dum1,dum2, dum3, dum4, dum5, dum6,dum7, dum8, dum9, dum10, dum11 ; read in row
    dum6 = strsplit(dum6,/extract)
    vel_conv=-dum6[4]*1000.0
    dum9 = strsplit(dum9,/extract)   
    dum9_0=strsplit(dum9[0], /extract, '[')
    vel_conv_1=-gettok(dum9_0, ',')*1000.0
    vel_conv_12=-gettok(dum9[1], ',')*1000.0
    vel_conv_2=-gettok(dum9[2], ']')*1000.0
    vel_total=vel_conv_12+vel_mean
    vel_err1=float(vel_conv_1-vel_conv_12)
    vel_err2=float(vel_conv_12-vel_conv_2)
    vel_err1_temperr=sqrt(vel_err1^2+err_std(where(phase_std eq phase_use))^2)
    vel_err2_temperr=sqrt(vel_err2^2+err_std(where(phase_std eq phase_use))^2)    
    printf, 2, spectra[k], phase[k], vel_total, vel_err1, vel_err2, vel_err1_temperr, vel_err2_temperr,$
    format='(a, f16.1, f16.1, f16.1, f16.1, f16.1, f16.1)'   
    endif
    
    close, 1
      endif
    endfor
    
   close,2
   
CD, '/Users/yuqianliu/Desktop/snidmeanspectra/templates-2.0_myself/forConvolution'

Endfor

END
