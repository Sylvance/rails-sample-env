module FilteringHelper
  def filter_transaction_records(scope)
    scope = filter_by_date_range(scope)
    scope = filter_by_customer(scope)
    scope
  end
  
  private
  
  def filter_by_date_range(scope)
    if params[:start_date].present? && params[:end_date].present?
      begin
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        scope = scope.where(transaction_date: start_date..end_date)
      rescue ArgumentError
        # Invalid date format, ignore filter
      end
    end
    scope
  end
  
  def filter_by_customer(scope)
    if params[:customer_id].present?
      scope = scope.where(customer_id: params[:customer_id])
    end
    scope
  end
end
