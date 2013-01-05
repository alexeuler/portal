module ModelHelper

  def as_json(options={})
    options[:except]||=[]
    options[:except].concat %w(created_at updated_at)
    super(options)
  end

end


