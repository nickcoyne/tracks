class IndexController < ApplicationController

  before_filter :login_required, only: [ :edit, :update ]
  layout 'index', except: [:rss]

  def index
    @special = Special.find(:first, conditions: ["name = ?", 'index'])
    @recent_track_reports = TrackReport.find_recent[0,10]
    set_nation
    @regions_with_points = Region.all(conditions: ["nation_id = ? AND points IS NOT NULL AND points != ?", @nation.id, ""])
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify method: :post, only: [ :destroy, :create, :update ],
         redirect_to: { action: :index }

  def edit
    @special = Special.find(params[:id])
    @special.content = replace_for_edit(@special.content)
    set_nation
  end

  def update
    @special = Special.find(params[:id])
    params[:special][:content] = replace_for_update(params[:special][:content])
    if @special.update_attributes(params[:special])
      update_user_edit_stats
      flash[:notice] = 'Home was successfully updated.'
      redirect_to action: 'index'
    else
      render action: 'edit'
    end
  end

  def rss
    @track_reports = TrackReport.find_recent
    respond_to do |format|
      format.html
      format.rss  { render :layout => false }
    end
  end

private

  def set_nation
    @nation = Nation.first # Note: currently assumes only *one*... New Zealand
  end
end
