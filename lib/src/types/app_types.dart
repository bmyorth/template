// Tipos de botones de la app
// PRIMARY : redondeado con fondo primario
// SECUNDARY : redondado fondo tranparente y con borde
// ACCENT : redondeado con fondo gris usado para cancelar y demas
// WHITE : redondeado con fondo blanco
enum BUTTONTYPE { PRIMARY, SECUNDARY, ACCENT, WHITE }

enum InputType {
  EMAIL,
  PASSWORD,
  USER,
}

enum DialogButtonType {
  LEFT,
  MEDIUM,
  RIGHT,
}

extension ParseInputTypeToString on InputType {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension ParseDialogButtonTypeString on DialogButtonType {
  String toShortString() {
    return toString().split('.').last;
  }
}
