Rails.application.routes.draw do

  root 'tars#show_form'
  get '/tars/results', to: 'tars#results', as: 'tars_results'

end
