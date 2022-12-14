#### 名前付きルート
-----------------------------------------------
get 'homes/about' => 'homes#about', as: 'about'
-----------------------------------------------

####　ネスト
##### 親のresourcesで指定したコントローラ名に、子のresourcesで指定したコントローラ名が続くURLが生成されるのが確認できます。
このような親子関係を、「ネストする」と言います。
上記のようなネストしたURLを作成することでparams[:post_image_id]でPostImageのidが取得できるようになります。

#### favorited_by?メソッドを作成します。 このメソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。 存在していればtrue、存在していなければfalseを返すようにしています。
-------------------------------------
def favorited_by?(user)
  favorites.exists?(user_id: user.id)
end
-------------------------------------

#### resources
#### resource
#### 単数形にすると、/:idがURLに含まれなくなります。

#### コメント機能では「1人のユーザが１つの投稿に対して何度でもコメントできる」という仕様だったため、destroyをする際にidを受け渡して「どのコメントを削除するのか」を指定する必要がありました。 destroyアクションの場合、URLは'/post_images/:post_image_id/post_comments/:id'のようになっており、URLの最後に/:idが含まれます。コントローラで「params[:id]」と記述することで、このURLに含まれる:idを取得できるのでした。しかし、いいね機能の場合は「1人のユーザーは1つの投稿に対して1回しかいいねできない」という仕様であるため、destroyをする際にもユーザーidと投稿(post_image)idが分かれば、どのいいねを削除すればいいのかが特定できます。 そのため、いいねのidはURLに含める必要がない(params[:id]を使わなくても良い)ため、resourcesではなくresourceを使ってURLに/:idを含めない形にしています。このように、resourceは「それ自身のidが分からなくても、関連する他のモデルのidから特定できる」といった場合に用いることが多いです。

-------------------------------------------------
before_action :authenticate_user!, except: [:top]
-------------------------------------------------
#### before_actionメソッドは、このコントローラが動作する前に実行されます。 今回の場合、app/controllers/application_controller.rbファイルに記述したので、 すべてのコントローラで、最初にbefore_actionメソッドが実行されます。
#### authenticate_userメソッドは、devise側が用意しているメソッドです。 :authenticate_user!とすることによって、「ログイン認証されていなければ、ログイン画面へリダイレクトする」機能を実装できます。
#### exceptは指定したアクションをbefore_actionの対象から外します。 Meshiterroではトップページのみログイン状態に関わらず、アクセス可能とするためにtopアクションを指定しています。

------------------------------------------------------------
<% if @post_image.errors.any? %>
  <%= @post_image.errors.count %>件のエラーが発生しました
  <ul>
    <% @post_image.errors.full_messages.each do |message| %>
      <li><%= message %></li>
    <% end %>
  </ul>
<% end %>
------------------------------------------------------------
#### errorsは、モデルにバリデーションをかけたときに、発生したエラーの内容を確認できるメソッドです。 any?と組み合わせることで、エラーが発生しているかどうかを判定できます。 また、full_messageと組み合わせることで、エラーの内容を出力できます。 エラー文は配列で保存されているため、eachを使います。

#### ページネーション
-------------------------
Gemfile
-------------------------
gem 'kaminari','~> 1.2.1'
--------------------------------------------------
username:~/environment/meshiterro $ bundle install
-----------------------------------------------------------
username:~/environment/meshiterro $ rails g kaminari:config
------------------------------------------------------------------
username:~/environment/meshiterro $ rails g kaminari:views default
------------------------------------------------------------------