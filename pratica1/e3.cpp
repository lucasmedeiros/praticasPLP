#include <iostream>
#include <string>
using namespace std;

int* split(string entrada, int size) {
    int* array = new int[size];
    int j = 0;

    for (int i = 0; i < entrada.length(); ++i) {
        char atual = entrada[i];
        if (atual != ' ') {
            array[j] = atual - 48;
            j++;
        }
    }

    return array;
}

int contaPontuacao(char pontuacoes[], int valores[], int questoes) {
    int soma = 0;
    for (int i = 0; i < questoes; i++) {
        if (pontuacoes[i] == 'V') {
            soma += valores[i];
        }
    }
    return soma;
}

int main() {
    int questoes, participantes;
    string entrada, entrada2;
    cin >> questoes;
    int valores[questoes];
    for (int i = 0; i < questoes; ++i) {
        cin >> valores[i];
    }

    cin >> participantes;

    int vencedor = 1, pontuacao;
    int maiorPontuacao = 0;
    char pontuacoes[questoes];

    for (int i = 0; i < participantes; ++i) {
        for (int j = 0; j < questoes; j++) {
            if (pontuacoes[j] != ' ')
                cin >> pontuacoes[j];
        }

        pontuacao = contaPontuacao(pontuacoes, valores, questoes);
        // cout << pontuacao << " " << i + 1 << endl;
        if (pontuacao > maiorPontuacao) {
            maiorPontuacao = pontuacao;
            vencedor = i + 1;
        }
    }

    cout << vencedor << ":" << maiorPontuacao << endl;
}
