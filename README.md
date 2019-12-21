# Microverse Project Title - Final Project [Collaborative Project]
Ruby on Rails

### Introduction.
This project requests you to build a Facebook-like social network application.

Full task description: https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project

### Microverse Adjustments

* Skip points 16 about setting up a mailer - you will be able to do it if you complete extra task in next steps (which is optional).

* According to requirements first you should: “Think through the data architecture required to make this work. There are a lot of models and a lot of associations, so take the time to plan out your approach.” Keep that in your mind.

### Project specific

###  Ruby version

rbenv 2.6.5

###  System dependencies

Rails 6.0.2

Yarn 1.19.1

Ubuntu 18.04 & below

###  Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### Milestone 1: Prepare data architecture documentation

Create Entity Relationship Diagram (ERD) for the following tables and its content.

1. Friendship
ID: Integer
Status: boolean
user_id: Integer
friend_id: Integer


2. User
ID: Integer
name: text
email: text
password: text

3. Post
ID: Integer
user_id: Integer
CONTENT: text

4. Like
ID: Integer
user_ID: Integer
post_ID: Integer

5. Comment
ID: Integer
post_id: Integer
user_id: Integer
CONTENT: text

### Milestone 2: Project setup

1. Use Postgresql for your database from the beginning (not sqlite3), that way your deployment to Heroku will go much more smoothly. See the [Heroku Docs](https://devcenter.heroku.com/articles/getting-started-with-rails4) for setup info.
## Create postgres DB
```sh
# config/database.yml

default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  adapter: postgresql
  encoding: unicode
  database: rails_facebook_development
  username: rails_facebook
  password: rails_facebook
  host: 127.0.0.1

test:
  adapter: postgresql
  encoding: unicode
  database: rails_facebook_test
  username: rails_facebook
  password: rails_facebook
  host: 127.0.0.1

production:
  adapter: postgresql
  encoding: unicode
  database: rails_facebook_production
  username: rails_facebook
  password: rails_facebook
  host: 127.0.0.1

postgres=# CREATE DATABASE rails_facebook_development
postgres=# CREATE DATABASE rails_facebook_test
postgres=# CREATE DATABASE rails_facebook_production
```
## Rails with postgresql in Ubutu
```sh
sudo -u postgres createuser -s railsdevuser
sudo -u postgres psql
postgres=# \password railsdevuser
Enter new password:
Enter it again:
\q

#Telling rails to used postgresql
$ rails new societalbook -T -d postgresql

# ./gemfile
.
gem 'devise'
.
.


$ curl -sL https://deb.nodesource.com/setup_10.x 9 | sudo -E bash -

## Installing the NodeSource Node.js 10.x repo...
.
.

$ sudo apt-get install -y nodejs
Reading package lists... Done
Building dependency tree
Reading state information... Done
.
.

$ bundle install
The dependency tzinfo-data (>= 0) will be unused by any of the platforms Bundler is installing for. Bundler is installing for ruby but the dependency is only for x86-mingw32, x86-mswin32, x64-mingw32, java. To add those platforms to the bundle, run `bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java`.
Using rake 13.0.1
Using concurrent-ruby 1.1.5
.
.
.
```

2. Users must sign in to see anything except the sign in page.
# Intalling devise via rails
```sh
$ rails generate devise:install
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
.
.
```

```sh
$ rails generate devise User
      invoke  active_record
      create    db/migrate/20191204202822_devise_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
      insert    app/models/user.rb
       route  devise_for :users

$ rails g devise:views
      invoke  Devise::Generators::SharedViewsGenerator
      create    app/views/devise/shared
      create    app/views/devise/shared/_error_messages.html.erb
      create    app/views/devise/shared/_links.html.erb
.
.

$ rails generate migration add_name_to_users name:string
      invoke  active_record
      create    db/migrate/20160130022556_add_name_to_users.rb

## Create the databases via rails
```sh
$ rails db:create
Created database 'rails_facebook_development'
Created database 'fails_facebook_test'
```

$ rails db:migrate
== 20191204202822 DeviseCreateUsers: migrating ================================
-- create_table(:users)
   -> 0.0038s
-- add_index(:users, :email, {:unique=>true})
   -> 0.0020s
-- add_index(:users, :reset_password_token, {:unique=>true})
   -> 0.0010s
== 20191204202822 DeviseCreateUsers: migrated (0.0158s) =======================

```

```ruby
# config/routes.rb

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
.
.
```

```sh

$ rails generate devise:controllers users

      create  app/controllers/users/confirmations_controller.rb
      create  app/controllers/users/passwords_controller.rb
      create  app/controllers/users/registrations_controller.rb
      create  app/controllers/users/sessions_controller.rb
      create  app/controllers/users/unlocks_controller.rb
      create  app/controllers/users/omniauth_callbacks_controller.rb
```

```ruby
# app/controller/users/registractiosn_controller.rb

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  def cancel
    super
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation current_password])
  end
end

# config/environments/development.rb

config.action_mailer.default_url_options = { :host => 'localhost:3000' }
```

```erb
# app/views/devise/registration/new.html.erb

<h2>Sign up</h2>

<%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
  <%= render "devise/shared/error_messages", resource: resource %>

  <div class="name">
    <%= f.label :name %><br />
    <%= f.text_field :name, autofocus: true %>
  </div>

  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autofocus: true, autocomplete: "email" %>
  </div>

  <div class="field">
    <%= f.label :password %>
    <% if @minimum_password_length %>
    <em>(<%= @minimum_password_length %> characters minimum)</em>
    <% end %><br />
    <%= f.password_field :password, autocomplete: "new-password" %>
  </div>

  <div class="field">
    <%= f.label :password_confirmation %><br />
    <%= f.password_field :password_confirmation, autocomplete: "new-password" %>
  </div>

  <div class="actions">
    <%= f.submit "Sign up" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>
```
```erb
# app/views/devise/registration/edit.html.ern

<h2>Edit <%= resource_name.to_s.humanize %></h2>

<%= form_for(resource, as: resource_name, url: registration_path(resource_name), html: { method: :put }) do |f| %>
  <%= render "devise/shared/error_messages", resource: resource %>

  <div class="name">
    <%= f.label :name %><br />
    <%= f.text_field :name, autofocus: true %>
  </div>

  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autofocus: true, autocomplete: "email" %>
  </div>

  <% if devise_mapping.confirmable? && resource.pending_reconfirmation? %>
    <div>Currently waiting confirmation for: <%= resource.unconfirmed_email %></div>
  <% end %>

  <div class="field">
    <%= f.label :password %> <i>(leave blank if you don't want to change it)</i><br />
    <%= f.password_field :password, autocomplete: "new-password" %>
    <% if @minimum_password_length %>
      <br />
      <em><%= @minimum_password_length %> characters minimum</em>
    <% end %>
  </div>

  <div class="field">
    <%= f.label :password_confirmation %><br />
    <%= f.password_field :password_confirmation, autocomplete: "new-password" %>
  </div>

  <div class="field">
    <%= f.label :current_password %> <i>(we need your current password to confirm your changes)</i><br />
    <%= f.password_field :current_password, autocomplete: "current-password" %>
  </div>

  <div class="actions">
    <%= f.submit "Update" %>
  </div>
<% end %>

<h3>Cancel my account</h3>

<p>Unhappy? <%= button_to "Cancel my account", registration_path(resource_name), data: { confirm: "Are you sure?" }, method: :delete %></p>

<%= link_to "Back", :back %>

```

3. User sign-in should use the [Devise](https://github.com/plataformatec/devise) gem. Devise gives you all sorts of helpful methods so you no longer have to write your own user passwords, sessions, and #current_user methods. See the [Railscast](http://railscasts.com/episodes/209-introducing-devise?view=asciicast) (which uses Rails 3) for a step-by-step introduction. The docs will be fully current.
```sh
$ rails generate controller home
      create  app/controllers/home_controller.rb
      invoke  erb
      create    app/views/home
      invoke  helper
      create    app/helpers/home_helper.rb
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/home.scss

```

```erb

```ruby
# config/routes.rb

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "home#start"
.
.
end

```

```ruby
# models/user.rb
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable and :activatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
```

## Milestone 3: Users & posts

Create models with associations and implement all requested features for users and posts. Add authentication with Devise as described in requirements.

Remember about unit and integrations tests!

## Gravatar Setup

Gravatar stands for Globally Recognized Avatar. It is globally recognized because millions of people and websites use them. Most popular applications like WordPress have built-in support for Gravatar. When a user leaves a comment (with email) on a site that supports Gravatar, it pulls their Globally Recognized Avatar from Gravatar servers. Then that picture is shown next to the comment. This allows each commenter to have their identity through out the world wide web.

[source](https://www.wpbeginner.com/beginners-guide/what-is-gravatar-and-why-you-should-start-using-it-right-away/)

For the purpose of this project, Gravatar will be used for added aesthetics.

```ruby
# app/helpers/users_help.rb

module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
```

# Post functionality

1. Generate a Post model via rails and make the corresponding migration as follows:

## Generate/Setup post model & DB tables

```sh
$ rails generate model post content:text
Running via Spring preloader in process 3891
invoke  active_record
create    db/migrate/20191205215847_create_posts.rb
create    app/models/post.rb
invoke    test_unit
create      test/models/post_test.rb
create      test/fixtures/posts.yml
```
```ruby
#db/migrate/timestamp_create_posts.rb
class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :content

      t.timestamps
    end
  end
end
```
```sh
$ rails db:migrate
== 20191205204514 AddNameToUsers: migrating ===================================
-- add_column(:users, :name, :string)
   -> 0.0016s
== 20191205204514 AddNameToUsers: migrated (0.0016s) ==========================

== 20191205215847 CreatePosts: migrating =================================
-- create_table(:posts)
   -> 0.0585s
== 20191205215847 Createposts: migrated (0.0585s) ========================
```
```ruby
# app/models/post.rb

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :content, length: { maximum: 255 }, presence: true
end
```

2. After the post model is generated we need to map the routes for the post actions.

```ruby
# config/routes.rb

Rails.application.routes.draw do
.
.
  resources :posts, only: [:create, :destroy, :index, :show,:new]
.
.
```

3. Posts controllers is generated to interact between model and view

```sh
$ rails generate controller posts
create  app/controllers/posts_controller.rb
invoke  erb
create    app/views/posts
invoke  test_unit
create    test/controllers/posts_controller_test.rb
invoke  helper
create    app/helpers/posts_helper.rb
invoke    test_unit
invoke  assets
invoke    scss
create      app/assets/stylesheets/posts.scss
```

4. Generate a DB table to Associate posts to user via migration:

```sh
$ rails g migration add_user_id_to_posts user:references
invoke  active_record
create    db/migrate/20191205235313_add_user_id_to_posts.rb
$ rails db:migrate
== 20191205235313 AddUserIdToPosts: migrating ============================
== 20191205235313 AddUserIdToPosts: migrated (0.0000s) ===================
```

```ruby
# db/migrate/timestamp_add_user_id_to_post.rb

class AddUserIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
  end
end
```

5. Setup Post controller for model to interact with view

```ruby
class PostsController < ApplicationController
  before_action :find_post, except: %i[new create index]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :require_login

  def index
    @post = Post.new
    @users = User.all
    @comment = Comment.create
  end

  def new
    @post = current_user.posts.build
  end

  def show; end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.valid?
      @post.save
      redirect_to posts_url
    else
      render 'new'
    end
  end

  def def(_update)
    if @post.update(params[:post][:content])
      flash[:success] = 'Post was successfully updated'
      redirect_to @post
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
```

5. Generate & setup User model
```sh
$ rails generate model user
      invoke  active_record
      create    db/migrate/20191212161226_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
```
```ruby
# db/migrate/timestamp_devise_create_users.rb

# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
```

```ruby
# app/model/user.rb

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :likes, dependent: :destroy
  validates :name, presence: true
end
```


6. Generate & setup users controller
```sh
$ rails generate controller users
      create  app/controllers/users_controller.rb
      invoke  erb
      create    app/views/users
      invoke  test_unit
      create    test/controllers/users_controller_test.rb
      invoke  helper
      create    app/helpers/users_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/users.scss`
```
```ruby
# app/controller/users_controller.rb

class UsersController < ApplicationController
  def show
  end

  def edit
  end
end

# app/controllers/users/registrations_controller.rb

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation current_password])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
```

# Rspec test Setup

Ensure rspec-rails present in both the :development and :test groups of your app’s Gemfile:
```sh
# Run against the latest stable release
group :development, :test do
  gem 'rspec-rails', '~> 4.0'
end

```

Then, in your project directory:
```sh
# Download and install
$ bundle update
$ bundle install
$ bundle update rspec-rails

# Generate boilerplate configuration files
# (check the comments in each generated file for more information)
$ rails generate rspec:install
      create  .rspec
      create  spec
      create  spec/spec_helper.rb
      create  spec/rails_helper.rb
```

Create boilerplate specs with rails generate after coding is complete

```sh
# RSpec also provides its own spec file generators
$ rails generate rspec:model user
      create  spec/models/user_spec.rb
```

# Milestone 4: Comments & likes

Create models with associations and implement all requested features for comments and likes.

Remember about unit and integrations tests!

1. Generate & setup comment model & DB
```sh
$ rails generate model comment
      invoke  active_record
      create    db/migrate/20191212163355_create_comments.rb
      create    app/models/comment.rb
      invoke    test_unit
      create      test/models/comment_test.rb
      create      test/fixtures/comments.yml
```

```ruby
# app/model/comment.rb

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true
end
```

```ruby
# db/migrate/timestamp_create_comments.rb

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :replay

      t.timestamps
    end
  end
end
```

** Run rails db:migrate command

2. Generate & setup comments controller

```sh
$ rails generate controller comments
      create  app/controllers/comments_controller.rb
      invoke  erb
      create    app/views/comments
      invoke  test_unit
      create    test/controllers/comments_controller_test.rb
      invoke  helper
      create    app/helpers/comments_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/comments.scss
```
```ruby
# app/controllers/comments_controller.rb

# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.valid?
      @comment.save
    else
      flash[:alert] = 'You can not create an empty comment!'
    end
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
```

** Run rails db:migrate command

3. Generate & setup like model & DB
```sh
$ rails generate model like
      invoke  active_record
      create    db/migrate/20191212164601_create_likes.rb
      create    app/models/like.rb
      invoke    test_unit
      create      test/models/like_test.rb
      create      test/fixtures/likes.yml
```

```ruby
# app/model/like.rb

class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :user_id, uniqueness: { scope: :post_id }
end
```

```ruby
# db/migrate/timestamp_create_likes.rb

class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :post

      t.timestamps
    end
  end
end
```

4. Generate & setup likes controller

```sh
$ rails generate controller likes
      create  app/controllers/likes_controller.rb
      invoke  erb
      create    app/views/likes
      invoke  test_unit
      create    test/controllers/likes_controller_test.rb
      invoke  helper
      create    app/helpers/likes_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/likes.scss
```

```ruby
class LikesController < ApplicationController
  before_action :require_login

  def create
    @like = Like.new(like_params)

    if @like.valid?
      @like.save
    else
      flash[:alert] = 'You have already liked this post!'
    end
    if request.referrer
      redirect_to request.referrer
    else
      redirect_to root_path
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
```
```ruby
  module PostsHelper
  def liked?(id)
    !current_user.likes.map(&:post_id).include? id
  end
end
```

6. Setup routes for comments & likes
```ruby
Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
   root to: "posts#index"

   resources :posts, only: [:create, :destroy, :index, :show,:new]
   resources :users
   resources :likes, only: [:create]
   resources :comments, only: [:create]
end

```

# Milestone 5: Friendships V1

Create a model with associations and all requested features for friendships. Hint with spoiler alert: If you are stuck, read this article https://smartfunnycool.com/friendships-in-activerecord/.

IMPORTANT NOTE: In the next milestone, you will make friendships associations more efficient. In this one, let’s prepare the working version of the feature.

Remember about unit and integrations tests!

1. Generate & setup friendship model & DB

```sh
$ rails g model friendship user:references friend:references status:boolean  
      invoke  active_record
      create    db/migrate/20191212212954_create_friendships.rb
      create    app/models/friendship.rb
      invoke    test_unit
      create      test/models/friendship_test.rb
      create      test/fixtures/friendships.yml
```

```ruby
# db/migrate/timestamp_create_friendships.rb

class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friend, index: true
      t.boolean :confirmed

      t.timestamps null: false
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
```

```ruby
# app/models/friendship.rb

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"
end
```

```sh
$ rails db:migrate

== 20191212201303 CreateFriendships: migrating ================================
-- create_table(:friendships)
   -> 0.6539s
-- add_foreign_key(:friendships, :users, {:column=>:friend_id})
   -> 0.0032s
== 20191212201303 CreateFriendships: migrated (0.6584s) =======================
```

2. Setup friendship in user model & DB

```ruby
# app/models/user.rb

class User < ApplicationRecord
.
.
  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
.
.
  def friends
    friends_array = friendships.map{|friendship| friendship.friend if friendship.status}
    friends_array += inverse_friendships.map{|friendship| friendship.user if friendship.status}
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.status}.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.status}.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.status = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
```

3. Generate and setup friendships controller
```sh
rails generate controller friendships
      create  app/controllers/friendships_controller.rb
      invoke  erb
      create    app/views/friendships
      invoke  rspec
      create    spec/controllers/friendships_controller_spec.rb
      invoke  helper
      create    app/helpers/friendships_helper.rb
      invoke    rspec
      create      spec/helpers/friendships_helper_spec.rb
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/friendships.scss
```

```ruby
# app/controller/friendships_controller.rb
````

4. Create friendship between users via rails console
```sh
2.6.5 :002 > u1 = User.find(1)
  User Load (1.5ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
 => #<User id: 1, email: "batman@email.com", created_at: "2019-12-11 22:40:48", updated_at: "2019-12-11 22:40:48", name: "batman">
2.6.5 :003 > u2 = User.find(2)
  User Load (1.6ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
 => #<User id: 2, email: "hackernoon@email.com", created_at: "2019-12-12 14:05:22", updated_at: "2019-12-12 14:05:22", name: "hacker noon">

Friendship.all
  Friendship Load (2.9ms)  SELECT "friendships".* FROM "friendships" LIMIT $1  [["LIMIT", 11]]
 => #<ActiveRecord::Relation []>

2.6.5 :068 > f = Friendship.create(user_id: u2.id, friend_id: u1.id, status: false)
   (1.9ms)  BEGIN
  User Load (1.8ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
  User Load (1.0ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  Friendship Create (1.4ms)  INSERT INTO "friendships" ("user_id", "friend_id", "status", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["user_id", 2], ["friend_id", 1], ["status", false], ["created_at", "2019-12-12 22:08:53.549844"], ["updated_at", "2019-12-12 22:08:53.549844"]]
   (125.8ms)  COMMIT
 => #<Friendship id: 3, user_id: 2, friend_id: 1, status: false, created_at: "2019-12-12 22:08:53", updated_at: "2019-12-12 22:08:53">

2.6.5 :009 > f
 => #<Friendship id: 1, user_id: 1, friend_id: 2, status: false, created_at: "2019-12-12 21:45:26", updated_at: "2019-12-12 21:45:26">

2.6.5 :014 > u2.friend?(u1)
  Friendship Load (1.2ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."user_id" = $1  [["user_id", 2]]
  Friendship Load (3.2ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."friend_id" = $1  [["friend_id", 2]]
 => true

2.6.5 :015 > u1.friend?(u2)
  Friendship Load (1.6ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."user_id" = $1  [["user_id", 1]]
  Friendship Load (1.3ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."friend_id" = $1  [["friend_id", 1]]
 => false

# requestee and requestor

2.6.5 :017 > f.friend
 => #<User id: 2, email: "hackernoon@email.com", created_at: "2019-12-12 14:05:22", updated_at: "2019-12-12 14:05:22", name: "hacker noon">
2.6.5 :018 > f.user
 => #<User id: 1, email: "batman@email.com", created_at: "2019-12-11 22:40:48", updated_at: "2019-12-11 22:40:48", name: "batman">

# Check first user's (user) pending friendship request

2.6.5 :020 > u1.pending_friends
  User Load (1.5ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
 => [#<User id: 2, email: "hackernoon@email.com", created_at: "2019-12-12 14:05:22", updated_at: "2019-12-12 14:05:22", name: "hacker noon">]


# Check 2nd user's (friend) in coming friend reques

2.6.5 :022 > u2.friend_requests
  User Load (2.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
 => [#<User id: 1, email: "batman@email.com", created_at: "2019-12-11 22:40:48", updated_at: "2019-12-11 22:40:48", name: "batman">]

# 2nd user (friend) confirm friendship with 1st user (user)

u2.confirm_friend(u1)
   (1.6ms)  BEGIN
  User Load (1.4ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
  Friendship Update (2.8ms)  UPDATE "friendships" SET "status" = $1, "updated_at" = $2 WHERE "friendships"."id" = $3  [["status", true], ["updated_at", "2019-12-12 21:54:51.970268"], ["id", 1]]
   (40.3ms)  COMMIT
 => true

# Check friend's name

2.6.5 :025 > u1.friends[0].name
  Friendship Load (1.2ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."user_id" = $1  [["user_id", 1]]
  User Load (3.1ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
  Friendship Load (1.2ms)  SELECT "friendships".* FROM "friendships" WHERE "friendships"."friend_id" = $1  [["friend_id", 1]]
 => "robin"

```

​## Authors
​
This project was executed by:
​
- [Marcos Medeiros](https://www.linkedin.com/in/marcos-medeiros-6a079a18a/)
- [Damilola Ale](https://www.linkedin.com/in/damiecode/)
