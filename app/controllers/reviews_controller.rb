class ReviewsController < ApplicationController

  before_filter :review_exists, :only => [:new, :create]
  # GET /reviews
  # GET /reviews.xml
  def index
    @movie = Movie.find(params[:movie_id])
    @reviews = @movie.reviews

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.xml
  def new
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build(params[:review])
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        flash[:notice] = 'Review was successfully created.'
        format.html { redirect_to movie_path(@movie) }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        flash[:notice] = 'Review was successfully updated.'
        format.html { redirect_to movie_path(@movie) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to movie_reviews_path(@movie) }
      format.xml  { head :ok }
    end
  end
  
  private
    def review_exists
      existing_review = Review.find(:first, :conditions => { :movie_id => params[:movie_id], :user_id => current_user.id })
      if existing_review.present?
        flash[:notice] = 'You have already reviewed this movie.'
        redirect_to movie_path(@movie)
      end
    end
end
