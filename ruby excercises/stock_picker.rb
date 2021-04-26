# frozen_string_literal: true

class StockPicker
  def self.call(stock_prices)
    new(stock_prices).best_days
  end

  def best_days
    stock_to_buy = stock_prices.first
    stock_to_sell = nil
    amount_of_stocks = stock_prices.length

    stock_prices.each_with_index do |stock, index|
      next unless stock < stock_to_buy

      stock_to_buy = stock
      stock_to_sell = stock_prices[index..amount_of_stocks].max

      if stock_prices[index..stock_prices.find_index(stock_to_sell)].min < stock_to_buy
        stock_to_buy = stock_prices[index..stock_prices.find_index(stock_to_sell)].min
      end

      break
    end

    stock_to_sell = stock_prices[index..amount_of_stocks].max if stock_to_buy == stock_prices.first

    [stock_prices.find_index(stock_to_buy), stock_prices.find_index(stock_to_sell)]
  end

  private

  attr_reader :stock_prices

  def initialize(stock_prices)
    @stock_prices = stock_prices
  end
end
