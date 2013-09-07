class FaqCategory < ActiveRecord::Base
  has_many :faqs
end

# == Schema Information
#
# Table name: faq_categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  faqs_count  :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

