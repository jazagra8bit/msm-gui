class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    a = Actor.new
    a.name = params.fetch("query_name")
    a.dob = params.fetch("query_dob")
    a.bio = params.fetch("query_bio")
    a.image = params.fetch("query_image")

    a.save

    redirect_to("/actors")
  end

  def update
    the_id = params.fetch("id")
    actor = Actor.find_by(id: the_id)
  
    if actor.present?
      actor.name = params.fetch("query_name", actor.name)
      actor.dob = params.fetch("query_dob", actor.dob)
      actor.bio = params.fetch("query_bio", actor.bio)
      actor.image = params.fetch("query_image", actor.image)
  
      if actor.save
        redirect_to("/actors/#{actor.id}") # Redirect to show page after update
      else
        redirect_to("/actors/#{actor.id}", alert: "Update failed.") # Redirect with error
      end
    else
      redirect_to("/actors") # Redirect if actor not found
    end
  end  

  def destroy
    the_id = params.fetch("id")
    actor = Actor.find_by(id: the_id)
  
    if actor.present?
      actor.destroy
    end
  
    redirect_to("/actors") # Redirect to actors index after deletion
  end
  
end
