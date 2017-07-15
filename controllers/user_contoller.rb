class App
  get '/user/:id/sessions' do
    user = User.find_by(id: params[:id])
    erb :'user/list', locals: { user: user }
  end
end
