class DealsController < ApplicationController

  def revolvers
    @deals = Deal.where(deal_type: 'revolver')
  end

  def revolver_show
    @deal = Deal.find(params[:id])

  end

  def rimfire
    @deals = Deal.where(deal_type: 'rimfire')
  end

  def rimfire_show
    @deal = Deal.find(params[:id])
  end

  def c_and_r
    @deals = Deal.where(deal_type: 'c_and_r')
  end

  def c_and_r_show
    @deal = Deal.find(params[:id])
  end

  def ar_deals
    @deals = Deal.where(deal_type: 'ar_deals')
  end

  def ar_deal_show
    @deal = Deal.find(params[:id])
  end

  def ak_deals
    @deals = Deal.where(deal_type: 'ak_deals')
  end

  def ak_deal_show
    @deal = Deal.find(params[:id])
  end

  def twentytwo_lr_ammo
    @deals = Deal.where(deal_type: '22_lr_ammo')
  end

  def twentytwo_lr_ammo_show
    @deal = Deal.find(params[:id])
  end

  def nine_mm_ammo
    @deals = Deal.where(deal_type: '9_mm_ammo')
  end

  def nine_mm_ammo_show
    @deal = Deal.find(params[:id])
  end

  def used_guns
    @deals = Deal.where(deal_type: 'used_guns')
  end

  def used_gun_show
    @deal = Deal.find(params[:id])
  end

  def top_articles
    @deals = Deal.where(deal_type: 'top_articles')
  end

  def top_article_show
    @deal = Deal.find(params[:id])
  end

  def popular
    @deals = Deal.where(deal_type: 'popular')
  end

  def popular_show
    @deal = Deal.find(params[:id])
  end


  protected

end
