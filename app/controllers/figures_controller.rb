class FiguresController < ApplicationController

  def check_new_user_input
    if params[:title][:name].present?
      @figure.titles << Title.find_or_create_by(name: params[:title][:name])
    end

    if params[:landmark][:name].present?
      @figure.landmarks << Landmark.find_or_create_by(name: params[:landmark][:name])
    end
  end

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    check_new_user_input


    redirect to("/figures/#{@figure.id}")
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do

    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if !params[:figure][:landmark_ids]
      @figure.landmarks.clear
    end
    if !params[:figure][:title_ids]
      @figure.titles.clear
    end

    check_new_user_input

    redirect to("/figures/#{@figure.id}")
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

end
