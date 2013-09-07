class Faq < ActiveRecord::Base
  belongs_to :faq_category, :counter_cache => true
end

# == Schema Information
#
# Table name: faqs
#
#  id              :integer          not null, primary key
#  question        :string(255)
#  answer          :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  faq_category_id :integer
#

