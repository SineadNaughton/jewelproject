class Order < ApplicationRecord
  
  def order_params
      param.require(:order).permit(:order_date, :user_id, :status, :order_total)
  end
  
  belongs_to :user
  has_many:orderitems
end
