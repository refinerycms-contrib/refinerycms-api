if defined?(Refinery::Blog)
  module Refinery
    module Api
      module V1
        module Blog
          class PostsController < Refinery::Api::BaseController

            def index
              if params[:ids]
                @posts = Refinery::Blog::Post.
                          accessible_by(current_ability, :read).
                          where(id: params[:ids].split(','))
              else
                @posts = Refinery::Blog::Post.
                          accessible_by(current_ability, :read).
                          # ransack(params[:q]).result
                          newest_first
              end

              respond_with(@posts)
            end

            def show
              @post = post
              respond_with(@post)
            end

            def new
            end

            def create
              authorize! :create, ::Refinery::Blog::Post
              @post = Refinery::Blog::Post.new(post_params)

              if @post.save
                respond_with(@post, status: 201, default_template: :show)
              else
                invalid_resource!(@post)
              end
            end

            def update
              authorize! :update, post
              if post.update_attributes(post_params)
                respond_with(post, status: 200, default_template: :show)
              else
                invalid_resource!(post)
              end
            end

            def destroy
              authorize! :destroy, post
              post.destroy
              respond_with(post, status: 204)
            end

            private

            def post
              @post ||= Refinery::Blog::Post.
                          accessible_by(current_ability, :read).
                          find(params[:id])
            end

            def post_params
              if params[:post] && !params[:post].empty?
                params.require(:post).permit(permitted_blog_post_attributes)
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