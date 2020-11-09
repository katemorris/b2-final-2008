class PatientDoctorsController < ApplicationController
  def destroy
    pd = PatientDoctor.find(params[:id])
    doctor = pd.doctor_id
    pd.destroy
    redirect_to doctor_path(doctor)
  end
end
