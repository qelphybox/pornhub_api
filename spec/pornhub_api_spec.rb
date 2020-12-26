# frozen_string_literal: true

RSpec.describe PornhubApi, vcr: { allow_unused_http_interactions: false } do
  it "has a version number" do
    expect(PornhubApi::VERSION).not_to be nil
  end

  describe ".search" do
    subject(:search) { described_class.search(args) }
    let(:args) { { search: "asian", page: 1, thumbsize: "small" } }
    it { is_expected.to include(:videos) }
    it { is_expected.to match_schema("search") }
  end

  describe ".stars" do
    subject(:stars) { described_class.stars }
    it { is_expected.to match_schema("stars") }
  end

  describe ".stars_detailed" do
    subject(:stars) { described_class.stars_detailed }
    it { is_expected.to match_schema("stars_detailed") }
  end

  describe ".video_by_id" do
    subject(:stars) { described_class.video_by_id(args) }
    let(:args) { { id: "ph5fbf2d80025f9" } }
    it { is_expected.to match_schema("video_by_id") }
  end

  describe ".is_video_active" do
    subject(:stars) { described_class.is_video_active(args) }
    let(:args) { { id: "ph5fbf2d80025f9" } }
    it { is_expected.to match_schema("is_video_active") }
  end

  describe ".categories" do
    subject(:stars) { described_class.categories }
    it { is_expected.to match_schema("categories") }
  end
  describe ".tags" do
    subject(:stars) { described_class.tags(args) }
    let(:args) { { list: "y" } }
    it { is_expected.to match_schema("tags") }
  end
end
