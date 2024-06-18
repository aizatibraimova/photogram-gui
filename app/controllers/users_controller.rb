class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })
    render({ :template => "user_templates/index" })
  end

  def show

    # Parameters: {"path_username" => "ania"}
    url_username = params.fetch("path_username")

    matching_username = User.where({ :username => url_username })

    @the_user = matching_username.first

    # if the_user == nil
    #   redirect_to("/404")
    # else

    render ({ :template => "user_templates/show" })
    # end
  end

  def create
  
    username_input = params.fetch("input_username")

    new_user = User.new

    new_user.username = username_input

    new_user.save

    redirect_to("/users/"+ new_user.username)
  end

  def update

    the_username = params.fetch("modify_user")
    user = User.all.where({:username => the_username}).at(0)

    user.username = params.fetch("input_username")
    user.save

    redirect_to("/users/#{user.username}")
  end
end
