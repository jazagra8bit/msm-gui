class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    d = Director.new
    d.name = params.fetch("query_name")
    d.dob = params.fetch("query_dob")
    d.bio = params.fetch("query_bio")
    d.image = params.fetch("query_image")

    d.save

    redirect_to("/directors")
  end

  def destroy
    the_id = params.fetch("id")
    director = Director.find_by(id: the_id)
  
    if director.present?
      director.destroy
    end
  
    redirect_to("/directors")
  end

  def update
    the_id = params.fetch("id")
    director = Director.find_by(id: the_id)
  
    if director.present?
      director.name = params.fetch("name", director.name)
      director.dob = params.fetch("dob", director.dob)
      director.bio = params.fetch("bio", director.bio)
      director.image = params.fetch("image", director.image)
  
      if director.save
        redirect_to("/directors/#{director.id}") # Redirects to show page after update
      else
        redirect_to("/directors/#{director.id}", alert: "Update failed.") # Redirect with error
      end
    else
      redirect_to("/directors") # Redirect if director not found
    end
  end  
end
