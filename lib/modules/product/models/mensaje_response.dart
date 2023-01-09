import 'dart:convert';

class MensajeResponse {
    bool estado;
    String msj;

    MensajeResponse({
        required this.estado,
        required this.msj,
    });


    factory MensajeResponse.fromJson(String str) => MensajeResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MensajeResponse.fromMap(Map<String, dynamic> json) => MensajeResponse(
        estado : json["estado"],
        msj    : json["msj"],
    );

    Map<String, dynamic> toMap() => {
        "estado" : estado,
        "msj"    : msj,
    };
}