require "uri"
require "./readme"

Readme
  .new
  .refs(/t/)
  .map { |ref| URI.parse(ref).path.as(String?).try &.split(/\//).try &.[1] }
  .compact
  .reject(&.blank?)
  .map(&.downcase)
  .group_by(&.itself)
  .to_a
  .sort_by { |_, entries| -1 * entries.size }
  .each_with_index do |heros, i|
    puts "#{i + 1}. #{heros.first} (#{heros.last.size} entries)"
  end
