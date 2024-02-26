---Atividade 01 Topico em banco de dados 
CREATE TABLE paises (
    codigo SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL
);

CREATE TABLE estados (
    codigo SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL,
    pais INTEGER NOT NULL,
    FOREIGN KEY (pais) REFERENCES paises(codigo)
);

CREATE TABLE cidades (
    codigo SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL,
    estado INTEGER NOT NULL,
    FOREIGN KEY (estado) REFERENCES estados(codigo)
);

CREATE TABLE organizacoes (
    codigo SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL
);

CREATE TABLE estacoes (
    codigo SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    cidade INTEGER NOT NULL,
    organizacao INTEGER NOT NULL,
    FOREIGN KEY (cidade) REFERENCES cidades(codigo),
    FOREIGN KEY (organizacao) REFERENCES organizacoes(codigo)
);

CREATE TABLE dados (
    codigo BIGSERIAL PRIMARY KEY,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    estacao INTEGER NOT NULL,
    temperatura DOUBLE PRECISION NOT NULL,
    chuva DOUBLE PRECISION NOT NULL,
    dirVento TEXT NOT NULL,
    umidade INTEGER NOT NULL,
    pressao INTEGER NOT NULL,
    FOREIGN KEY (estacao) REFERENCES estacoes(codigo)
);


INSERT INTO paises (descricao) VALUES ('Brasil');
INSERT INTO estados (descricao, pais) VALUES ('RS', (SELECT codigo FROM paises WHERE descricao = 'Brasil'));
INSERT INTO cidades (descricao, estado) VALUES ('Passo Fundo', (SELECT codigo FROM estados WHERE descricao = 'RS'));
INSERT INTO organizacoes (descricao) VALUES ('INPE');
INSERT INTO estacoes (descricao, latitude, longitude, cidade, organizacao) VALUES ('A0067', -58.7908, -28.6759, (SELECT codigo FROM cidades WHERE descricao = 'Passo Fundo'), (SELECT codigo FROM organizacoes WHERE descricao = 'INPE'));
INSERT INTO dados (data, hora, estacao, temperatura, chuva, dirVento, umidade, pressao) VALUES 
('2021-02-12', '01:00', (SELECT codigo FROM estacoes WHERE descricao = 'A0067'), 25, 0, 'Norte', 70, 40),
('2021-02-12', '02:00', (SELECT codigo FROM estacoes WHERE descricao = 'A0067'), 26, 0, 'Norte', 65, 45),
('2021-02-12', '03:00', (SELECT codigo FROM estacoes WHERE descricao = 'A0067'), 26, 0, 'Sul', 70, 50),
('2021-02-12', '04:00', (SELECT codigo FROM estacoes WHERE descricao = 'A0067'), 27, 0, 'Norte', 60, 60);

INSERT INTO cidades (descricao, estado) VALUES ('Marau', (SELECT codigo FROM estados WHERE descricao = 'RS'));
INSERT INTO organizacoes (descricao) VALUES ('EMBRAPA');
INSERT INTO estacoes (descricao, latitude, longitude, cidade, organizacao) VALUES ('A0089', -60.7896, -29.7894, (SELECT codigo FROM cidades WHERE descricao = 'Marau'), (SELECT codigo FROM organizacoes WHERE descricao = 'EMBRAPA'));
INSERT INTO dados (data, hora, estacao, temperatura, chuva, dirVento, umidade, pressao) VALUES 
('2021-02-12', '01:00', (SELECT codigo FROM estacoes WHERE descricao = 'A0089'), 25.9, 0, 'Norte', 70, 40),
('2021-02-12', '02:00', (SELECT codigo FROM estacoes WHERE descricao = 'A0089'), 26.1, 0, 'Norte', 65, 45),
('2021-02-12', '03:00', (SELECT codigo FROM estacoes WHERE descricao = 'A0089'), 26.1, 0, 'Sul', 70, 50),
('2021-02-12', '04:00', (SELECT codigo FROM estacoes WHERE descricao = 'A0089'), 27.5, 0, 'Norte', 60, 60);

SELECT* FROM dados
WHERE estacao = 1