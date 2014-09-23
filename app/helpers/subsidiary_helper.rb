module SubsidiaryHelper
  def self.get_subsidiaries
    @subsidiaries = Subsidiary.select("code, name, company_id")
    @subsidiaries.each { |s|
      s.manager = User.select("name, employee_file_number, dni").where(subsidiary_id: s.id).where(position_id: 3).take
      s.sub_manager = User.select("name, employee_file_number, dni").where(subsidiary_id: s.id).where(position_id: 2).take
    }
  end
end
