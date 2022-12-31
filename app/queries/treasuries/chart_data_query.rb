class Treasuries::ChartDataQuery
  attr_reader :transactions
  def initialize(transactions)
    @transactions = transactions
  end

  # @example
  #   Treasuries::ChartDataQuery.new(@transactions).group_by_individual
  #
  #   @chart_data => [Array<Hash>]
  #
  #                   [{:x=>"2017-12-19", :y=>213519.0},
  #                    {:x=>"2019-04-01", :y=>0.0},
  #                    {:x=>"2021-09-06", :y=>200.0},
  #                    {:x=>"2021-09-06", :y=>400.0},
  #                    {:x=>"2021-09-08", :y=>550.0},
  #                    {:x=>"2021-09-10", :y=>700.0},
  #                    {:x=>"2021-10-28", :y=>1120.0},
  #                    {:x=>"2021-11-27", :y=>1220.0},
  #                    {:x=>"2021-12-04", :y=>1370.0},
  #                    {:x=>"2022-01-22", :y=>1780.0},
  #                    {:x=>"2022-05-10", :y=>2280.0}]
  #
  def group_by_individual
    sum = 0
    transactions
      .pluck(:date, :btc)
      .each_with_object([]) do |(date, btc), arr|
        arr << { x: date.strftime("%F"), y: sum += btc }
      end
  end
end
