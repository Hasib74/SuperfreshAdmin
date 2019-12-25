import 'package:super_fresh_admin/Model/Comments.dart';

class MBanner {
  List<Comments> comments_list;

  var description;
  var discount;
  var id;
  var image;
  var name;
  var price;
  var rating;

  MBanner(
      {this.comments_list,
      this.rating,
      this.name,
      this.image,
      this.id,
      this.price,
      this.description,
      this.discount});
}
