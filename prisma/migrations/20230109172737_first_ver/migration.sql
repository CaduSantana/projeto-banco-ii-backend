-- CreateTable
CREATE TABLE "Pessoa" (
    "uuid_pessoa" TEXT NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "sobrenome" VARCHAR(45) NOT NULL,
    "cpf" VARCHAR(11) NOT NULL,
    "email" VARCHAR(320) NOT NULL,
    "senha" VARCHAR(40) NOT NULL,
    "is_funcionario" BOOLEAN NOT NULL,
    "is_admin" BOOLEAN NOT NULL,

    CONSTRAINT "Pessoa_pkey" PRIMARY KEY ("uuid_pessoa")
);

-- CreateTable
CREATE TABLE "Endereco" (
    "uuid_endereco" TEXT NOT NULL,
    "rua" VARCHAR(45) NOT NULL,
    "numero" VARCHAR(45) NOT NULL,
    "bairro" VARCHAR(45) NOT NULL,
    "cidade" VARCHAR(45) NOT NULL,
    "estado" VARCHAR(45) NOT NULL,
    "cep" VARCHAR(8) NOT NULL,
    "complemento" VARCHAR(280) NOT NULL,
    "uuid_pessoa" TEXT NOT NULL,
    "municipiosId_municipio" INTEGER,

    CONSTRAINT "Endereco_pkey" PRIMARY KEY ("uuid_endereco")
);

-- CreateTable
CREATE TABLE "Municipios" (
    "id_municipio" SERIAL NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "id_uf" SMALLINT NOT NULL,
    "ufsId_uf" INTEGER,

    CONSTRAINT "Municipios_pkey" PRIMARY KEY ("id_municipio")
);

-- CreateTable
CREATE TABLE "Ufs" (
    "id_uf" SERIAL NOT NULL,
    "nome" VARCHAR(60) NOT NULL,
    "sigla" CHAR(2) NOT NULL,

    CONSTRAINT "Ufs_pkey" PRIMARY KEY ("id_uf")
);

-- CreateTable
CREATE TABLE "Categorias" (
    "id_categoria" SMALLSERIAL NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "prioridade" SMALLINT NOT NULL,

    CONSTRAINT "Categorias_pkey" PRIMARY KEY ("id_categoria")
);

-- CreateTable
CREATE TABLE "Produtos" (
    "uuid_produto" TEXT NOT NULL,
    "nome" VARCHAR(45) NOT NULL,
    "descricao" VARCHAR(280) NOT NULL,
    "massa" REAL NOT NULL,
    "id_categoria" SMALLINT NOT NULL,

    CONSTRAINT "Produtos_pkey" PRIMARY KEY ("uuid_produto")
);

-- CreateTable
CREATE TABLE "Veiculos" (
    "uuid_veiculo" TEXT NOT NULL,
    "placa" VARCHAR(7) NOT NULL,
    "tipo" VARCHAR(45) NOT NULL,
    "capacidade" INTEGER NOT NULL,

    CONSTRAINT "Veiculos_pkey" PRIMARY KEY ("uuid_veiculo")
);

-- CreateTable
CREATE TABLE "Descartes" (
    "uuid_descarte" TEXT NOT NULL,
    "solicitado_em" TIMESTAMP(0) NOT NULL,
    "uuid_solicitante" TEXT NOT NULL,
    "uuid_origem" TEXT NOT NULL,
    "uuid_destino" TEXT NOT NULL,

    CONSTRAINT "Descartes_pkey" PRIMARY KEY ("uuid_descarte")
);

-- CreateTable
CREATE TABLE "Pessoa_reside_Endereco" (
    "uuid_pessoa" TEXT NOT NULL,
    "uuid_endereco" TEXT NOT NULL,

    CONSTRAINT "Pessoa_reside_Endereco_pkey" PRIMARY KEY ("uuid_pessoa","uuid_endereco")
);

-- CreateTable
CREATE TABLE "Funcionario_executa_Descarte" (
    "uuid_veiculo" TEXT NOT NULL,
    "uuid_descarte" TEXT NOT NULL,
    "uuid_funcionario" TEXT NOT NULL,

    CONSTRAINT "Funcionario_executa_Descarte_pkey" PRIMARY KEY ("uuid_veiculo","uuid_descarte","uuid_funcionario")
);

-- CreateIndex
CREATE UNIQUE INDEX "Pessoa_cpf_key" ON "Pessoa"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "Pessoa_email_key" ON "Pessoa"("email");

-- AddForeignKey
ALTER TABLE "Endereco" ADD CONSTRAINT "Endereco_uuid_pessoa_fkey" FOREIGN KEY ("uuid_pessoa") REFERENCES "Pessoa"("uuid_pessoa") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Endereco" ADD CONSTRAINT "Endereco_municipiosId_municipio_fkey" FOREIGN KEY ("municipiosId_municipio") REFERENCES "Municipios"("id_municipio") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Municipios" ADD CONSTRAINT "Municipios_ufsId_uf_fkey" FOREIGN KEY ("ufsId_uf") REFERENCES "Ufs"("id_uf") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Produtos" ADD CONSTRAINT "Produtos_id_categoria_fkey" FOREIGN KEY ("id_categoria") REFERENCES "Categorias"("id_categoria") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pessoa_reside_Endereco" ADD CONSTRAINT "Pessoa_reside_Endereco_uuid_pessoa_fkey" FOREIGN KEY ("uuid_pessoa") REFERENCES "Pessoa"("uuid_pessoa") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pessoa_reside_Endereco" ADD CONSTRAINT "Pessoa_reside_Endereco_uuid_endereco_fkey" FOREIGN KEY ("uuid_endereco") REFERENCES "Endereco"("uuid_endereco") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Funcionario_executa_Descarte" ADD CONSTRAINT "Funcionario_executa_Descarte_uuid_veiculo_fkey" FOREIGN KEY ("uuid_veiculo") REFERENCES "Veiculos"("uuid_veiculo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Funcionario_executa_Descarte" ADD CONSTRAINT "Funcionario_executa_Descarte_uuid_descarte_fkey" FOREIGN KEY ("uuid_descarte") REFERENCES "Descartes"("uuid_descarte") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Funcionario_executa_Descarte" ADD CONSTRAINT "Funcionario_executa_Descarte_uuid_funcionario_fkey" FOREIGN KEY ("uuid_funcionario") REFERENCES "Pessoa"("uuid_pessoa") ON DELETE RESTRICT ON UPDATE CASCADE;
