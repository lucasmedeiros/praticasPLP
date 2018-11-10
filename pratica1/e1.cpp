#include <iostream>
using namespace std;

bool andar(int x_origem, int y_origem, int x_destino, int y_destino, string caminho) {

  char ultimoCorredor;

  if (caminho.length() > 0) {
    ultimoCorredor = caminho[0];
  }

  int index = 0;

  int x = x_origem;
  int y = y_origem;

  int aux_x = x_origem;
  int aux_y = y_origem;

  while (index < caminho.length()) {
    char aux_corredor = ultimoCorredor;
    switch(caminho[index]) {
      case 'N':
        if (ultimoCorredor != 'N') {
          ultimoCorredor = 'N';
          aux_y = y;
          aux_x = x;
        }
        y++;
        break;
      case 'S':
        if (ultimoCorredor != 'S') {
          ultimoCorredor = 'S';
          aux_y = y;
          aux_x = x;
        }
        y--;
        break;
      case 'L':
        if (ultimoCorredor != 'L') {
          ultimoCorredor = 'L';
          aux_x = x;
          aux_y = y;
        }
        x++;
        break;
      case 'O':
        if (ultimoCorredor != 'O') {
          ultimoCorredor = 'O';
          aux_x = x;
          aux_y = y;
        }
        x--;
        break;
      default:
        ultimoCorredor = aux_corredor;
        x = aux_x;
        y = aux_y;
        break;
    }
    index++;
  }

  if (x < 0) x = 0;
  if (y < 0) y = 0;

  return (x_destino == x and y_destino == y);
}

int main() {
  int x, y, x2, y2;
  string caminho;
  cin >> x >> y >> x2 >> y2;
  cin >> caminho;

  if (andar(x, y, x2, y2, caminho)) {
    cout << "SIM" << endl;
  } else {
    cout << "NAO" << endl;
  }

  return 0;
}
