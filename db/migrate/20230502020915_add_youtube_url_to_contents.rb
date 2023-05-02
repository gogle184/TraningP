class AddYoutubeUrlToContents < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :youtube_url, :string
  end
end
