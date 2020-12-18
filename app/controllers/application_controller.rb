class ApplicationController < ActionController::Base
  def org_chart
    render 'org_chart'
  end

  private

  def respond_with_json(&block)
    respond_to do |format|
      format.json do
        yield block
      end
    end
  end
end
