final mapa = {'key 1': 'value 1', 'key 2': 'value 2', 'key 3': 'value 3'};

void main(List<String> args) {
  for (var a in mapa.entries) {
    print(a.key);
    print(a.value);
  }
}
