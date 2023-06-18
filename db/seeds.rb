# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# -*- coding: utf-8 -*-

Admin.create(id: 1, email: 'guest_admin@example.com', password: ENV['GUEST_ADMIN_PASSWORD'], project_id: ENV['GUEST_PROID'])

User.create(id: 1, email: 'guest_user@example.com', password: ENV['GUEST_USER_PASSWORD'], project_id: ENV['GUEST_PROID'])

Category.create(id: 1, title: '安全に関する項目', description: '安全に関する項目です', project_id: ENV['GUEST_PROID'], admin_id: 1)
Category.create(id: 2, title: '4Sに関する項目', description: '4Sに関する項目です', project_id: ENV['GUEST_PROID'], admin_id: 1)
Category.create(id: 3, title: '作業に関する項目', description: '作業に関する項目です', project_id: ENV['GUEST_PROID'], admin_id: 1)

Content.create(
  title: '安全に作業するために',
  category_id: 1,
  description: '安全に作業するための概要です。',
  project_id: ENV['GUEST_PROID'],
  youtube_url: 'https://youtu.be/5fibs6-C79Y',
  admin_id: 1
)
Content.create(
  title: 'ヒヤリハットに関して①',
  category_id: 1,
  description: 'ヒヤリハットとは何なのか、この動画で学びましょう',
  project_id: ENV['GUEST_PROID'],
  youtube_url: 'https://youtu.be/q9Xu3mYOR74',
  admin_id: 1
)
Content.create(
  title: 'ヒヤリハットに関する問題',
  category_id: 1,
  description: 'ヒヤリハットに関する実践演習です',
  project_id: ENV['GUEST_PROID'],
  admin_id: 1
)
Content.create(
  title: '4Sとは何か',
  category_id: 2,
  description: '4Sとはどこの作業場にも関係する問題です。',
  project_id: ENV['GUEST_PROID'],
  youtube_url: 'https://youtu.be/dIv-Fai1A48',
  admin_id: 1
)
Content.create(
  title: '5定について',
  category_id: 2,
  description: '4Sに関連する事柄に5定というものがあります。',
  project_id: ENV['GUEST_PROID'],
  admin_id: 1
)
Content.create(
  title: '保護具の着用について',
  category_id: 3,
  description: '怪我をしないためにも保護具の着用は必須です。',
  video:File.open("./public/uploads/videos/sample.mp4"),
  project_id: ENV['GUEST_PROID'],
  admin_id: 1
)
Content.create(
  title: '【工具】インパクトについて',
  category_id: 3,
  description: '4Sとはどこの作業場にも関係する問題です。',
  project_id: ENV['GUEST_PROID'],
  youtube_url: 'https://youtu.be/vWDAAoswfw4',
  admin_id: 1
)
Content.create(
  title: 'コネクタの接続について',
  category_id: 3,
  description: '4Sとはどこの作業場にも関係する問題です。',
  project_id: ENV['GUEST_PROID'],
  youtube_url: 'https://youtu.be/XZggMcS11TQ',
  admin_id: 1
)



