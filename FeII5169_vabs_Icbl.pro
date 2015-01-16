PRO FeII5169_vabs_Icbl

readcol,'Fe_nogrb_list', velocityIb, FORMAT='A',/SILENT
readcol, 'Fe_sngrb_list', velocityIc, FORMAT='A',/SILENT

nvelocityIb=n_elements(velocityIb)
nvelocityIc=n_elements(velocityIc)

loadct,12 ;load color table
yq_plot_default,color_IIb, color_Ib, color_Ic, psym_IIb, psym_Ib, psym_Ic
color_Icbl=210 

ps_open, 'Icbl_FeII5169_vabs_no10bh',/ps_font,/color,/times;,/portrait
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

num=5

xmeanIbarr=fltarr(num)
xmeanIcarr=fltarr(num)
sigmamIbarr=fltarr(num)
sigmamIcarr=fltarr(num)
sigmadIbarr=fltarr(num)
sigmadIcarr=fltarr(num)

pmeanIbarr=fltarr(num)
pmeanIcarr=fltarr(num)
psigmamIbarr=fltarr(num)
psigmamIcarr=fltarr(num)
psigmadIbarr=fltarr(num)
psigmadIcarr=fltarr(num)

yq_plot_default,color_IIb, color_Ib, color_Ic, psym_IIb, psym_Ib, psym_Ic
For i=0, num-1 Do begin
line_vabs_ks_revise,phaserange=[-15+i*10,-5+i*10],xmeanIb,pmeanIb,sigmamIb,psigmamIb,sigmadIb,psigmadIb,xmeanIc,pmeanIc,sigmamIc,psigmamIc,sigmadIc,psigmadIc,n_Ib,n_Ic
xmeanIbarr[i]=xmeanIb
xmeanIcarr[i]=xmeanIc
pmeanIbarr[i]=pmeanIb
pmeanIcarr[i]=pmeanIc
sigmamIbarr[i]=sigmamIb
sigmamIcarr[i]=sigmamIc
psigmamIbarr[i]=psigmamIb
psigmamIcarr[i]=psigmamIc
sigmadIbarr[i]=sigmadIb
sigmadIcarr[i]=sigmadIc
psigmadIbarr[i]=psigmadIb
psigmadIcarr[i]=psigmadIc
if n_Ib lt 3 or n_Ic lt 3 then begin
  print, 'not enough data this range: ', -15+i*10,-5+i*10
  print, 'no grb', n_Ib
  print, 'sngrb', n_Ic
  endif
  
Endfor

ps_open, 'Icbl_FeII5169_vabs_mean_no10bh',/ps_font,/color,/times;,/portrait
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
