# desafio_final_dart
Desafio Final Dart - Academia do Flutter

Popular tabelas do MySql com estados e cidades do Brasil consumindo as API do IBGE:
versões utilizadas dos packages.
mysql1: ^0.19.2
http: ^0.13.4


Links APIs IBGE:
https://servicodados.ibge.gov.br/api/v1/localidades/estados
https://servicodados.ibge.gov.br/api/v1/localidades/estados/35/distritos

Script usado para criar as tabelas:

CREATE TABLE estado (
  id int not null primary key auto_increment,
  uf varchar(2),
  nome varchar(255)
);

CREATE TABLE cidade (
  id int not null primary key auto_increment,
  id_uf int,
  nome varchar(255),
   FOREIGN KEY (id_uf)
      REFERENCES estado(id)
);​
