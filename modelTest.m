mid = 0.05;
L = 1.0;
k = 150.0;
guess = 0.2;
lapse = 0.1;

xMin = -0.0;
xMax = 0.1;
yMin = -0.0;
yMax = 1.0;

x = linspace(0.0, 0.1);
y_s = [];
for i = x
    y_s = [y_s probabilityCorrect(i, mid, L, k, guess, lapse)];
end
subplot(3,3,2);
plot(x, y_s);
title('Single');
xlim([xMin xMax]);
ylim([yMin yMax]);

y_w_both = [];
y_w_both_r = [];
y_p = [];
y_p_r = [];
y_w_l1 = [];
y_w_l1_r = [];
y_w_l2 = [];
y_w_l2_r = [];
y_c = [];
for i = x
    p_l1 = probabilityCorrect(i, mid, L, k, guess, lapse);
    p_l2 = probabilityCorrect(i, mid, L, k, guess, lapse);
    p_c1 = probabilityCorrect(i, mid, L, k, 0.0, lapse);
    p_c2 = probabilityCorrect(i, mid, L, k, 0.0, lapse);
    p_c12 = (1.0 - (1.0 - p_c1)*(1.0 - p_c2));
    p_c = p_c12 + (1.0 - p_c12)*0.5;

    y_w_both = [y_w_both p_l1 * p_l2* p_c];
    y_w_both_r = [y_w_both_r p_l1 * p_l2* (1.0 - p_c)];
    y_w_l1 = [y_w_l1 p_l1*(1.0-p_l2) * p_c];
    y_w_l1_r = [y_w_l1_r p_l2 * (1.0 - p_l1) * (1.0 - p_c)];
    y_w_l2 = [y_w_l2 p_l2*(1.0-p_l1) * p_c];
    y_w_l2_r = [y_w_l2_r p_l1 * (1.0 - p_l2) * (1.0 - p_c)];
    y_c = [y_c p_c];
    y_p = [y_p p_l1 * p_c];
    y_p_r = [y_p_r p_l2 * (1.0 - p_c)];
end
subplot(3,3,1);
plot(x, y_c, 'b');
title('Whole color');
xlim([xMin xMax]);
ylim([yMin yMax]);

subplot(3,3,4);
plot(x, y_p, 'b'); hold on;
plot(x, y_p_r, 'r');
title('Partial');
xlim([xMin xMax]);
ylim([yMin yMax]);

subplot(3,3,8);
plot(x, y_w_both, 'b'); hold on;
plot(x, y_w_both_r, 'r');
title('Whole both');
xlim([xMin xMax]);
ylim([yMin yMax]);

subplot(3,3,7);
plot(x, y_w_l1, 'b'); hold on;
plot(x, y_w_l1_r, 'r');
title('Whole only first');
xlim([xMin xMax]);
ylim([yMin yMax]);

subplot(3,3,9);
plot(x, y_w_l2, 'b'); hold on;
plot(x, y_w_l2_r, 'r');
title('Whole only second');
xlim([xMin xMax]);
ylim([yMin yMax]);

function p = probabilityCorrect(e, e0, L, k, guess, lapse)
p0 = logistic(e, e0, L, k);
delta = 1.0 - p0;
p = p0 + delta*guess;
return
end

function p = logistic(e, e0, L, k)
p = L/(1.0 + exp(-k*(e-e0)));
return
end