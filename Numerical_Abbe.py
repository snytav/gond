

#%matplotlib inline
import numpy as np
import matplotlib.pyplot as plt

# Define the chromium dot size in nanometers
dot_size=250.
# Define the mask support (x support)
# Since we compute FT, better to chose a 2^n number of points
x_support=np.linspace(-1000.,1000.,128)
# Compute the pixel size in nanometers
dx=2000./128
# Define the mask, 1 for glass, 0 for chromium
mask=[1 if np.abs(x)<dot_size/2 else 0 for x in x_support]
# Plot
plt.title('Mask Transmission')
plt.plot(x_support, mask)
plt.xlabel('x position [nm]')
plt.ylabel('Mask transmission')

# Computation of the mask TF and its frequency support
mask_ft=np.fft.fftshift(np.fft.fft(mask))
np.savetxt('mask_ft_re.txt',
           np.real(mask_ft),fmt='%25.15e')
np.savetxt('mask_ft_im.txt',
           np.imag(mask_ft),fmt='%25.15e')

# Do not forget the pixel size d when creating the frequency support
freq_support=np.fft.fftshift(np.fft.fftfreq(128,d=dx))
# Analytical Fourier Transform
mask_ana_ft=np.sinc(freq_support * dot_size)*dot_size/dx
# Plotting section
plt.title('Mask Fourier Transform')
plt.plot(freq_support,np.abs(mask_ft),label='Numeric FT')
plt.plot(freq_support,np.abs(mask_ana_ft),'o',label='Analytic FT')
plt.legend()
plt.xlabel('Frequency [1/nm]')
plt.ylabel('Mask spectrum')
plt.show()



np.savetxt('mask_ana_ft_re.txt',np.real(mask_ana_ft),fmt='%25.15e')
np.savetxt('mask_ana_ft_im.txt',np.imag(mask_ana_ft),fmt='%25.15e')

