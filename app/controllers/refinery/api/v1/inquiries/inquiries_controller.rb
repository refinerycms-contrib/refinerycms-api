if defined?(Refinery::Inquiries)
  module Refinery
    module Api
      module V1
        module Inquiries
          class InquiriesController < Refinery::Api::BaseController

            def index
              if params[:ids]
                @inquiries = Refinery::Inquiries::Inquiry.
                          accessible_by(current_ability, :read).
                          where(id: params[:ids].split(','))
              else
                @inquiries = Refinery::Inquiries::Inquiry.
                          accessible_by(current_ability, :read).
                          # ransack(params[:q]).result
                          order("created_at DESC")
              end

              respond_with(@inquiries)
            end

            def show
              @inquiry = inquiry
              respond_with(@inquiry)
            end

            def new
            end

            def create
              authorize! :create, ::Refinery::Inquiries::Inquiry
              @inquiry = Refinery::Inquiries::Inquiry.new(inquiry_params)

              if @inquiry.save
                respond_with(@inquiry, status: 201, default_template: :show)
              else
                invalid_resource!(@inquiry)
              end
            end

            def destroy
              authorize! :destroy, inquiry
              inquiry.destroy
              respond_with(inquiry, status: 204)
            end

            private

            def inquiry
              @inquiry ||= Refinery::Inquiries::Inquiry.
                          accessible_by(current_ability, :read).
                          find(params[:id])
            end

            def inquiry_params
              if params[:inquiry] && !params[:inquiry].empty?
                params.require(:inquiry).permit(permitted_inquiries_inquiry_attributes)
              else
                {}
              end
            end

          end
        end
      end
    end
  end
end