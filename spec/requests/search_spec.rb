require "rails_helper"

RSpec.describe "Searches", type: :request do
  describe "GET show" do
    it "renders empty without search query" do
      get search_path

      expect(response).to have_http_status(:success)

      expect(page).not_to have_content("No results")
    end

    it "renders empty without search query as POST" do
      post search_path

      expect(response).to have_http_status(:success)

      expect(page).not_to have_content("No results")
    end

    it "renders empty without search query as turbo stream" do
      get search_path(format: :turbo_stream)

      expect(response).to have_http_status(:success)

      expect(page).not_to have_content("No results")
    end

    it "renders No results feedback when query is long enough" do
      get search_path, params: {query: "Pro"}

      expect(response).to have_http_status(:success)

      expect(page).to have_content("No results")
    end

    it "renders the search results without query" do
      FactoryBot.create(:page, :published, request_path: "/pwa-showcase")
      Pages::RefreshSearchIndexJob.perform_now

      get search_path

      expect(response).to have_http_status(:success)

      expect(page).not_to have_content("No results")
    end

    it "renders the search results with query as turbo stream" do
      FactoryBot.create(:page, :published, request_path: "/pwa-showcase")
      FactoryBot.create(:page, :published, request_path: "/articles/introducing-joy-of-rails")
      Pages::RefreshSearchIndexJob.perform_now

      get search_path(format: :turbo_stream), params: {query: "Progressive Web Apps"}

      expect(response).to have_http_status(:success)

      # Normally, I would use the Capybara page helper to assert content but I
      # wasn’t able to find elements or content within the Turbo Stream
      # responses. Maybe I missed something? But dropping down to Nokogiri text
      # works.
      expect(Nokogiri::HTML(response.body).text).to match("Progressive Web Apps on Rails Showcase")
      expect(Nokogiri::HTML(response.body).text).not_to match("Introducing Joy of Rails")
    end

    it "renders the search results with query" do
      FactoryBot.create(:page, :published, request_path: "/pwa-showcase")
      FactoryBot.create(:page, :published, request_path: "/articles/introducing-joy-of-rails")
      Pages::RefreshSearchIndexJob.perform_now

      post search_path, params: {query: "Progressive Web Apps"}

      expect(response).to have_http_status(:success)

      expect(page).to have_content("Progressive Web Apps on Rails Showcase")
      expect(page).not_to have_content("Introducing Joy of Rails")
    end

    it "doesn’t blow up with invalid query" do
      get search_path, params: {query: "(((("}

      expect(response).to have_http_status(:success)
      expect(page).to have_content("No results")
    end

    it "doesn’t blow up with invalid query as turbo stream" do
      get search_path(format: :turbo_stream), params: {query: "(((("}

      expect(response).to have_http_status(:success)
    end
  end
end
