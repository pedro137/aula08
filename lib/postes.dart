class Postes {
  final int idUsuario;
  final int id;
  final String titulo;

  const Postes({
    required this.idUsuario,
    required this.id,
    required this.titulo,
  });

  factory Postes.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int idUsuarioR,
        'id': int idR,
        'title': String tituloR,
      } =>
        Postes(
          idUsuario: idUsuarioR,
          id: idR,
          titulo: tituloR,
        ),
      _ => throw const FormatException('Falha ao carregar Poste.'),
    };
  }
}
