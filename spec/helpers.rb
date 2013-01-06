module RSpec::Helpers
  def model_to_hash(model, options={})
    hash={}
    model.attribute_names.each do |attr|
      hash[attr]=model.send attr.to_sym unless option_to_array(options[:exclude]).include?(attr)
    end
    hash
  end

  def option_to_array(option)
    if option
      option.kind_of?(Array) ? option : [option]
    else
      []
    end
  end
end
