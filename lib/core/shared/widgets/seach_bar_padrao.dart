import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../core/shared/widgets/barra_de_pesquisa.dart';
import '../../../../../core/shared/widgets/fundo_cor_barra_pesquisa.dart';
import '../../../features/projeto/presentation/store/store_projeto_principal.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool notificacao;
  final StoreProjetos store;
  final String tituloPagina;
  const DefaultAppBar({
    Key? key,
    required this.tituloPagina,
    required this.store,
    this.notificacao = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  _DefaultAppBarState createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar>
    with SingleTickerProviderStateMixin {
  double rippleStartX = 0, rippleStartY = 0;
  late AnimationController _controller;
  late Animation _animation;
  bool isInSearchMode = false;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener(animationStatusListener);
  }

  animationStatusListener(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {
      setState(() {
        isInSearchMode = true;
      });
    }
  }

  void onSearchTapUp(TapUpDetails details) {
    setState(() {
      rippleStartX = details.globalPosition.dx;
      rippleStartY = details.globalPosition.dy;
    });

    _controller.forward();
  }

  cancelSearch() {
    setState(() {
      isInSearchMode = false;
    });

    onSearchQueryChange('');
    widget.store.valorPesquisa = "";
    widget.store.temPesquisa = false;
    _controller.reverse();
  }

  onSearchQueryChange(String query) {
    widget.store.temPesquisa = true;
    widget.store.valorPesquisa = query;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    GlobalKey key = GlobalKey();

    return Stack(children: [
      AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.tituloPagina,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: corTituloTexto),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              key: key,
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: corTituloTexto,
                ),
                onPressed: () {
                  RenderBox box =
                      key.currentContext!.findRenderObject() as RenderBox;
                  Offset position =
                      box.localToGlobal(Offset.zero); //this is global position
                  double y = position.dy + 25;
                  double x = position.dx + 25;

                  TapUpDetails details = TapUpDetails(
                      globalPosition: Offset(x, y),
                      kind: PointerDeviceKind.touch);
                  onSearchTapUp(details);
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Modular.to.pushNamed("/projeto/");
            },
            icon: const Icon(
              Icons.help_outlined,
              color: corTituloTexto,
            ),
          ),
          widget.notificacao
              ? IconButton(
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    color: corTituloTexto,
                  ),
                  onPressed: () {
                    Modular.to.pushNamed('notificacoes');
                  },
                )
              : const SizedBox()
        ],
        shape: Border(
          bottom: BorderSide(color: corDeAcao.withOpacity(0.7), width: 1),
        ),
      ),
      AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: MyPainter(
              containerHeight: widget.preferredSize.height,
              center: Offset(rippleStartX, rippleStartY),
              radius: _animation.value * screenWidth,
              context: context,
            ),
          );
        },
      ),
      isInSearchMode
          ? (SearchBar(
              onCancelSearch: cancelSearch,
              onSearchQueryChanged: onSearchQueryChange,
            ))
          : (Container())
    ]);
  }
}
