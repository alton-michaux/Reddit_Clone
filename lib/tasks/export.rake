# frozen_string_literal: true

namespace :export do
  desc 'Prints Member.all in a seeds.rb way.'
  task seeds_format: :environment do
    Account.order(:id).all.each do |account|
      puts "Account.create(#{account.serializable_hash.delete_if do |key, _value|
                               %w[created_at updated_at id].include?(key)
                             end.to_s.gsub(/[{}]/, '')})"
    end
  end
  task seeds_format: :environment do
    Community.order(:id).all.each do |community|
      puts "Community.create(#{community.serializable_hash.delete_if do |key, _value|
                                 %w[created_at updated_at id].include?(key)
                               end.to_s.gsub(/[{}]/, '')})"
    end
  end
  task seeds_format: :environment do
    Post.order(:id).all.each do |post|
      puts "Post.create(#{post.serializable_hash.delete_if do |key, _value|
                            %w[created_at updated_at id].include?(key)
                          end.to_s.gsub(/[{}]/, '')})"
    end
  end
end
