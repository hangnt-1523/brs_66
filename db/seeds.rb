user = User.new username: "Admin",
             email: "admin@gmail.com",
             password: "123456",
             avatar: "",
             password_confirmation: "123456",
             admin: true
user.skip_confirmation!
user.save!

user2 = User.new username: "User",
             email: "user1@gmail.com",
             password: "123456",
             avatar: "",
             password_confirmation: "123456",
             admin: false
user2.skip_confirmation!
user2.save!

Category.create!([{
  title: "Ruby",
  description: "Ruby là một ngôn ngữ lập trình hướng đối tượng,
    có khả năng phản ứng. Theo tác giả, Ruby chịu ảnh hưởng bởi Perl, Smalltalk,
    Eiffel, Ada và Lisp. Ruby là ngôn ngữ thông dịch và hướng đối tượng."
},
{
  title: "Ruby on Rails",
  description: "Ruby On rails là một Framework cho phép phát triển ứng dụng Web
    gồm 2 phần cơ bản: Phần ngôn ngữ Ruby: “Ruby là một ngôn lập trình mã
    nguồn mở, linh hoạt, với một sự nổi bật về sự đơn giản dễ dùng và hữu ích.
    Nó có cú pháp “tao nhã” và tự nhiên dễ đọc và dễ dàng để viết”."
},
{
  title: "PHP",
  description: "PHP là một ngôn ngữ lập trình kịch bản hay một loại mã lệnh
    chủ yếu được dùng để phát triển các ứng dụng viết cho máy chủ,
    mã nguồn mở, dùng cho mục đích tổng quát. Nó rất thích hợp với web và
    có thể dễ dàng nhúng vào trang HTML..."
},
{
  title: "MySql",
  description: "MySQL là hệ quản trị cơ sở dữ liệu tự do nguồn mở phổ biến nhất
    thế giới và được các nhà phát triển rất ưa chuộng trong quá trình
    phát triển ứng dụng."
}])

Author.create!([{
  name: "Michael Hartl",
  brith_year: "1978-06-08",
  country: "American",
  biography: "Michael Hartl is founder of the educational website
    LearnEnough.com and author of the Ruby on Rails Tutorial,
    the leading introduction to web development with Rails. "
},
{
  name: "Robin Nixon",
  brith_year: "1978-06-08",
  country: "New Romney, United Kingdom",
  biography: "Robin Nixon has worked with and written about computers
    since the early 1980s. During this time he has written in excess of
    500 articles for many of the UK's top computer magazines."
},
{
  name: "David Heinemeier Hansson",
  brith_year: "1978-06-08",
  country: "Chicago",
  biography: "David Heinemeier Hansson is a partner at 37signals,
    a privately-held Chicago-based company committed to building the best
    web-based tools possible with the least number of features necessary."
},
{
  name: "Dave Thomas",
  brith_year: "1932-07-02",
  country: "American",
  biography: "He's a programmer, and now He's an accidental publisher.
    I wrote The Pragmatic Programmer with Andy Hunt at the end of the '90s,
    and that experience opened a new world for us."
},
{
  name: "Daniel Kehoe",
  brith_year: "1978-06-08",
  country: "San Francisco, California",
  biography: "He's a Senior Ruby on Rails Developer,
    currently available for remote work."
}])
