class Size1{
  double ? std_font_size ;
  double ? std_icon_size ;
  double ? std_container_height ;
  double ? std_container_width ;
  double ? std_padding_top ;
  double ? std_padding_bottom ;
  double ? std_padding_left ;
  double ? std_padding_right ;
  double ? std_padding_horizontal ;
  double ? std_padding_vertical ;
  double ? std_border_radius ;
  double ? std_container_margin ;
  double ? std_container_border_width ;
  Size1(double width, double height){
    std_font_size = 0.02*width + 0.028*height;
    std_icon_size = 0.3*width + 0.25*height;
    std_container_height =0.2*height;
    std_container_width =width ;
    std_padding_top =0.0625*height;
    std_padding_bottom = 0.0625*height;
    std_padding_left = 0.05*width;
    std_padding_right = 0.05*width;
    std_padding_horizontal = 0.05*width;
    std_padding_vertical = 0.0625*height;
    std_border_radius = 0.7*height;
    std_container_margin = 0.02*width;
    std_container_border_width = height/360;
  }
}