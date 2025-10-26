# README
Catálogo de Filmes – Rails 8
Aplicação web para cadastro e consulta de filmes com autenticação, upload de pôsteres, categorias, busca e comentários.
- Ruby 3.4.7
- Rails 8.0.3
- PostgreSQL
- Devise
- Active Storage
- Deploy: https://catalogo-filmes.onrender.com
- Repositório: https://github.com/Carol6354/Catalogo_filmes

Funcionalidades
- Cadastro e login de usuários
- CRUD de filmes com pôster
- Categorias N:N
- Comentários
- Busca por título, gênero, diretor e categoria
- Autorização por dono do conteúdo

Instalação
git clone https://github.com/Carol6354/Catalogo_filmes.git
cd Catalogo_filmes
bundle install
rails db:create db:migrate db:seed
rails s


Acesse: http://localhost:3000
Uploads: Active Storage local por padrão. Pode ser configurado para S3 ou Cloudinary.
Estrutura: MVC padrão com controllers, models, views e assets organizados.
