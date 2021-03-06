% Procesado de los datos
[n_x_aristas_ej4, y_aristas_ej4, e_aristas_ej4, cant_aristas_ej4] = leer_datos_float('aristas-combinacion3-ej4-exp4.txt');
[n_x_aristas_ej5, y_aristas_ej5, e_aristas_ej5, cant_aristas_ej5] = leer_datos_float('aristas-combinacion3-ej5-exp4-tipo1.txt');
[n_x_aristas_ej6, y_aristas_ej6, e_aristas_ej6, cant_aristas_ej6] = leer_datos_float('aristas-combinacion3-ej6-exp4-tipo1.txt');

% Creación de los gráficos
filetype='-dpng';
%mkdir('graficos');

figure;

hold on;
%x = gca;
%xlim([0 dim]);
%ylim([0 80]);
stem(n_x_aristas_ej4, y_aristas_ej4, 'LineStyle', 'none', 'Marker', 'o', 'MarkerEdgeColor', 'red');
stem(n_x_aristas_ej5, y_aristas_ej5, 'LineStyle', 'none', 'Marker', 'o', 'MarkerEdgeColor', 'green');
stem(n_x_aristas_ej6, y_aristas_ej6, 'LineStyle', 'none', 'Marker', 'o', 'MarkerEdgeColor', 'blue');
xlabel('n','FontSize',12); %CAMBIAR M
ylabel('Cantidad de aristas','FontSize',10);
legend('Ejercicio 4','Ejercicio 5','Ejercicio 6','Location','northwest')
%set(get(h, 'Parent'), 'YScale', 'log');
hold off;
print('exp4-comb3', filetype);