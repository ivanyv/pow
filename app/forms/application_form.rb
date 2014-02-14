class ApplicationForm < Reform::Form
  def create(params, &block)
    return create_composition(params, &block) if is_a?(Reform::Form::Composition)
    return false unless validate(params)

    save do |form, attributes|
      save_to_models
      form.model.tap do |record|
        yield record if block_given?
        record.save!
      end
    end

    true
  end

  def update(params, &block)
    create params, &block
  end

private
  def create_composition(params, &block)
    return false unless validate(params)

    save do |form, attributes|
      save_to_models
      yield form.model if block_given?
      attributes.keys.each do |child|
        form.model.send(child).tap do |record|
          record.save!
        end
      end
    end

    true
  end
end
