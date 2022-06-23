import 'dart:io';
import 'package:estimasoft/core/shared/utils.dart';
import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:estimasoft/core/shared/utils/snackbar.dart';
import 'package:estimasoft/core/shared/utils/tamanho_tela.dart';
import 'package:estimasoft/features/projeto/domain/entitie/projeto_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/bottom_navigation_bar/home/store/store_projeto_index_menu.dart';
import 'package:estimasoft/features/projeto/presentation/projeto_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path/path.dart';

class InsercaoArquivosUpload extends StatefulWidget {
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
        child: Container(
          width: TamanhoTela.width(context, 1),
          height: TamanhoTela.height(context, 1),
          padding: paddingPagePrincipal,
          // padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: background, borderRadius: arredondamentoBordas),
                height: 300,
                child: widget.controller.arquivos.items.isNotEmpty
                    ? ListView.builder(
                        itemCount: widget.controller.arquivos.items.length,
                        itemBuilder: (context, index) {
                          final arquivo =
                              widget.controller.arquivos.items[index];
                          return SizedBox(
                            height: 70,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 80,
                                            child: Icon(
                                              Icons.drive_file_move,
                                              size: 40,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 60,
                                                child: Text(
                                                  arquivo.fullPath
                                                      .split("/")
                                                      .last
                                                      .split(".")[0],
                                                  textAlign: TextAlign.right,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: (const TextStyle(
                                                      fontSize:
                                                          tamanhoTextoCorpoTexto,
                                                      color: corCorpoTexto)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 40,
                                                child: Text(
                                                  "." +
                                                      arquivo.fullPath
                                                          .split(".")[1],
                                                  maxLines: 1,
                                                  style: (const TextStyle(
                                                      fontSize:
                                                          tamanhoTextoCorpoTexto,
                                                      color: corCorpoTexto)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: 40,
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  var retorno = await widget
                                                      .controller
                                                      .removerArquivoProjeto(
                                                          widget.projetoEntitie,
                                                          arquivo.fullPath)
                                                      .whenComplete(() =>
                                                          setState(() {}));
                                                  widget.storeProjetosIndexMenu
                                                          .houveMudancaEmArquivosEdocumentos =
                                                      true;

                                                  AlertaSnack.exbirSnackBar(
                                                      context, retorno);
                                                },
                                                child: Icon(Icons.delete,
                                                    size: 30,
                                                    color: corTituloTexto
                                                        .withOpacity(0.6)),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  var retorno = await widget
                                                      .controller
                                                      .fazerDownloadArquivos(
                                                          widget.projetoEntitie
                                                              .uidProjeto,
                                                          arquivo.fullPath);
                                                },
                                                child: Icon(
                                                  Icons
                                                      .download_for_offline_sharp,
                                                  size: 30,
                                                  color: Colors.deepPurple
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          "Projeto não tem nenhum documento",
                          style: TextStyle(color: corCorpoTexto),
                        ),
                      ),
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
              const SizedBox(height: 48),
              SizedBox(
                width: 200,
                child: ButtonWidget(
                    corBotao: corDeFundoBotaoPrimaria,
                    corIcone: Colors.white,
                    text: 'Enviar Arquivo',
                    icone: Icons.cloud_upload_outlined,
                    clicado: () {
                      uploadFile().whenComplete(() async {
                        await widget.controller.recuperarArquivos(
                            widget.projetoEntitie.uidProjeto);
                        setState(() {});
                        widget.storeProjetosIndexMenu
                            .houveMudancaEmArquivosEdocumentos = true;
                      });
                    }),
              ),
              const SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destino = 'arquivos/${widget.projetoEntitie.uidProjeto}/$fileName';

    task = widget.controller.uparArquivos(destino, file!);
    setState(() {});

    if (task == null) return;

    //final snapshot =
    await task!.whenComplete(() {});
    //  final urlDownload = await snapshot.ref.getDownloadURL();
    //  setState(() {});
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progresso = snap.bytesTransferred / snap.totalBytes;
            final porcentagem = (progresso * 100).toStringAsFixed(2);
            if (porcentagem == "100 %") {}

            return Text(
              '$porcentagem %',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}

class ButtonWidget extends StatelessWidget {
  final IconData icone;
  final String text;
  final VoidCallback clicado;
  final Color corIcone;
  final Color corBotao;

  const ButtonWidget({
    Key? key,
    required this.icone,
    required this.text,
    required this.clicado,
    required this.corIcone,
    required this.corBotao,
  }) : super(key: key);

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
