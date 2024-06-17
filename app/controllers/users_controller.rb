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
end
