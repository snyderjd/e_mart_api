class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Returns 1st level down associated objects in json responses
  # def as_json(**options)
  #   unless options.has_key? :include
  #     options.merge!(
  #       include: self.class.reflect_on_all_associations.map(&:name)
  #     )
  #   end

  #   super(options)
  # end

end
