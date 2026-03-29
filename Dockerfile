FROM node:20-alpine
# Diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o package.json e package-lock (se existir) para a imagem.
# Isto permite instalar dependências antes de copiar todo o código,
# aproveitando o cache do Docker quando o package.json não muda.
COPY package*.json ./

# Instala dependências incluindo devDependencies.
# Precisamos das devDependencies aqui para que o comando
# `npx prisma generate` e o processo de build do Next.js funcionem
# durante a construção da imagem.
RUN npm install --include=dev

# Copia todo o restante do código da aplicação para a imagem.
COPY . .

# Gera o Prisma Client a partir do schema. Isso cria o cliente em
# `app/generated/prisma` (conforme `schema.prisma`), usado pela app.
RUN npx prisma generate

# Executa o build de produção do Next.js (gera a pasta .next).
RUN npm run build

# Remove as dependências de desenvolvimento para reduzir o tamanho
# final da imagem (opcional para produção). Mantemos apenas o que
# é necessário para rodar a aplicação em tempo de execução.
RUN npm prune --production

# Define a variável de ambiente padrão para o runtime.
ENV NODE_ENV=production

# Expõe a porta padrão do Next.js em produção.
EXPOSE 3000

# Comando padrão para iniciar a aplicação em modo produção.
CMD ["npm","start"]
