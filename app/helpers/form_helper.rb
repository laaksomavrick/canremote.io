module FormHelper

    # For checking errors in @object.errors?
    def has_error(obj, key)
      obj.errors.details[key].empty? == false
    end

    def required_tags_for_select
      nav_tags.map {|t| [t.name.capitalize, t.name] }
    end

end