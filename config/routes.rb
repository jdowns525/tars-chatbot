Rails.application.routes.draw do

  root 'tars#show_form'
  get '/tars/results', to: 'tars#results', as: 'tars_results'



  get("/solutions", { :controller => "solutions", :action => "display_form" })
  
  get("/solutions/results", { :controller => "solutions", :action => "gpt_response" })

end
