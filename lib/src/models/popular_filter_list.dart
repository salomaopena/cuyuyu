class PopularFilterListData {
  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<PopularFilterListData> popularFList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: 'Fora da cidade',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Promoções',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Frete acrescido',
      isSelected: true,
    ),
  ];

  static List<PopularFilterListData> productList = [
    PopularFilterListData(
      titleTxt: 'Todas',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Alimentos',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Bebidas',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Refrigerantes',
      isSelected: true,
    ),
    PopularFilterListData(
      titleTxt: 'Mais baratos',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Outras',
      isSelected: false,
    ),
  ];
}
