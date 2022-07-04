import 'package:estimasoft/core/shared/utils/cores_fontes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar({
    Key? key,
    required this.onCancelSearch,
    required this.onSearchQueryChanged,
  }) : super(key: key);

  final VoidCallback onCancelSearch;
  final Function(String) onSearchQueryChanged;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  String searchQuery = '';
  final TextEditingController _searchFieldController = TextEditingController();

  clearSearchQuery() {
    _searchFieldController.clear();
    widget.onSearchQueryChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: corTituloTexto),
                onPressed: widget.onCancelSearch,
              ),
              Expanded(
                child: TextField(
                  controller: _searchFieldController,
                  cursorColor: corTituloTexto,
                  onTap: () {},
                  style: const TextStyle(color: corTituloTexto, fontSize: 18),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: corTituloTexto),
                    hintText: "Pesquisar",
                    hintStyle: const TextStyle(color: corTituloTexto),
                    suffixIcon: InkWell(
                      child: const Icon(Icons.close, color: corTituloTexto),
                      onTap: clearSearchQuery,
                    ),
                  ),
                  onChanged: widget.onSearchQueryChanged,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
