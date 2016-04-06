object false
node(:symbol) { ::Money.new(1, Refinery::Config[:currency]).symbol }
