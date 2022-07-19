class IndiceDescricaoContagens {
  String nomeFuncao;
  String descricao;
  int quantidadePF;
  String tipoFuncao;
  String complexidade;
  IndiceDescricaoContagens({
    required this.complexidade,
    required this.nomeFuncao,
    required this.descricao,
    required this.quantidadePF,
    required this.tipoFuncao,
  });

  @override
  String toString() {
    return 'Nome: $nomeFuncao\nDescrição: $descricao\nTipo: $tipoFuncao\nPonto de Função: $quantidadePF PF  \nComplexidade: $complexidade \n';
  }
}
