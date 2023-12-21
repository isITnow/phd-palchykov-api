class HomeController < ApplicationController
  def welcome
    render plain: "Visit https://palchykovchem.vercel.app\nProf. Dr. Vitalii Palchykov profile page"
  end
end
