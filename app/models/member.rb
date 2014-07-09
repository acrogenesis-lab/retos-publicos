class Member < ActiveRecord::Base
  include Reportable

  attr_accessible :avatar, :email, :name, :company_name, :company_rfc, :company_president,
    :company_charter, :nickname, :bio, :user

  acts_as_user
  paginates_per 21
  has_many :collaborations
  has_many :challenges, through: :collaborations
  has_many :entries

  mount_uploader :company_charter, CompanyCharterUploader

  def self.report_attributes
    [:id, :name, :email, :created_at]
  end

  def to_s
    name || nickname || email
  end

  def has_submitted_app?(challenge)
    !self.entry_for(challenge).nil?
  end

  def has_submitted_prototype_for_challenge?(challenge)
    entry = self.entry_for(challenge)
    entry.repo_url.present? && entry.demo_url.present?
  end

  def entry_for(challenge)
    self.userable.entries.where(challenge_id: challenge.id).first
  end
end
