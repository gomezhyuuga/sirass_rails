# encoding: utf-8
# == Schema Information
#
# Table name: monthly_report_hours
#
#  id                :integer          not null, primary key
#  monthly_report_id :integer
#  fecha             :date
#  entrada           :time
#  salida            :time
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class MonthlyReportHour < ActiveRecord::Base
  attr_accessible :entrada, :fecha, :salida
  belongs_to :monthly_report

  validates_each :entrada, :salida do |record, attr, value|
  	record.errors.add(attr, "Formato inválido") unless value.class == Time
  end

  validates_presence_of :entrada, :fecha, :salida
end
