# Projeto Conceitual de Banco de Dados – Oficina Mecânica

Este repositório apresenta o **modelo conceitual** e a implementação de um banco de dados para um **sistema de controle e gerenciamento de execução de ordens de serviço** em uma oficina mecânica.

---

## 📌 Objetivo
O projeto tem como meta organizar e gerenciar:
- **Clientes e Veículos** que passam por consertos ou revisões periódicas.
- **Equipes de mecânicos** responsáveis por avaliar, executar e finalizar serviços.
- **Ordens de Serviço (OS)**, incluindo mão de obra e peças utilizadas.

---

## 🗂️ Descrição Geral
- Clientes levam seus veículos para **conserto** ou **revisões periódicas**.  
- Cada veículo é designado a uma **equipe de mecânicos**, que:
  1. **Avalia** o problema.
  2. **Preenche a OS** (Ordem de Serviço) com a data de entrega e serviços necessários.
  3. **Calcula o valor** total com base em:
     - Tabela de referência de **mão de obra**.
     - Preço das **peças** utilizadas.
- O **cliente autoriza** a execução antes do início.
- A **mesma equipe** que avalia é responsável por executar os serviços.

---

## 🏆 Benefícios do Modelo
- **Controle Completo**: desde a avaliação do veículo até a entrega final.
- **Rastreabilidade**: registro detalhado de serviços, peças e custos.
- **Gestão de Equipes**: permite identificar o desempenho de mecânicos e líderes.
- **Precisão Financeira**: cálculo automático com base em tabelas de referência.

---

## 📷 Diagrama
O diagrama ER completo encontra-se na imagem abaixo:

<img width="1001" height="1325" alt="diagrama_oficina" src="https://github.com/user-attachments/assets/a45dcc2f-e800-498e-8b8c-0697f58a17af" />

---

## 👨🏻‍💻 Implementação

A implementação do diagrama conceitual está localizado no arquivo [BD_oficina_Mecanica.sql](BD_oficina_Mecanica.sql).

---

**Autor:** Wesley Calsonari Nogueira  
