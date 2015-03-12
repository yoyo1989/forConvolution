PRO FeII5169_vabs_Icbl

; calls line_vabs_ks_revise.pro
; plot both individual and mean velocity & sigma of Fe II 5169 & Si II 
; note that 10bh has much larger velocities than other SN-GRB

plot_label=0 ; 1 to plot velocity, 0 to plot sigma

readcol,'Fe_nogrb_list', velocityIb, FORMAT='A',/SILENT 
readcol, 'Fe_sngrb_list_no10bh', velocityIc, FORMAT='A',/SILENT

nvelocityIb=n_elements(velocityIb)
nvelocityIc=n_elements(velocityIc)

loadct,12 ;load color table
yq_plot_default,color_IIb, color_Ib, color_Ic, psym_IIb, psym_Ib, psym_Ic

; plot individual velocity

if plot_label eq 0 then begin
ps_open, 'Icbl_FeII5169_sigma_enlarge',/ps_font,/color,/times;,/portrait
device, /inches,  xsize = 9.0, ysize = 7.5
yrange=[0, -20]
xrange=[-20, 80]
plot, [-100],[-100],xr=xrange,yr=yrange ,xtitle='Phase since V-band maximum [days]',ytit='!7 Absorption velocity [10!u3!n km s!u-1!n]',charsize=2.0,charthick=8,symsize=2.0, thick=8.0 ;,title='Absorption velocity of Fe II 5169'
xyouts, 10, -55, 'Fe II 5169',charsize=3.0
oplot,[35],[-45], psym=5,color=color_Ib, SYMSIZE=2.0, thick=8.0
xyouts, 40, -45, 'SN Ic-bl without',charsize=2.0
xyouts, 40, -40, 'GRB',charsize=2.0
oplot, [35],[-50],psym=4,color=color_Ic,symsize=2.0, thick=8.0
xyouts, 40, -50, 'SN Ic-bl with GRB',charsize=2.0
;xyouts, 30, -23, 'Fe II 5169',charsize=2.0
For n=0, nvelocityIb-1 Do Begin
   readcol, gettok(velocityIb[n],'vabs')+'sigma_conv.dat', spectra, phase, vel, velerr_1, velerr_2, FORMAT='A, F, F, F, F',/SILENT
   print, gettok(velocityIb[n],'vabs')+'sigma_conv.dat'
   if max(abs(vel/1000)) gt 40 then print, '### too large value for the above SN ###'
   if max(abs(velerr_1/1000)) gt 10 then print, '### too large error for the above SN ###'   
   if max(abs(velerr_2/1000)) gt 10 then print, '### too large error for the above SN ###'   
 oplot, phase, vel/1000, psym=-5,symsize=2.0, thick=8.0,color=color_Ib
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, /HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3, /LOBAR   
Endfor
For n=0, nvelocityIc-1 Do Begin
   readcol, gettok(velocityIc[n], 'vabs')+'sigma_conv.dat', spectra, phase, vel, velerr_1, velerr_2, FORMAT='A, F, F, F, F',/SILENT
   print, gettok(velocityIc[n], 'vabs')+'sigma_conv.dat'
   if max(abs(vel/1000)) gt 40 then print, '### too large value for the above SN ###'
   if max(abs(velerr_1/1000)) gt 10 then print, '### too large error for the above SN ###'   
   if max(abs(velerr_2/1000)) gt 10 then print, '### too large error for the above SN ###'   
 oplot, phase, vel/1000, psym=-4, color=color_Ic,symsize=2.0, thick=8.0
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, /HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3, /LOBAR   
Endfor
ps_close

ps_open, 'Icbl_SiII_sigma_enlarge',/ps_font,/color,/times;,/portrait
device, /inches,  xsize = 9.0, ysize = 7.5
yrange=[0, -30]
xrange=[-20, 30]
plot, [-100],[-100],xr=xrange,yr=yrange ,xtitle='Phase since V-band maximum [days]',ytit='!7 Absorption velocity [10!u3!n km s!u-1!n]',charsize=2.0,charthick=8,symsize=2.0, thick=8.0 ;,title='Absorption velocity of Fe II 5169'
xyouts, 10, -55, 'Si II',charsize=3.0
oplot,[35],[-45], psym=5,color=color_Ib, SYMSIZE=2.0, thick=8.0
xyouts, 40, -45, 'SN Ic-bl without',charsize=2.0
xyouts, 40, -40, 'GRB',charsize=2.0
oplot, [35],[-50],psym=4,color=color_Ic,symsize=2.0, thick=8.0
xyouts, 40, -50, 'SN Ic-bl with GRB',charsize=2.0
;xyouts, 30, -23, 'Fe II 5169',charsize=2.0
For n=0, nvelocityIb-1 Do Begin
   readcol, gettok(velocityIb[n],'FeII5169')+'SiII_sigma_conv.dat', spectra, phase, vel, velerr_1, velerr_2, FORMAT='A, F, F, F, F',/SILENT
   print, gettok(velocityIb[n],'FeII5169')+'SiII_sigma_conv.dat'
   ;if max(abs(vel/1000)) gt 40 then print, '### too large value for the above SN ###'
   ;if max(abs(velerr_1/1000)) gt 10 then print, '### too large error for the above SN ###'   
   ;if max(abs(velerr_2/1000)) gt 10 then print, '### too large error for the above SN ###'   
    if abs(velerr_2[-1]/1000) gt 8 then print, '### this SN ###'   
 oplot, phase, vel/1000, psym=-5,symsize=2.0, thick=8.0,color=color_Ib
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, /HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3, /LOBAR   
Endfor
For n=0, nvelocityIc-1 Do Begin
   readcol, gettok(velocityIc[n], 'FeII5169')+'SiII_sigma_conv.dat', spectra, phase, vel, velerr_1, velerr_2, FORMAT='A, F, F, F, F',/SILENT
   print, gettok(velocityIc[n], 'FeII5169')+'SiII_sigma_conv.dat'
   if max(abs(vel/1000)) gt 40 then print, '### too large value for the above SN ###'   
   if max(abs(velerr_1/1000)) gt 10 then print, '### too large error for the above SN ###'   
   if max(abs(velerr_2/1000)) gt 10 then print, '### too large error for the above SN ###'   
   oplot, phase, vel/1000, psym=-4, color=color_Ic,symsize=2.0, thick=8.0
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, /HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3, /LOBAR   
Endfor
ps_close

; create arrays to store mean values

num=21
xmeanIbarr=fltarr(num) ; mean velocity
xmeanIcarr=fltarr(num) 
sigmamIbarr=fltarr(num) ; standard deviation of mean velocity
sigmamIcarr=fltarr(num)
sigmadIbarr=fltarr(num) ; standard deviation of velocity data points
sigmadIcarr=fltarr(num)
pmeanIbarr=fltarr(num) ; mean phase
pmeanIcarr=fltarr(num)
psigmamIbarr=fltarr(num) ; standard deviation of mean phase
psigmamIcarr=fltarr(num)
psigmadIbarr=fltarr(num) ; standard deviation of phase data points
psigmadIcarr=fltarr(num)
phase_arr=fltarr(num)
; calculate mean values

For i=0, num-1 Do begin
line_vabs_ks_revise_sigma,phaserange=[-11+i*2,-9+i*2],xmeanIb,pmeanIb,sigmamIb,psigmamIb,sigmadIb,psigmadIb,xmeanIc,pmeanIc,sigmamIc,psigmamIc,sigmadIc,psigmadIc,n_Ib,n_Ic
xmeanIbarr[i]=xmeanIb ; mean values
xmeanIcarr[i]=xmeanIc
pmeanIbarr[i]=pmeanIb
pmeanIcarr[i]=pmeanIc
sigmamIbarr[i]=sigmamIb ; standard deviation of mean values
sigmamIcarr[i]=sigmamIc
psigmamIbarr[i]=psigmamIb
psigmamIcarr[i]=psigmamIc
sigmadIbarr[i]=sigmadIb ; standard deviation of data points
sigmadIcarr[i]=sigmadIc
psigmadIbarr[i]=psigmadIb
psigmadIcarr[i]=psigmadIc
phase_arr[i]=-10+i*2
;if n_Ib lt 3 or n_Ic lt 3 then begin
 ; print, 'not enough data this range: ', -15+i*10,-5+i*10
  ;print, 'No. of Ic-bl without grb', n_Ib
  ;print, 'No. of sngrb', n_Ic
;endif 
Endfor

; plot mean values

ps_open, 'Icbl_FeII5169_sigma_mean',/ps_font,/color,/times;,/portrait
device, /inches,  xsize = 9.0, ysize = 7.5
yrange=[0, -20]
xrange=[-11, 31]
y_t=yrange[0]+(yrange[1]-yrange[0])*0.9
x_t=xrange[0]+(xrange[1]-xrange[0])*0.3
y_p1=yrange[0]+(yrange[1]-yrange[0])*0.8
y_p2=yrange[0]+(yrange[1]-yrange[0])*0.7
x_p1=xrange[0]+(xrange[1]-xrange[0])*0.4
x_p2=xrange[0]+(xrange[1]-xrange[0])*0.5
plot, [-100],[-10],xr=xrange,yr=yrange,xtitle='Phase since V-band maximum [days]',$
  ytit='!7 Weighted mean sigma [10!u3!n km s!u-1!n]',charsize=2.0,charthick=2;,title='Mean velocity of Fe II 5169' 
loadct,0 ;load color table
color_gray=100
For n=0, nvelocityIb-1 Do Begin
   readcol, gettok(velocityIb[n],'vabs')+'sigma_conv.dat', spectra, phase, vel, velerr_1, velerr_2, FORMAT='A, F, F, F, F',/SILENT
   oplot, phase, vel/1000, psym=psym_Ib, color=color_gray,symsize=1.0, thick=1.0
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, errcolor=color_gray,/HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3,  errcolor=color_gray,/LOBAR   
EndFor
For n=0, nvelocityIc-1 Do Begin
   readcol, gettok(velocityIc[n],'vabs')+'sigma_conv.dat', spectra, phase, vel, velerr_1, velerr_2, FORMAT='A, F, F, F, F',/SILENT
   if gettok(velocityIc[n],'_') eq 'sn2006aj' then begin
    xyouts, 1.2*phase[5], 1.1*vel[5]/1000, '06aj', charsize=1.0
   endif
   oplot, phase, vel/1000, psym=psym_Ic, color=color_gray,symsize=1.0, thick=1.0
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, errcolor=color_gray,/HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3,  errcolor=color_gray,/LOBAR   
EndFor
loadct, 12
oplot, phase_arr, xmeanIbarr/1000, psym=psym_Ib,symsize=1.0,color=color_Ib, thick=8.0
;oploterror, pmeanIbarr, xmeanIbarr/1000, psigmadIbarr, sigmadIbarr/1000, psym=3
xyouts, x_t, y_t, 'Fe II 5169', charsize=3.0
oplot, [x_p1], [y_p1], psym=psym_Ib,symsize=1.0,color=color_Ib, thick=8.0
xyouts, x_p2, y_p1, 'SN Ic-bl without GRB', charsize=2.0
oplot, phase_arr, xmeanIcarr/1000, psym=psym_Ic, symsize=1.0, color=color_Ic, thick=8.0
;oploterror, pmeanIcarr,xmeanIcarr/1000,psigmadIcarr,sigmadIcarr/1000, psym=3
oplot, [x_p1], [y_p2], psym=psym_Ic, color=color_Ic,symsize=1.0, thick=8.0
xyouts, x_p2, y_p2, 'SN Ic-bl with GRB', charsize=2.0
;oplot, phase1, xmeanIIbarr/1000, psym=-psym_IIb, color=color_IIb,symsize=2.0,thick=8.0
;oploterror, phase1, xmeanIIbarr/1000, sigmadIIbarr/1000, psym=3
;oplot, [20], [-13], psym=psym_IIb, color=color_IIb,symsize=2.0,thick=8.0
;xyouts, 25, -13, 'SN IIb', charsize=2.0
ps_close


num=21
xmeanIbarr=fltarr(num) ; mean velocity
xmeanIcarr=fltarr(num) 
sigmamIbarr=fltarr(num) ; standard deviation of mean velocity
sigmamIcarr=fltarr(num)
sigmadIbarr=fltarr(num) ; standard deviation of velocity data points
sigmadIcarr=fltarr(num)
pmeanIbarr=fltarr(num) ; mean phase
pmeanIcarr=fltarr(num)
psigmamIbarr=fltarr(num) ; standard deviation of mean phase
psigmamIcarr=fltarr(num)
psigmadIbarr=fltarr(num) ; standard deviation of phase data points
psigmadIcarr=fltarr(num)
phase_arr=fltarr(num)
; calculate mean values

For i=0, num-1 Do begin
line_vabs_ks_revise_sigma,line='SiII',phaserange=[-11+i*2,-9+i*2],xmeanIb,pmeanIb,sigmamIb,psigmamIb,sigmadIb,psigmadIb,xmeanIc,pmeanIc,sigmamIc,psigmamIc,sigmadIc,psigmadIc,n_Ib,n_Ic
xmeanIbarr[i]=xmeanIb ; mean values
xmeanIcarr[i]=xmeanIc
pmeanIbarr[i]=pmeanIb
pmeanIcarr[i]=pmeanIc
sigmamIbarr[i]=sigmamIb ; standard deviation of mean values
sigmamIcarr[i]=sigmamIc
psigmamIbarr[i]=psigmamIb
psigmamIcarr[i]=psigmamIc
sigmadIbarr[i]=sigmadIb ; standard deviation of data points
sigmadIcarr[i]=sigmadIc
psigmadIbarr[i]=psigmadIb
psigmadIcarr[i]=psigmadIc
phase_arr[i]=-10+i*2
;if n_Ib lt 3 or n_Ic lt 3 then begin
 ; print, 'not enough data this range: ', -15+i*10,-5+i*10
  ;print, 'No. of Ic-bl without grb', n_Ib
  ;print, 'No. of sngrb', n_Ic
;endif 
Endfor

; plot mean values

ps_open, 'Icbl_SiII_sigma_mean',/ps_font,/color,/times;,/portrait
device, /inches,  xsize = 9.0, ysize = 7.5
yrange=[0, -50]
xrange=[-11, 30]
y_t=yrange[0]+(yrange[1]-yrange[0])*0.9
x_t=xrange[0]+(xrange[1]-xrange[0])*0.3
y_p1=yrange[0]+(yrange[1]-yrange[0])*0.8
y_p2=yrange[0]+(yrange[1]-yrange[0])*0.7
x_p1=xrange[0]+(xrange[1]-xrange[0])*0.4
x_p2=xrange[0]+(xrange[1]-xrange[0])*0.5
plot, [-100],[-10],xr=xrange,yr=yrange,xtitle='Phase since V-band maximum [days]',$
  ytit='!7 Weighted mean sigma [10!u3!n km s!u-1!n]',charsize=2.0,charthick=2;,title='Mean velocity of Fe II 5169' 
loadct,0 ;load color table
color_gray=100
For n=0, nvelocityIb-1 Do Begin
   readcol, gettok(velocityIb[n],'_')+'_SiII_sigma_conv.dat', spectra, phase, vel, velerr_1, velerr_2, FORMAT='A, F, F, F, F',/SILENT
   oplot, phase, vel/1000, psym=psym_Ib, color=color_gray,symsize=1.0, thick=1.0
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, errcolor=color_gray,/HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3,  errcolor=color_gray,/LOBAR   
EndFor
For n=0, nvelocityIc-1 Do Begin
   readcol, gettok(velocityIc[n],'_')+'_SiII_sigma_conv.dat', spectra, phase, vel, velerr_1, velerr_2, FORMAT='A, F, F, F, F',/SILENT
   if gettok(velocityIc[n],'_') eq 'sn2013cq' then begin
    xyouts, 1.6*phase[0], 1.1*vel[0]/1000, '13cq', charsize=1.0
   endif
   oplot, phase, vel/1000, psym=psym_Ic, color=color_gray,symsize=1.0, thick=1.0
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, errcolor=color_gray,/HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3,  errcolor=color_gray,/LOBAR   
EndFor
loadct, 12
oplot, phase_arr, xmeanIbarr/1000, psym=psym_Ib,symsize=1.0,color=color_Ib, thick=8.0
;oploterror, pmeanIbarr, xmeanIbarr/1000, psigmadIbarr, sigmadIbarr/1000, psym=3
xyouts, x_t, y_t, 'Si II', charsize=3.0
oplot, [x_p1], [y_p1], psym=psym_Ib,symsize=1.0,color=color_Ib, thick=8.0
xyouts, x_p2, y_p1, 'SN Ic-bl without GRB', charsize=2.0
oplot, phase_arr, xmeanIcarr/1000, psym=psym_Ic, symsize=1.0, color=color_Ic, thick=8.0
;oploterror, pmeanIcarr,xmeanIcarr/1000,psigmadIcarr,sigmadIcarr/1000, psym=3
oplot, [x_p1], [y_p2], psym=psym_Ic, color=color_Ic,symsize=1.0, thick=8.0
xyouts, x_p2, y_p2, 'SN Ic-bl with GRB', charsize=2.0
;oplot, phase1, xmeanIIbarr/1000, psym=-psym_IIb, color=color_IIb,symsize=2.0,thick=8.0
;oploterror, phase1, xmeanIIbarr/1000, sigmadIIbarr/1000, psym=3
;oplot, [20], [-13], psym=psym_IIb, color=color_IIb,symsize=2.0,thick=8.0
;xyouts, 25, -13, 'SN IIb', charsize=2.0
ps_close

return
endif

ps_open, 'Icbl_FeII5169_vabs',/ps_font,/color,/times;,/portrait
device, /inches,  xsize = 9.0, ysize = 7.5
yrange=[0, -60]
xrange=[-20, 80]
plot, [-100],[-100],xr=xrange,yr=yrange ,xtitle='Phase since V-band maximum [days]',ytit='!7 Absorption velocity [10!u3!n km s!u-1!n]',charsize=2.0,charthick=8,symsize=2.0, thick=8.0 ;,title='Absorption velocity of Fe II 5169'
xyouts, 10, -55, 'Fe II 5169',charsize=3.0
oplot,[35],[-45], psym=5,color=color_Ib, SYMSIZE=2.0, thick=8.0
xyouts, 40, -45, 'SN Ic-bl without',charsize=2.0
xyouts, 40, -40, 'GRB',charsize=2.0
oplot, [35],[-50],psym=4,color=color_Ic,symsize=2.0, thick=8.0
xyouts, 40, -50, 'SN Ic-bl with GRB',charsize=2.0
;xyouts, 30, -23, 'Fe II 5169',charsize=2.0
For n=0, nvelocityIb-1 Do Begin
   readcol, velocityIb[n], spectra, phase, vel, velerr1, velerr2, velerr_1, velerr_2, FORMAT='A, F, F, F, F, F, F',/SILENT
   oplot, phase, vel/1000, psym=-5,symsize=2.0, thick=8.0,color=color_Ib
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, /HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3, /LOBAR   
Endfor
For n=0, nvelocityIc-1 Do Begin
print, velocityIc[n]
   readcol, velocityIc[n], spectra, phase, vel,velerr1, velerr2, velerr_1, velerr_2, FORMAT='A, F, F, F, F, F, F',/SILENT
   oplot, phase, vel/1000, psym=-4, color=color_Ic,symsize=2.0, thick=8.0
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, /HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3, /LOBAR   
Endfor
ps_close


; create arrays to store mean values

num=5
xmeanIbarr=fltarr(num) ; mean velocity
xmeanIcarr=fltarr(num) 
sigmamIbarr=fltarr(num) ; standard deviation of mean velocity
sigmamIcarr=fltarr(num)
sigmadIbarr=fltarr(num) ; standard deviation of velocity data points
sigmadIcarr=fltarr(num)
pmeanIbarr=fltarr(num) ; mean phase
pmeanIcarr=fltarr(num)
psigmamIbarr=fltarr(num) ; standard deviation of mean phase
psigmamIcarr=fltarr(num)
psigmadIbarr=fltarr(num) ; standard deviation of phase data points
psigmadIcarr=fltarr(num)

; calculate mean values

For i=0, num-1 Do begin
line_vabs_ks_revise,phaserange=[-15+i*10,-5+i*10],xmeanIb,pmeanIb,sigmamIb,psigmamIb,sigmadIb,psigmadIb,xmeanIc,pmeanIc,sigmamIc,psigmamIc,sigmadIc,psigmadIc,n_Ib,n_Ic
xmeanIbarr[i]=xmeanIb ; mean values
xmeanIcarr[i]=xmeanIc
pmeanIbarr[i]=pmeanIb
pmeanIcarr[i]=pmeanIc
sigmamIbarr[i]=sigmamIb ; standard deviation of mean values
sigmamIcarr[i]=sigmamIc
psigmamIbarr[i]=psigmamIb
psigmamIcarr[i]=psigmamIc
sigmadIbarr[i]=sigmadIb ; standard deviation of data points
sigmadIcarr[i]=sigmadIc
psigmadIbarr[i]=psigmadIb
psigmadIcarr[i]=psigmadIc
if n_Ib lt 3 or n_Ic lt 3 then begin
  print, 'not enough data this range: ', -15+i*10,-5+i*10
  print, 'No. of Ic-bl without grb', n_Ib
  print, 'Npo. of sngrb', n_Ic
endif 
Endfor

; plot mean values

ps_open, 'Icbl_FeII5169_vabs_mean',/ps_font,/color,/times;,/portrait
device, /inches,  xsize = 9.0, ysize = 7.5
yrange=[0, -35]
xrange=[-15, 40]
plot, [-100],[-10],xr=xrange,yr=yrange,xtitle='Phase since V-band maximum [days]',ytit='!7 Weighted mean velocity [10!u3!n km s!u-1!n]',charsize=2.0,charthick=2;,title='Mean velocity of Fe II 5169' 
oplot, pmeanIbarr, xmeanIbarr/1000, psym=-5,symsize=2.0,color=color_Ib, thick=8.0
oploterror, pmeanIbarr, xmeanIbarr/1000, psigmadIbarr, sigmadIbarr/1000, psym=3
xyouts, 0, -35, 'Fe II 5169', charsize=3.0
oplot, [2], [-27], psym=5,symsize=2.0,color=color_Ib, thick=8.0
xyouts, 5, -27, 'SN Ic-bl without GRB', charsize=2.0
oplot, pmeanIcarr, xmeanIcarr/1000, psym=-4, symsize=2.0, color=color_Ic, thick=8.0
oploterror, pmeanIcarr,xmeanIcarr/1000,psigmadIcarr,sigmadIcarr/1000, psym=3
oplot, [2], [-30], psym=4, color=color_Ic,symsize=2.0, thick=8.0
xyouts, 5, -30, 'SN Ic-bl with GRB', charsize=2.0
;oplot, phase1, xmeanIIbarr/1000, psym=-psym_IIb, color=color_IIb,symsize=2.0,thick=8.0
;oploterror, phase1, xmeanIIbarr/1000, sigmadIIbarr/1000, psym=3
;oplot, [20], [-13], psym=psym_IIb, color=color_IIb,symsize=2.0,thick=8.0
;xyouts, 25, -13, 'SN IIb', charsize=2.0
ps_close

END
