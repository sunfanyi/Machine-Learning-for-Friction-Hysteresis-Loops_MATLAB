function [] = plot_loops_individual(loops, normalise)

% set default values
if ~exist('normalise', 'var') || isempty(normalise)
    normalise = false;
end

n = size(loops, 1);
x = loops.x;
Ffr = loops.Ffr;
t = loops.t;
CL = loops.CL;
X = loops.X;

% plot the x vs. Ffr
figure;
for i = 1:n
    subplot(sqrt(n),sqrt(n),i)
    plot(x(i,:), Ffr(i,:), 'b.');
    hold on;
    plot(x(i,1), Ffr(i,1), 'rx');
    if ~normalise
        yline(CL(i), '--r');
        yline(-CL(i), '--r');
        xlim([-max(X) max(X)]);
        ylim([-max(Ffr(:)) max(Ffr(:))]);
    end
    xlabel('Relative Displacement [\mu m]');
    if mod(i,sqrt(n)) == 1
        ylabel('Friction Force [N]');
    end
end

figure;
for i = 1:n
    subplot(sqrt(n),sqrt(n),i)
    plot(t(i,:),x(i,:),'.');
    hold on;
    plot(t(i,:),Ffr(i,:),'.');
    xlabel('Time [s]');
%     yline(CL(i), '--r');
%     yline(-CL(i), '--r');
    legend('Relative Displacement [\mu m]', 'Friction Force [N]');
end

end
