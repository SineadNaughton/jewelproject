class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def user_params
      param.require(:user).permit(:user_id, :email, :username, :password)
  end
        
  has_many:orders
  has_many:wishlistitems
  

end
