class AddRepoUrlAndDemoUrlToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :repo_url, :string
    add_column :entries, :demo_url, :string
  end
end
