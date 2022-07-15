import 'dart:io';
import 'package:estimasoft/core/shared/anim/lotties.dart';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/resultados/widget/alerta_copiar_estimativas.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path/path.dart';

class InsercaoArquivosUpload extends StatefulWidget {
  final ScrollController scrollController = ScrollController();
  final StoreProjetosIndexMenu storeProjetosIndexMenu;
  final ProjetoEntitie projetoEntitie;
  final ProjetoController controller = Modular.get<ProjetoController>();
  InsercaoArquivosUpload({
    Key? key,
    required this.projetoEntitie,
    required this.storeProjetosIndexMenu,
  }) : super(key: key);

  @override
  State<InsercaoArquivosUpload> createState() => _InsercaoArquivosUploadState();
}

class _InsercaoArquivosUploadState extends State<InsercaoArquivosUpload> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file!.path) : 'Nenhum arquivo selecionado';
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Documentos ${widget.projetoEntitie.nomeProjeto}",
          style: const TextStyle(
              fontSize: tamanhoSubtitulo, color: corTituloTexto),
        ),
        shape: const Border(
          bottom: BorderSide(color: corDeLinhaAppBar, width: 1),
        ),
      ),
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: Container(
          width: TamanhoTela.width(context, 1),
          height: TamanhoTela.height(context, 0.9),
          padding: paddingPagePrincipal,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: background, borderRadius: arredondamentoBordas),
                height: 300,
                child: FutureBuilder<ListResult>(
                    future: widget.controller
                        .recuperarArquivos(widget.projetoEntitie.uidProjeto),
                    builder: (BuildContext context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return const Text("Erro");
                          }
                          if (snapshot.hasData) {
                            return widget.controller.arquivos!.items.isEmpty
                                ? SizedBox(
                                    width: TamanhoTela.width(context, 1),
                                    child: const Center(
                                        child: Text("Não tem nenhum arquivo")),
                                  )
                                : ListView.builder(
                                    controller: widget.scrollController,
                                    itemCount: widget
                                        .controller.arquivos!.items.length,
                                    itemBuilder: (context, index) {
                                      final arquivo = widget
                                          .controller.arquivos!.items[index];
                                      return SizedBox(
                                        height: 80,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        height: 40,
                                                        width: 60,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (!widget
                                                                    .storeProjetosIndexMenu
                                                                    .carregando) {
                                                                  Alerta.alertaSimNao(
                                                                      "",
                                                                      "Fazer download arquivo?",
                                                                      context,
                                                                      () async {
                                                                    await widget.controller.fazerDownloadArquivos(
                                                                        widget
                                                                            .projetoEntitie
                                                                            .uidProjeto,
                                                                        arquivo
                                                                            .fullPath);
                                                                  },
                                                                      widget
                                                                          .storeProjetosIndexMenu);
                                                                }
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .download_for_offline_sharp,
                                                                size: 30,
                                                                color: corDeAcao
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (!widget
                                                                  .storeProjetosIndexMenu
                                                                  .carregando) {
                                                                Alerta.alertaSimNao(
                                                                    "",
                                                                    "Fazer download arquivo?",
                                                                    context,
                                                                    () async {
                                                                  await widget
                                                                      .controller
                                                                      .fazerDownloadArquivos(
                                                                          widget
                                                                              .projetoEntitie
                                                                              .uidProjeto,
                                                                          arquivo
                                                                              .fullPath);
                                                                },
                                                                    widget
                                                                        .storeProjetosIndexMenu);
                                                              }
                                                            },
                                                            child: SizedBox(
                                                              width: 200,
                                                              child: Text(
                                                                arquivo.fullPath
                                                                            .split(
                                                                                "/")
                                                                            .last
                                                                            .split(".")[
                                                                        0] +
                                                                    "." +
                                                                    arquivo
                                                                        .fullPath
                                                                        .split(
                                                                            ".")
                                                                        .last,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                maxLines: 3,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: (const TextStyle(
                                                                    fontSize:
                                                                        tamanhoTextoCorpoTexto,
                                                                    color:
                                                                        corCorpoTexto)),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () async {
                                                              if (!widget
                                                                  .storeProjetosIndexMenu
                                                                  .carregando) {
                                                                Alerta.alertaSimNao(
                                                                    "",
                                                                    "Remover o arquivo?",
                                                                    context,
                                                                    () async {
                                                                  var retorno = await widget
                                                                      .controller
                                                                      .removerArquivoProjeto(
                                                                          widget
                                                                              .projetoEntitie,
                                                                          arquivo
                                                                              .fullPath)
                                                                      .whenComplete(() =>
                                                                          setState(
                                                                              () {}));
                                                                  widget
                                                                      .storeProjetosIndexMenu
                                                                      .houveMudancaEmArquivosEdocumentos = true;

                                                                  AlertaSnack
                                                                      .exbirSnackBar(
                                                                          context,
                                                                          retorno);
                                                                },
                                                                    widget
                                                                        .storeProjetosIndexMenu);
                                                              }
                                                            },
                                                            child: Icon(
                                                                Icons.delete,
                                                                size: 30,
                                                                color: corTituloTexto
                                                                    .withOpacity(
                                                                        0.6)),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                          }

                          break;
                        case ConnectionState.active:
                          return const Carregando();
                        case ConnectionState.none:
                          return const Text("Erro");
                        case ConnectionState.waiting:
                          return const Carregando();
                      }
                      return SizedBox(
                        width: TamanhoTela.width(context, 1),
                        child:
                            const Center(child: Text("Não tem nenhum arquivo")),
                      );
                    }),
              ),
              Divider(
                color: corDeAcao.withOpacity(0.4),
              ),
              SizedBox(
                width: 200,
                child: ButtonWidget(
                  corIcone: corDeTextoBotaoSecundaria,
                  corBotao: corDeFundoBotaoSecundaria,
                  text: 'Selecione o Arquivo',
                  icone: Icons.attach_file,
                  clicado: () async {
                    task = null;
                    await selectFile();
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                fileName,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ButtonWidget(
                    corBotao: corDeFundoBotaoPrimaria,
                    corIcone: Colors.white,
                    text: 'Enviar Arquivo',
                    icone: Icons.cloud_upload_outlined,
                    clicado: () {
                      if (!widget.storeProjetosIndexMenu.carregando) {
                        Alerta.inserirNomeArquivo(
                            context, widget.storeProjetosIndexMenu, () async {
                          await uploadFile(widget.storeProjetosIndexMenu)
                              .whenComplete(() async {
                            await widget.controller.recuperarArquivos(
                                widget.projetoEntitie.uidProjeto);
                            setState(() {});
                            widget.storeProjetosIndexMenu
                                .houveMudancaEmArquivosEdocumentos = true;
                          });
                        });
                      }
                    }),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowCompression: true,
    );

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile(StoreProjetosIndexMenu store) async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destino =
        'arquivos/${widget.projetoEntitie.uidProjeto}/${store.nomeArquivo}.${fileName.split(".").last}';

    await widget.controller.uparArquivos(destino, file!);

    setState(() {});
  }
}

class ButtonWidget extends StatelessWidget {
  final IconData icone;
  final String text;
  final VoidCallback clicado;
  final Color corIcone;
  final Color corBotao;

  const ButtonWidget(
      {Key? key,
      required this.icone,
      required this.text,
      required this.clicado,
      required this.corIcone,
      required this.corBotao,
      carregando = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(corBotao),
        ),
        child: buildContent(),
        onPressed: clicado,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icone,
            size: 20,
            color: corIcone,
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(fontSize: 14, color: corIcone),
          ),
        ],
      );
}
