class VisitPlanSavedDto {
  VisitPlanSavedDto({
    required this.visitplan,
    required this.idProduk,
    required this.tipebayar,
    required this.quantity,
    required this.discount,
    required this.hargaterjual,
    required this.bonustambahan,
  });

  String visitplan;
  String idProduk;
  String tipebayar;
  String quantity;
  String discount;
  String hargaterjual;
  String bonustambahan;

  Map<String, dynamic> toJson() => {
        "visitplan": visitplan,
        "produk": idProduk,
        "tipebayar": tipebayar,
        "quantity": quantity,
        "discount": discount,
        "hargaterjual": hargaterjual,
        "bonustambahan": bonustambahan,
      };
}
