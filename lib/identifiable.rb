module Identifiable
  module ClassMethods
    def identifiable_fields
      @identifiable_fields ||= IdentifiableField.where(class_name: self.to_s).collect(&:field_name) || Array.new
    end

    def identifiables
      IdentifiableField.where(class_name: self.to_s).in(field_name: identifiable_fields)
    end
    
    def reset_identifiable_fields
      @identifiable_fields = Array.new
      identifiable_fields
    end
    
    def drop_identifiable_fields
      IdentifiableField.delete_all(class_name: self.to_s)
      reset_identifiable_fields
    end
    
    def create_field(field_string, description_string="")  
      unless !field_string.is_a?(String) || identifiable_fields.include?(field_string)
        identifiable_fields << field_string
        IdentifiableField.create!(class_name: self.to_s, field_name: field_string, description: description_string)
      end 
    end
    
  end
  
  module InstanceMethods
    def method_missing(name, *args, &block)
      if self.class.identifiable_fields.include?(name.to_s.gsub(/\W/, "").to_s)
        if name.to_s.ends_with?("=")
          set_field_value(name.to_s.chop, args[0])
        else
          get_field_value(name.to_s)
        end
      else
        super(name, *args, &block)
      end
    end
    
    def respond_to?(*name)
      return true if self.class.identifiable_fields.include?(name[0].to_s)
      super(*name)
    end
    
    def get_field_value(name)
      ifield = IdentifiableField.where(field_name: name, class_name: self.class.to_s).first
      
      if ifield
        ifield_entries = self.identifiable_entries.select{|e| e.identifiable_field_id == ifield.id}
        ifield_value = ifield_entries.collect(&:field_value)
        
        if ifield_value.size == 1
          ifield_value.last
    		elsif ifield_value.blank?
    		  nil
    		else
          ifield_value
        end
        
      else
        nil
      end
    end
    
    def set_field_value(name, value)
      ifield = IdentifiableField.where(field_name: name, class_name: self.class.to_s).first
      if ifield
        self.identifiable_entries << IdentifiableEntry.new(field_value: value, identifiable_field_id: ifield.id)
      end
    end
    
  end
end
