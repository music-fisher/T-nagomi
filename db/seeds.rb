# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!([
  {
    email: 'test1@test.com',
    name: '酒井 俊輔',
    password: 'password',
    password_confirmation: 'password',
    profile_image: File.open('public/images/test_user1.jpg')
  },
  {
    email: 'test2@test.com',
    name: '石川 智弘',
    password: 'password',
    password_confirmation: 'password',
    profile_image: File.open('public/images/test_user2.jpg')
  },
    {
    email: 'test3@test.com',
    name: '市川 正行',
    password: 'password',
    password_confirmation: 'password',
    profile_image: File.open('public/images/test_user3.jpg')
  },
    {
    email: 'test4@test.com',
    name: '永井 卓',
    password: 'password',
    password_confirmation: 'password',
    profile_image: File.open('public/images/test_user4.jpg')
  },
    {
    email: 'test5@test.com',
    name: '相馬 裕',
    password: 'password',
    password_confirmation: 'password',
    profile_image: File.open('public/images/test_user5.jpg')
  },
    {
    email: 'test6@test.com',
    name: '川本 亜希',
    password: 'password',
    password_confirmation: 'password',
    profile_image: File.open('public/images/test_user6.jpg')
  },
    {
    email: 'test7@test.com',
    name: '宮下 結花',
    password: 'password',
    password_confirmation: 'password',
    profile_image: File.open('public/images/test_user7.jpg')
  },
    {
    email: 'test8@test.com',
    name: '石塚 百合',
    password: 'password',
    password_confirmation: 'password',
    profile_image: File.open('public/images/test_user8.jpg')
  },
    {
    email: 'test9@test.com',
    name: '北原 麻実',
    password: 'password',
    password_confirmation: 'password',
    profile_image: File.open('public/images/test_user9.jpg')
  },
    {
    email: 'test10@test.com',
    name: '江口 果奈',
    password: 'password',
    password_confirmation: 'password',
    profile_image: File.open('public/images/test_user10.jpg')
  }
  ]
  )

  User.all.each do |user|
    user.posts.create!(
      title: 'お茶淹れてみました！',
      body: '仕事の合間に、ちょっと一休みでお茶を淹れてみました。
      やっぱりほっとしますね〜',
      post_image: File.open('public/images/greentea.jpg')
      )
  end