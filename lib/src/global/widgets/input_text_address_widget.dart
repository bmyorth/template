import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../models/geo_address_model.dart';
import 'input_text_widget.dart';

// ...

/// Tipo de dato utilizado
typedef InputTextAddressComponentValidator = String? Function(String value);
typedef InputTextAddressComponentOnSelect = void Function(GeoAddressModel geo);
typedef InputTextAddressComponentOnChange = String? Function(String position);

typedef InputTextSuggestionsCallback<T> = T Function(String value);

/// Componente de texto
class InputTextAddress extends StatelessWidget {
  const InputTextAddress(
      {super.key,
      this.label,
      required this.type,
      required this.controller,
      this.validate,
      this.onSelected,
      this.onChange,
      this.suggestionsCallback,
      this.style,
      this.decoration,
      this.padding,
      this.textCapitalization,
      this.obscureText = false,
      this.textInputAction = TextInputAction.done,
      this.isTextArea = false,
      this.maxLength,
      this.inputFormatters,
      this.focusNode,
      this.onTap});

  final String? label;
  final TextInputType type;
  final TextEditingController controller;
  final InputTextAddressComponentValidator? validate;
  final InputTextAddressComponentOnSelect? onSelected;
  final InputTextAddressComponentOnChange? onChange;
  final InputTextSuggestionsCallback? suggestionsCallback;
  final TextStyle? style;
  final InputDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final TextCapitalization? textCapitalization;
  final bool obscureText;
  final TextInputAction textInputAction;
  final bool isTextArea;
  final FocusNode? focusNode;
  final maxLength;
  final inputFormatters;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding del componente
      padding: padding ?? const EdgeInsets.all(0),
      // ...
      child: Column(
        children: <Widget>[
          TypeAheadField<GeoAddressModel>(
              suggestionsCallback: (pattern) {
                // ignore: prefer_null_aware_operators
                return suggestionsCallback != null
                    ? suggestionsCallback?.call(pattern)
                    : null;
              },
              builder: (context, ctrl, focusNode) {
                return InputText(
                    controller: ctrl,
                    type: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    label: label,
                    // Validar el componente en el
                    // formulario
                    validate: validate,

                    // Mayusculas en las palabras
                    textCapitalization:
                        textCapitalization ?? TextCapitalization.none,
                    // ocultar text *****
                    obscureText: obscureText,
                    onTap: onTap,

                    // Máximo de caracteres que puede escribir
                    maxLength: maxLength,
                    // Estilo principal del componente
                    style: style ??
                        const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16.0),
                    // Otros estilos del componente
                    decoration: decoration?.copyWith(
                      hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    onChange: (value) {
                      // ignore: prefer_null_aware_operators
                      return onChange != null ? onChange?.call(value) : null;
                    },

                    //format
                    inputFormatters: inputFormatters,
                    focusNode: focusNode);
              },
              controller: controller,
              hideOnEmpty: true,
              loadingBuilder: (context) => const LinearProgressIndicator(),
              itemBuilder: (context, geo) {
                return ListTile(
                  title: Text(geo.placemark.toString()),
                  // subtitle: Text(city.country),
                );
              },
              onSelected: (geo) {
                onSelected?.call(geo);
              },
              emptyBuilder: (context) {
                return Container(
                    height: 60.0,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'No hay sugerencias.',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ));
              },
              errorBuilder: (BuildContext? context, Object? error) =>
                  const SizedBox.shrink()),
        ],
      ),
    );
  }
}
