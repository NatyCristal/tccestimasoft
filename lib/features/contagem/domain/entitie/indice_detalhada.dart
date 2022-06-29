class IndiceDetalhada {
  int pontoDeFuncao;
  String complexidade;
  String nome;
  String tipo;
  int quantidadeTDs;
  int quantidadeTrsEArs;

  IndiceDetalhada(
      {required this.pontoDeFuncao,
      required this.complexidade,
      required this.nome,
      required this.tipo,
      required this.quantidadeTDs,
      required this.quantidadeTrsEArs});

  @override
  String toString() {
    String nomeTeste = "";
    if (tipo == "ALI" || tipo == "AIE") {
      nomeTeste = "TRs";
    } else {
      nomeTeste = "Ars";
    }

    return 'Nome: $nome - $tipo\nPonto de Função: $pontoDeFuncao PF  \nComplexidade: $complexidade \nTDs $quantidadeTDs -  $nomeTeste $quantidadeTrsEArs\n';
  }
}
