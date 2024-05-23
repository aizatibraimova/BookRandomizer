require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  erb(:index)
end


post("/random_book") do
  @book_details = fetch_random_book
  erb(:book_result)
end

def fetch_random_book
  base_url = "https://openlibrary.org/search.json"
  random_page = rand(1..10)
  response = HTTP.get("#{base_url}?q=the&page=#{random_page}")
  books = JSON.parse(response.body)["docs"]

  random_book = books.sample

  {
    title: random_book["title"],
    author: random_book["author_name"]&.first,
    pages: random_book["number_of_pages_median"],
    cover_id: random_book["cover_i"],
    summary: random_book["first_sentence"]&.first
  }
end
