enum PageName {
  Home("/"),
  AddPage("/add-page"),
  WishListPage("/wish-list-page");

  final String path;
  const PageName(this.path);
}