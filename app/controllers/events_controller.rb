class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]
  
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new('title' => params[:title], 
      'description' => params[:description],
      'duration' => params[:duration],
      'start_date' => params[:start_date],
      'price' => params[:price],
      'location' => params[:location],
      'manager_id' => current_user.id) #à revoir pour heroku, fonctionne en local

    if @event.save
      puts "The event was succesfully saved !"
      flash[:success] = "Evènement créé !"
      redirect_to '/'
    else
      puts "Error : create problem"
      flash[:danger] = "Erreur dans la création de l'évènement (date passée ou durée pas multiple de 5) !"
      render '/events/new'
    end
  end

  def new
    @event = Event.new
  end
end
