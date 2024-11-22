require "rails_helper"

RSpec.describe "litestream.yml" do
  # config/litestream/#{Rails.env}.yml is generated by config/initializers/litestream.rb
  it "configures litestack replication" do
    litestream_config = YAML.load_file(Rails.root.join("config", "litestream", "test.yml"))
    litestream_config["dbs"].each do |db|
      expect(db["path"]).to match(%r{storage/test/\w+.sqlite3})
      expect(db.dig("replicas", 0, "url")).to match(%r{s3://})
    end
  end

  it "extracts database paths from database.yml" do
    expect(LitestreamExtensions::Setup.database_paths).to include(
      "storage/test/data.sqlite3",
      "storage/test/cache.sqlite3",
      "storage/test/queue.sqlite3",
      "storage/test/cable.sqlite3"
    )
  end
end
