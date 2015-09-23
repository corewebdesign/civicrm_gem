module CiviCrm
  module Actions
    module GetCount
      extend ActiveSupport::Concern

      module ClassMethods
        def get_count(attrs = {})
          params = {'entity' => entity_class_name, 'action' => 'getcount'}
          response = CiviCrm::Client.request(:get, params.merge(attrs))
          self.build_from(response, params)
        end
      end
    end
  end
end
