module FormHelper

    # For checking errors in @object.errors?
    def has_error(obj, key)
      obj.errors.details[key].empty? == false
    end

end