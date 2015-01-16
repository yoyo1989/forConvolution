PRO FeII5169_vabs_Icbl

readcol,'Fe_nogrb_list', velocityIb, FORMAT='A'
readcol, 'Fe_sngrb_list', velocityIc, FORMAT='A'

nvelocityIb=n_elements(velocityIb)
nvelocityIc=n_elements(velocityIc)

loadct,12 ;load color table
yq_plot_default,color_IIb, color_Ib, color_Ic, psym_IIb, psym_Ib, psym_Ic
color_Icbl=210 

ps_open, 'IbIc_FeII5169_vabs',/ps_font,/color,/times;,/portrait
device, /inches,  xsize = 9.0, ysize = 7.5
yrange=[0, -25]
xrange=[-25, 120]
plot, [-100],[-100],xr=xrange,yr=yrange ,xtitle='Phase since V-band maximum [days]',ytit='!7 Absorption velocity [10!u3!n km s!u-1!n]',charsize=2.0,charthick=8,symsize=2.0, thick=8.0 ;,title='Absorption velocity of Fe II 5169'
xyouts, 40, -20, 'Fe II 5169',charsize=3.0
oplot,[75],[-17], psym=5,color=color_Ib, SYMSIZE=2.0, thick=8.0
xyouts, 80, -17, 'SN Ic-bl without GRB',charsize=2.0
oplot, [75],[-15],psym=4,color=color_Ic,symsize=2.0, thick=8.0
xyouts, 80, -15, 'SN Ic-bl with GRB',charsize=2.0
;xyouts, 30, -23, 'Fe II 5169',charsize=2.0
For n=0, nvelocityIb-1 Do Begin
   readcol, velocityIb[n], spectra, phase, vel, velerr1, velerr2, velerr_1, velerr_2, FORMAT='A, F, F, F, F, F, F'
   oplot, phase, vel/1000, psym=-5,symsize=2.0, thick=8.0,color=color_Ib
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, /NOHAT, /HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3, /NOHAT, /LOBAR   
Endfor
For n=0, nvelocityIc-1 Do Begin
print, velocityIc[n]
   readcol, velocityIc[n], spectra, phase, vel,velerr1, velerr2, velerr_1, velerr_2, FORMAT='A, F, F, F, F, F, F'
   oplot, phase, vel/1000, psym=-4, color=color_Ic,symsize=2.0, thick=8.0
   oploterror, phase, vel/1000, velerr_1/1000,psym=3, /NOHAT, /HIBAR
   oploterror, phase, vel/1000, velerr_2/1000,psym=3, /NOHAT, /LOBAR   
Endfor
ps_close

END
