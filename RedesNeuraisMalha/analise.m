%Rodrigo M. S. de Oliveira - 2007
% Para Matlab



% Limpar o ambiente
clear; clc; close all;

%% Gerar dados de treinamento e teste
% Dados de entrada (5 variáveis)
numSamples = 100; % Número de amostras
X = rand(5, numSamples); % Dados de entrada aleatórios no intervalo [0, 1]

% Dados de saída (2 variáveis)
Y = [sum(X(1:3, :), 1); mean(X(4:5, :))]; % Combinação linear para saída

% Dividir dados entre treinamento e teste
trainRatio = 0.8;
testRatio = 0.2;
[trainInd, testInd] = dividerand(numSamples, trainRatio, testRatio, 0);

X_train = X(:, trainInd);
Y_train = Y(:, trainInd);

X_test = X(:, testInd);
Y_test = Y(:, testInd);

%% Criar e treinar a rede neural
% Configuração da rede com 5 entradas e 2 saídas
hiddenLayerSize = 10; % Número de neurônios na camada oculta
%%começar com uma camada depois aumentar o numero de camadas

net = feedforwardnet(hiddenLayerSize);

% Configurar divisão dos dados para treinamento, validação e teste
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.2;
net.divideParam.testRatio = 0.0;

% Treinar a rede
[net, tr] = train(net, X_train, Y_train);

%% Testar a rede
Y_pred = net(X_test); % Saídas previstas pela rede

%% Avaliar o desempenho
mseError = mse(Y_test - Y_pred); % Erro médio quadrático
fprintf('Erro médio quadrático (MSE) no conjunto de teste: %.4f\n', mseError);

%% Plotar resultados
figure;
for i = 1:2
    subplot(2, 1, i);
    plot(Y_test(i, :), 'b-o', 'DisplayName', 'Saída esperada');
    hold on;
    plot(Y_pred(i, :), 'r--x', 'DisplayName', 'Saída da rede');
    xlabel('Indices das Amostras');
    ylabel(sprintf('Saída %d', i));
    legend();
    grid on;
    title(sprintf('Comparação para a saída %d', i));
end