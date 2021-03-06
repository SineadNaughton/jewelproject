class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def user_params
      param.require(:user).permit(:user_id, :email, :username, :password)
  end
        
  has_many:orders, dependent: :destroy
  has_many:wishlistitems, dependent: :destroy
  has_many:reviews, dependent: :destroy
  has_many:recentlyvieweds, dependent: :destroy
  

end
