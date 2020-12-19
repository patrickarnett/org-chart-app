class NodesController < ApplicationController
  around_action :respond_with_json, only: %i[update]
  before_action :load_node, only: %i[update]

  def index
    all_nodes = Node.order(:first_name, :last_name).all
    respond_to do |format|
      format.html { render html: "There are #{all_nodes.count} nodes" }
      format.json { render json: all_nodes }
    end
  end

  def update
    if @node.update node_params
      render json: @node
    else
      render json: { errors: @node.errors }
    end
  end

  private

  def load_node
    @node = Node.find_by id: params[:id]
    head :not_found if @node.blank?
  end

  def node_params
    params.require(:node).permit :parent_id
  end
end
