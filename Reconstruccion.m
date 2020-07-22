%%SEÑAL ORIGINAL
%Henry Lema
f = @(w)((1+10*w.^2).*exp( -(w-.1).^4));
L = 4;
xs = linspace(-2,2,200);
ss = f(xs);
subplot(4,1,1),plot(xs,ss,'k')
subplot(4,1,2),plot(xs,-ss,'y')
subplot(4,1,3),plot(cos(xs),'g')
subplot(4,1,4),plot(xs,ss)


%%TRANSFORMADA DE FOURIER

n = 30;
Nw = 2*n;
wmax = 3;
ws = linspace(-wmax, wmax, Nw+1);

% Usando quad
Xk = zeros(1,Nw+1);
for k = [1:Nw+1]
    w = ws(k);
    integrando = @(t) (f(t).*exp(-1j*(2*pi*w)*t));
    integral = complex_quadrature(integrando,-L,L);
    Xk(k) = integral;
end

%print(Xk) %Imprime los coeficientes de la serie de Fourier
hold on;
plot(ws, real(Xk),'b')
plot(ws,imag(Xk),'k')
legends = {'parte real',
'parte imaginaria'};
hold off;
legend(legends)
title('Transformada de Fourier')


%%%RECONSTRUCCIÓN DE LA TRANSFORMADA DE FOURIER 
hold on;
Ntimes = 200;
t_eval = linspace(-L/2, L/2, Ntimes);
f_eval = f(t_eval);
plot(t_eval,f_eval, 'r-')

%reconstruccion
dw = 2*wmax/Nw;
fourier = zeros(1, Ntimes);
for k=[1:Nw+1]
    w = ws(k);
    onda = @(t)(exp(1j*(2*pi*w)*t));
    onda_eval = onda(t_eval);
    fourier = fourier + dw*Xk(k)*onda_eval;
end

plot(t_eval, fourier, 'g.')
title('Reconstruccion con la Transformada de Fourier')
legends = cell(1, 2);
legends{1} = 'f';
legends{2} = 'Transformada de Fourier';
legend(legends)
hold off;