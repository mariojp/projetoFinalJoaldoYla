INSERT INTO usuario(data_criacao, data_ultimo_acesso, flag_ativo, login, nome, senha)
values ('2021-12-20 18:47:52', '2021-12-21 18:47:52', true, 'neivacaju', 'Neiva', '$2a$10$Le.iEd4ISlBGn65MJuSeMuLfwlcES6zMfHKBnm07xWKfTAv1S/sw6'),
       ('2021-12-20 18:47:52', '2021-12-21 18:47:52', true, 'yla', 'Yla Buri', '$2a$10$76rLhrHoVlJNxT9lvmV3LuqBwVYrAtJ3akT1ahV3viS7cSo42Tpq.'),
       ('2021-12-20 18:47:52', '2021-12-21 18:47:52', true, 'joaldo', 'Joaldo Tavares', '$2a$10$76rLhrHoVlJNxT9lvmV3LuqBwVYrAtJ3akT1ahV3viS7cSo42Tpq.');

INSERT INTO perfil(nome)
values('Admin'),
('Aluno'),
('Professor');

INSERT INTO tarefa(descricao, status, titulo, usuario_id)
values ('Digite numeros separados por espaço que a soma seja 10', 1, 'Até 10', 3),
       ('Mostre a divisão entre dois numeros', 1, 'Divisão', 3);

INSERT INTO caso_teste(comparacao, entrada, flag_exibir, nome_teste, saida, tarefa_id)
values (1, '1 2 3 4', true, 'Até 10', '10', 1),
       (2, '5 5', false, 'Até 10', '10', 1),
       (2, '7 1 1 1', true, 'Até 10', '10', 1),
       (1, '4 2', true, 'teste 1', '2', 2),
       (1, '10 0', true, 'divisão por 0', 'undefined', 2),
       (1, '8 2', true, 'teste 2', '4', 2) ;

INSERT INTO USUARIO_PERFIL(USUARIO_ID, PERFIL_ID)
values (1, 1),(2, 2),(3, 3);

INSERT INTO PROVA(DATA_ENTREGA, NOME)
values ('2022-11-11 23:59:59', 'Prova final');

INSERT INTO PROVA_TAREFAS(PROVA_ID, TAREFA_ID)
values (1, 1);
