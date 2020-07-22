function integral = complex_quadrature(func, a, b)
    real_func = @(x)(real(func(x)));
    imag_func = @(x)(imag(func(x)));
    [real_integral, error_real] = quad(real_func, a, b);
    [imag_integral, error_imag] = quad(imag_func, a, b);
    integral = real_integral + 1j*imag_integral;
end