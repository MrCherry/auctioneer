require './test/test_helper'
require './lib/auctioneer'

class AuctioneerTest < Minitest::Test
  def setup
    fixture = File.read(File.expand_path('creatives.json', 'test/fixtures'))
    @creatives = JSON.load(fixture)
    @unique_advertises_count = @creatives.uniq{ |c| c['advertiser_id'] }.count
  end

  # Auctioneer.auction should consider number_of_winners parameter
  def test_number_of_winners
    Range.new(1, @unique_advertises_count).each do |i|
      winners = Auctioneer.auction(
          creatives: @creatives,
          number_of_winners: i
      )

      assert { winners.count == i }
    end
  end

  # Auctioneer.auction should consider country_name parameter if it is provided
  def test_country_name_passed
    unique_countries = @creatives.map{ |c| c['country_name'] }.compact.uniq

    unique_countries.each do |country_name|
      winners = Auctioneer.auction(
          creatives: @creatives,
          number_of_winners: @unique_advertises_count,
          country_name: country_name
      )

      winners.each do |winner|
        assert { winner['country_name'] == country_name || winner['country_name'].nil? }
      end
    end
  end

  # Auctioneer.auction should consider country_name parameter if it is nil
  def test_country_name_nil
    winners = Auctioneer.auction(
        creatives: @creatives,
        number_of_winners: @unique_advertises_count
    )

    assert { winners.select{ |c| c['country_name'].nil? } }
  end

  # All winners of Auctioneer.auction have unique advertiser_id
  def test_unique_advertiser_id
    winners = Auctioneer.auction(
        creatives: @creatives,
        number_of_winners: @unique_advertises_count
    )

    advertisers = winners.map{ |c| c['advertiser_id'] }
    assert { advertisers.count == advertisers.uniq.count }
  end

  # Function should not give preference to any of equal by price creatives,
  # but should return such creatives equiprobable.
  def test_equiprobable_results
    winners = []

    @unique_advertises_count.times do
      winners += Auctioneer.auction(
          creatives: @creatives,
          number_of_winners: 1
      )
    end

    deny { winners.uniq.count == 1 }
  end
end
