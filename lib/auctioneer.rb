module Auctioneer
  # @param [Array] creatives
  # @param [Integer] number_of_winners
  # @param [String] country_name
  # @return [Array] array of winners of the auction
  def self.auction(creatives:, number_of_winners:, country_name: nil)
    # Check that passed parameters are valid
    raise Exception.new('creatives parameter must be specified') unless creatives.is_a?(Array)
    raise Exception.new('number_of_winners parameter must be specified') unless number_of_winners.is_a?(Integer)

    # Init contenders and winners arrays
    contenders = creatives.dup
    winners = []

    # Select only specified country's contenders
    contenders.select!{ |c| c['country_name'] == country_name || c['country_name'].nil? } if country_name

    # Process contenders array
    number_of_winners.times do
      break if contenders.empty?

      # Generate a random contender's index based on contenders array size
      index = rand(contenders.count)

      # Select a winner
      winner = contenders.delete_at(index)

      # Reject contenders with the same advertiser_id
      contenders.reject!{ |c| c['advertiser_id'] == winner['advertiser_id'] }

      # Add the winner to the winners array
      winners << winner
    end

    # Return the winners array
    winners
  end
end
