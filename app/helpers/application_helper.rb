module ApplicationHelper
  def attributes_to_json(options={})
    options[:except]&&=options[:except].kind_of?(Array) ? options[:except] : [options[:except]]
    json={}
    self.attribute_names.each do |attr|
      json[attr]=self.send(attr.to_sym) unless options[:except]&&options[:except].include?(attr)
    end
    json
  end

end
