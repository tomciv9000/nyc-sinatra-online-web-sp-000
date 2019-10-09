class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    @figures = Figure.all
    erb :'/landmarks/new'
  end

  get "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  post '/landmarks' do
    @landmark = Landmark.create(params[:landmark])
    if !params["figure"]["name"].empty?
      @landmark.figure = Figure.create(name: params["figure"]["name"])
    end

    @landmark.save

    erb :"/landmarks/show"
  end

  get '/landmarks/:id/edit' do
    @figures = Figure.all
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do
    ####### allows removal of associated figure
    if !params[:landmark].keys.include?("figure_id")
    params[:landmark]["figure_id"] = []
    end
    #######
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])
    if !params["figure"]["name"].empty?
      @landmark.figure = Figure.create(name: params["figure"]["name"])
    end

    @landmark.save
    redirect "landmarks/#{@landmark.id}"
  end
end
