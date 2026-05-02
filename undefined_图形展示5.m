%% 案例4.5：二次型与二次曲面的可视化展示
% 功能：绘制二维二次型 x^T A x 定义的曲线，展示正定、负定、不定三种情形
clear; clc; close all;

% 调整图形窗口大小，让2×2子图更舒展（可选）
figure('Name', '二次型与二次曲线', 'NumberTitle', 'off', 'Position', [100, 100, 800, 700]);

% --- 情形1：正定二次型（椭圆） ---
subplot(2, 2, 1);
A_posdef = [3, 1; 1, 2]; % 正定矩阵，特征值均大于0
[V, D] = eig(A_posdef);
fprintf('正定矩阵 A = \n'); disp(A_posdef);
fprintf('特征值: λ1=%.1f, λ2=%.1f\n', D(1,1), D(2,2));

% 生成网格（范围缩小至 ±1.5，步长加密为 0.05）
[x, y] = meshgrid(-1.5:0.05:1.5, -1.5:0.05:1.5);
z = A_posdef(1,1)*x.^2 + 2*A_posdef(1,2)*x.*y + A_posdef(2,2)*y.^2;

% 绘制等高线 x^T A x = 1
contour(x, y, z, [1, 1], 'b', 'LineWidth', 2);
hold on; grid on; axis equal;
xlim([-1.5, 1.5]); ylim([-1.5, 1.5]);
xlabel('x'); ylabel('y');
% 双行标题：总标题 + 本子图说明
title({'二次型与二次曲线：矩阵正定性决定曲线形状'; '正定二次型: x^T A x = 1 (椭圆)'});

% 绘制特征向量方向（主轴）
quiver(0, 0, V(1,1)*0.8, V(2,1)*0.8, 0, 'r', 'LineWidth', 1.5, 'MaxHeadSize', 0.3);
quiver(0, 0, V(1,2)*0.8, V(2,2)*0.8, 0, 'r', 'LineWidth', 1.5, 'MaxHeadSize', 0.3);
legend('x^T A x = 1', '特征向量方向(主轴)');
hold off;

% --- 情形2：负定二次型（椭圆，但需取 -1 值） ---
subplot(2, 2, 2);
A_negdef = -A_posdef; % 负定矩阵
[x, y] = meshgrid(-1.5:0.05:1.5, -1.5:0.05:1.5);
z_neg = A_negdef(1,1)*x.^2 + 2*A_negdef(1,2)*x.*y + A_negdef(2,2)*y.^2;

% 绘制 x^T A x = -1 （即二次型值为 -1 的等高线）
contour(x, y, z_neg, [-1, -1], 'b', 'LineWidth', 2);
hold on; grid on; axis equal;
xlim([-1.5, 1.5]); ylim([-1.5, 1.5]);
xlabel('x'); ylabel('y');
title('负定二次型: x^T A x = -1 (椭圆)');
text(0, 0, '所有x≠0时\nx^T A x < 0', 'HorizontalAlignment', 'center', 'FontSize', 10);
hold off;

% --- 情形3：不定二次型（双曲线） ---
subplot(2, 2, 3);
A_indef = [1, 2; 2, -1]; % 不定矩阵，特征值一正一负
[V_indef, D_indef] = eig(A_indef);
fprintf('不定矩阵 A = \n'); disp(A_indef);
fprintf('特征值: λ1=%.1f, λ2=%.1f\n', D_indef(1,1), D_indef(2,2));

[x, y] = meshgrid(-2.5:0.05:2.5, -2.5:0.05:2.5); % 双曲线需要稍大范围
z_indef = A_indef(1,1)*x.^2 + 2*A_indef(1,2)*x.*y + A_indef(2,2)*y.^2;

% 绘制 x^T A x = 1 和 x^T A x = -1
contour(x, y, z_indef, [1, 1], 'r', 'LineWidth', 1.5);
hold on; grid on; axis equal;
contour(x, y, z_indef, [-1, -1], 'b', 'LineWidth', 1.5);

% 绘制渐近线方向（特征向量方向）
quiver(0, 0, V_indef(1,1)*2, V_indef(2,1)*2, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.3);
quiver(0, 0, V_indef(1,2)*2, V_indef(2,2)*2, 0, 'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.3);
xlim([-2.5, 2.5]); ylim([-2.5, 2.5]);
xlabel('x'); ylabel('y');
title('不定二次型: x^T A x = ±1 (双曲线)');
legend('x^T A x = 1', 'x^T A x = -1', '特征向量(渐近线方向)');
hold off;

% --- 情形4：半正定二次型（退化为平行直线） ---
subplot(2, 2, 4);
A_semidef = [1, 0; 0, 0]; % 半正定矩阵（秩1）
[x, y] = meshgrid(-1.5:0.05:1.5, -1.5:0.05:1.5);
z_semi = A_semidef(1,1)*x.^2; % 即 x^2

contour(x, y, z_semi, [1, 1], 'b', 'LineWidth', 2);
hold on; grid on; axis equal;
xlim([-1.5, 1.5]); ylim([-1.5, 1.5]);
xlabel('x'); ylabel('y');
title('半正定二次型: x^T A x = 1 (平行直线)');
text(0, 1.3, '秩为1，特征值λ2=0', 'HorizontalAlignment', 'center', 'FontSize', 10);
hold off;
