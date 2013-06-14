TestApp::Application.routes.draw do
  root to: 'application#index'

  get '/reading_test' => 'application#reading_test'
end
