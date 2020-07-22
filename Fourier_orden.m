%%Henry Lema
%A.P. Señales
L = 2*pi;
f = @(x)(1 + exp(-x.^2).*sin(5.*x));

t_eval = linspace(-L/2, L/2, 200);
f_eval = f(t_eval);
plot(t_eval,f_eval,'g')


orden = 8;
ks = [-orden:orden];
Xk = zeros(2*orden+1);
for k = ks
    integrando = @(t) (f(t).*exp(-1j*(2*pi*k/L)*t));
    integral = complex_quadrature(integrando,-L/2,L/2);
    if k<0
        Xk(2*orden+2+k) = (1/L)*integral;
    else
        Xk(1+k) = (1/L)*integral;
    end
end

hold on;
legends = {};
Ntimes = 200;
t_eval = linspace(-L/2, L/2, Ntimes);
f_eval = f(t_eval);
plot(t_eval,f_eval,'g')
lengends = cell(1, 1+orden);
legends{1} = 'f';

%reconstruccion
fourier = ones(1, Ntimes)*Xk(1);
for k=[1:orden]
    onda_plus = @(t)(exp(1j*(2*pi*k/L)*t));
    onda_plus_eval = onda_plus(t_eval);
    onda_minus = @(t)(exp(-1j*(2*pi*k/L)*t));
    onda_minus_eval = onda_minus(t_eval);
    fourier = fourier + Xk(2*orden+2-k)*onda_minus_eval + Xk(1+k)*onda_plus_eval;
    plot(t_eval, fourier,'g')
    legends{k+1} = sprintf('Serie de Fourier hasta grado %d',k);
end

title('Reconstruccion con la serie de Fourier')
legend(legends);
hold off;