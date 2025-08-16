% Define the chromium dot size in nanometers
dot_size = 250;

% Define the mask support (x support)
% Since we compute FT, better to choose a 2^n number of points
x_support = linspace(-1000, 1000, 128);

% Compute the pixel size in nanometers
dx = 2000 / 128;

% Define the mask, 1 for glass, 0 for chromium
mask = abs(x_support) < dot_size / 2;

% Plot
figure;
title('Mask Transmission');
plot(x_support, mask);
xlabel('x position [nm]');
ylabel('Mask transmission');
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computation of the mask TF and its frequency support
mask_ft = fftshift(fft(mask));
mask_ft_re = dlmread('mask_ft_re.txt')
mask_ft_im = dlmread('mask_ft_im.txt')
eps_mask_ft_re = max(abs(real(mask_ft)-mask_ft_re'))
eps_mask_ft_im = max(abs(imag(mask_ft)-mask_ft_im'))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% mask OK
mask_ft_py_re = dlmread('mask_ana_ft_re.txt')
mask_ft_py_im = dlmread('mask_ana_ft_im.txt')

eps_mask_ft_re = max(abs(real(mask_ft)-mask_ft_py_re'))
eps_mask_ft_im = max(abs(real(mask_ft)-mask_ft_py_im'))

freq = fftfreq(128, dx);
freq_py = dlmread("freq.txt");
eps_freq = max(abs(freq-freq_py'));
% Do not forget the pixel size d when creating the frequency support
freq_support = fftshift(fftfreq(128, dx));
freq_support_py_im = dlmread('freq_sup_im.txt');
freq_support_py_re = dlmread('freq_sup_re.txt');
eps_freq_support_py_re = max(abs(real(freq_support)-freq_support_py_re'))
eps_freq_support_py_im = max(abs(imag(freq_support)-freq_support_py_im'))

;% Analytical Fourier Transform
mask_ana_ft = sinc(freq_support * dot_size) * dot_size / dx;
mask_ana_ft_py_re = dlmread('mask_ana_ft_re.txt')
mask_ana_ft_py_im = dlmread('mask_ana_ft_im.txt')
eps_mask_ana_ft_py_re = max(abs(real(mask_ana_ft)-mask_ana_ft_py_re'))
eps_mask_ana_ft_py_im = max(abs(imag(mask_ana_ft)-mask_ana_ft_py_im'))

% Plotting section
figure;
title('Mask Fourier Transform');
plot(freq_support, abs(mask_ft), 'DisplayName', 'Numeric FT');
hold on;
plot(freq_support, abs(mask_ana_ft), 'o', 'DisplayName', 'Analytic FT');
legend show;
% mask_ana_py = dlmread('mask_ana_ft.txt')
% eps = max(abs(mask_ana_ft-mask_ana_py))
xlabel('Frequency [1/nm]');
ylabel('Mask spectrum');
hold off;


