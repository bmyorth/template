import 'package:flutter/material.dart';

import 'input_label_widget.dart';

// ...

/// Tipo de dato utilizado
typedef InputTextComponentValidator = String? Function(String value);
typedef InputTextComponentOnCange = String? Function(String value);

/// Componente de texto
class InputText extends StatelessWidget {
  const InputText(
      {super.key,
      this.label,
      required this.type,
      required this.controller,
      this.validate,
      this.onChange,
      this.onEditingComplete,
      this.style,
      this.decoration,
      this.padding,
      this.textCapitalization,
      this.obscureText = false,
      this.textInputAction = TextInputAction.done,
      this.isTextArea = false,
      this.onlyRead = false,
      this.isLeft = true,
      this.maxLength,
      this.inputFormatters,
      this.focusNode,
      this.onTap});

  final String? label;
  final TextInputType type;
  final TextEditingController controller;
  final InputTextComponentValidator? validate;
  final InputTextComponentOnCange? onChange;
  final Function? onEditingComplete;
  final TextStyle? style;
  final InputDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final TextCapitalization? textCapitalization;
  final bool obscureText;
  final TextInputAction textInputAction;
  final bool isTextArea;
  final bool onlyRead;
  final bool isLeft;
  final FocusNode? focusNode;
  final maxLength;
  final inputFormatters;
  final onTap;

  @override
  Widget build(BuildContext context) {
    final lines = isTextArea ? 3 : 1;
    return Padding(
      // Padding del componente
      padding: padding ?? const EdgeInsets.all(0),
      // ...
      child: Column(
        children: <Widget>[
          // Titulo del componente
          label != null
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InputLabel(label: label!),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                  ],
                )
              : Container(),
          // Campo de texto del componente
          TextFormField(
            // Controlador del componente
            controller: controller,
            // Tipo de dato del componente
            keyboardType: type,
            // Mayusculas en las palabras
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            // ocultar text *****
            obscureText: obscureText,
            onTap: onTap,
            // Validar el componente en el
            // formulario
            validator: (String? value) {
              return validate?.call(value!);
            },
            // Mínimo de lineas
            minLines: lines,
            // Máximo de lineas
            maxLines: lines,
            // Máximo de caracteres que puede escribir
            maxLength: maxLength,
            // Estilo principal del componente
            style: style ??
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            // Otros estilos del componente
            decoration: decoration?.copyWith(
              hintStyle: const TextStyle(fontWeight: FontWeight.normal),
            ),
            // Accion de pasar al siguiente input
            textInputAction: textInputAction,
            // Solo lectura
            readOnly: onlyRead,
            //format
            inputFormatters: inputFormatters,
            // alinear
            textAlignVertical: TextAlignVertical.center,
            textAlign: isLeft ? TextAlign.left : TextAlign.right,

            focusNode: focusNode,
            // evento onchenge
            onChanged: (String? value) {
              // ignore: prefer_null_aware_operators
              onChange != null ? onChange?.call(value!) : null;
            },
            onEditingComplete: () =>
                // ignore: prefer_null_aware_operators
                onEditingComplete != null ? onEditingComplete?.call() : null,
          ),
        ],
      ),
    );
  }
}
