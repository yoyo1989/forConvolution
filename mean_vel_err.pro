PRO mean_vel_err
;standard deviation of FeII5169/SiII velocities on spectra that go into Ic template

Si_flag=0; 0 to compare Fe, 1 to compare Si
readcol, 'savlist', name_temp, f='a'
if Si_flag eq 0 then begin
openw, 2, 'mean_FeII5169_vabs_std.dat', width=120
num_re=n_elements(name_temp)
endif else begin
openw, 2, 'mean_SiII_vabs_std.dat', width=120
num_re=18
endelse

printf, 2, 'phase  ', 'Num_spec  ', 'mean_vel  ','mean_vel_err  '
for i=0, num_re-1 do begin
  restore, name_temp[i]
  N=n_elements(SNsave)/2
  velarr=fltarr(N)
  for j=0, N-1 do begin
  if Si_flag eq 0 then begin
  readcol, '/Users/yuqianliu/Desktop/regenerateSNID/vabs/'+SNsave(2*j)+'_FeII5169_vabs.dat', $
      spectra, phase, vel, velerr, FORMAT='A, F, F, F',/silent
  endif else begin
  readcol, '/Users/yuqianliu/Desktop/regenerateSNID/vabs/'+SNsave(2*j)+'_SiII_vabs.dat', $    
    spectra, phase, vel, velerr, FORMAT='A, F, F, F',/silent
  endelse
  
    phase=round(phase)
    posi=where(phase eq SNsave(2*j+1),num)
    posi2=where(phase ge tmin and phase le tmax, num2)
    if num ge 1 then begin
      velarr[j]=vel[posi[0]]
    endif
    if num eq 0 then begin
       if num2 ge 1 then begin
        velarr[j]=vel[posi2[0]]
        endif else begin
        velarr[j]=99
      print, SNsave(2*j), SNsave(2*j+1)
      endelse
    endif    
  endfor
  posi=where(velarr eq 99,num_no)
  num_yes=n_elements(where(velarr ne 99))
  mean_vel=mean(velarr(where(velarr ne 99)))
  mean_velerr=stddev(velarr(where(velarr ne 99)))
  print, num_no, num_yes, n_elements(SNsave)/2, (tmin+tmax)/2, mean_vel, mean_velerr
  printf, 2,  (tmin+tmax)/2, num_yes, mean_vel, mean_velerr
endfor
close,2

END
