module CiviCrm
  module Actions
    module All
      module ClassMethods

        def all(row_count = 25)
          CiviCrm::Actions::Relation.new(self).all(row_count)
        end

        def build_response(params = {})
          params = build_params(params)
          response = CiviCrm::Client.request(:get, params)
          self.build_from(response, params)
        end

        private

        def build_params(params)
          params.merge!('entity' => self.entity_class_name)
          params['action'] ||= 'get'
          params
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end