class AddHorasServicioToInscripcions < ActiveRecord::Migration
  def change
    add_column :inscripcions, :horas_servicio, :string, :default => "00:00"
  end
end
