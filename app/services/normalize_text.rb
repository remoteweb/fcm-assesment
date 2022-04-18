class NormalizeText
  def initialize(input)
    @input = input
  end

  def perform
    ## We could improve this by implementing RegEx.
    @input.split('RESERVATION')
          .map{|res| res.split(' ')}
          .reject{|c| c.blank?}
          .map{|a| a.join(" ").split("SEGMENT")}
          .map{|r| r.reject{|c| c.empty?}}
          .map{|c| c.map{|a| a.gsub(': ','')}}
  end
end