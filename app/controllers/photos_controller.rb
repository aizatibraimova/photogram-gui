class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all
    @list_of_photos = matching_photos.order({ :created_at => :desc })
    render({ :template => "photo_templates/index" })
  end

  def show
    url_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => url_id })

    @the_photo = matching_photos.at(0)

    render({ :template => "photo_templates/show" })
  end

  def destroy
    the_id = params.fetch("toast_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo = matching_photos.at(0)
    the_photo.destroy

    # render({ :template => "photo_templates/destroy" })
    redirect_to("/photos")
  end

  def create

    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")
    input_owner_id = params.fetch("query_owner_id")


    a_new_photo = Photo.new

    a_new_photo.image = input_image
    a_new_photo.caption = input_caption
    a_new_photo.owner_id = input_owner_id

    a_new_photo.save

    # render({ :template => "photo_templates/create" })

    redirect_to("/photos/" + a_new_photo.id.to_s)
  end

  def update

    the_id = params.fetch("modify_id")

    matching_photos = Photo.where({ :id => the_id })

    the_photo = matching_photos.at(0)

    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")

    the_photo.image = input_image
    the_photo.caption = input_caption

    the_photo.save

    next_url = "/photos/" + the_photo.id.to_s
    redirect_to(next_url) 
    # render({ :template => "photo_templates/update" })
  end

  def add_comment
#     <form action="/add_comment" method="post">
#   <label for="browser_photo_id">Photo ID</label>
#   <input id="browser_photo_id" type="text" placeholder="Enter the photo ID" name="query_photo_id" value="<%= @the_photo.id %>">

#   <label for="browser_author_id">Author ID</label>
#   <input id="browser_author_id" type="text" placeholder="Enter your author ID" name="query_author_id">

#   <label for="browser_comment">Comment</label>
#   <textarea id="browser_comment" placeholder="Enter a comment..." name="query_comment"></textarea>

#   <button>Add comment</button>
# </form>
    photo_id_input= params.fetch("query_photo_id")
    author_id_input = params.fetch("query_author_id")
    comment_input = params.fetch("query_comment")
  
    new_comment = Comment.new

    new_comment.photo_id = photo_id_input
    new_comment.author_id = author_id_input
    new_comment.body = comment_input

    new_comment.save

    matching_photos = Photo.where({:id => photo_id_input})

    the_photo = matching_photos.at(0)

    redirect_to("/photos/" + the_photo.id.to_s)
  end

end
