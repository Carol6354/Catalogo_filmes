if Rails.env.development?
  puts "[Seeds] Ambiente: development — usuario de teste"

Comment.delete_all
Movie.delete_all
User.delete_all

# Usuário demo
user = User.create!(
  email: "demo@example.com",
  password: "password123",
  password_confirmation: "password123",
  display_name: "Avaliador Demo"
)

# filmes teste
titles = [
  "A Origem", "Interestelar", "O Cavaleiro das Trevas", "Matrix", "Cidade de Deus",
  "Parasita", "Whiplash", "O Poderoso Chefão", "Forrest Gump", "Clube da Luta",
  "Amnésia", "Gladiador", "Django Livre", "Her", "La La Land"
]

genres = %w[Ação Drama Ficção Policial Suspense]

movies = titles.each_with_index.map do |t, i|
    Movie.create!(
      title: t,
      genre: genres.sample,
      year: 1990 + i,
      rating: (7.0 + rand * 3).round(1),
      director: ["Christopher Nolan", "Quentin Tarantino", "Bong Joon-ho", "Denis Villeneuve"].sample,
      duration: 90 + rand(40),
      synopsis: "Sinopse de #{t}. Um pequeno texto demonstrativo para o desafio.",
      user: user
    )
  end

movies.sample(6).each do |movie|
    movie.comments.create!(content: "Filme incrível!", user: user)       # coment. autenticado
    movie.comments.create!(content: "Gostei bastante!", name: "Visitante") # coment. anônimo
  end

puts "Seeds ok! Login: demo@example.com / password123"
else
    puts "[Seeds] Ambiente diferente de development — pulando usuário demo"
end

["Ação", "Comédia", "Drama", "Ficção", "Romance", "Suspense"].each do |n|
    Category.find_or_create_by!(name: n)
  end





