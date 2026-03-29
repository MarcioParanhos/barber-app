// Arquivo de configuração do Prisma (Prisma v7+)
// Requer: npm install --save-dev prisma dotenv
// O `prisma.config.ts` fornece o `DATABASE_URL` e outras opções ao CLI.
import "dotenv/config"; // carrega variáveis do .env para process.env
import { defineConfig } from "prisma/config";

// Exporta a configuração usada pelo Prisma CLI e runtime
export default defineConfig({
  // Caminho para o schema Prisma
  schema: "prisma/schema.prisma",
  // Pasta onde as migrações serão criadas/aplicadas
  migrations: {
    path: "prisma/migrations",
  },
  // Datasource: a URL de conexão é lida da variável de ambiente
  // `DATABASE_URL` (por exemplo, definida em .env ou .env.docker)
  datasource: {
    url: process.env["DATABASE_URL"],
  },
});
