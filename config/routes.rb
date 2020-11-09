Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/doctors/:id', to: 'doctors#show', as: 'doctor'
  delete '/patient_doctors/:id', to: 'patient_doctors#destroy', as: 'patient_doctors'
  get '/hospitals/:id', to: 'hospitals#show', as: 'hospital'
  get '/patients', to: 'patients#index', as: 'patients'
end
