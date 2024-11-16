
SELECT empregado.nome
FROM empregado, departamento
WHERE empregado.depto = departamento.numero
AND departamento.nome = 'Engenharia Civil';

SELECT projeto.numero, departamento_projeto.numero_depto, empregado.nome
FROM projeto, departamento_projeto, departamento, empregado
WHERE projeto.numero = departamento_projeto.numero_projeto
AND departamento_projeto.numero_depto = departamento.numero
AND departamento.rg_gerente = empregado.rg
AND projeto.localizacao = 'São Paulo';

SELECT empregado.nome
FROM empregado, empregado_projeto
WHERE empregado.rg = empregado_projeto.rg_empregado
AND empregado_projeto.numero_projeto IN (SELECT departamento_projeto.numero_projeto
                                         FROM departamento_projeto
                                         WHERE departamento_projeto.numero_depto = 3)
GROUP BY empregado.nome
HAVING COUNT(DISTINCT empregado_projeto.numero_projeto) = (SELECT COUNT(*)
                                                           FROM departamento_projeto
                                                           WHERE departamento_projeto.numero_depto = 3);

SELECT DISTINCT projeto.numero
FROM projeto, departamento_projeto, departamento, empregado, empregado_projeto
WHERE projeto.numero = departamento_projeto.numero_projeto
AND departamento_projeto.numero_depto = departamento.numero
AND (departamento.rg_gerente = empregado.rg OR empregado.rg = empregado_projeto.rg_empregado)
AND projeto.numero = empregado_projeto.numero_projeto
AND empregado.nome = 'Fernando';

SELECT empregado.nome
FROM empregado
LEFT JOIN dependentes ON empregado.rg = dependentes.rg_responsavel
WHERE dependentes.rg_responsavel IS NULL;

SELECT DISTINCT empregado.nome
FROM empregado, dependentes, departamento
WHERE empregado.rg = dependentes.rg_responsavel
AND empregado.rg = departamento.rg_gerente;

SELECT DISTINCT departamento_projeto.numero_depto
FROM projeto, departamento_projeto
WHERE projeto.numero = departamento_projeto.numero_projeto
AND projeto.localizacao = 'Rio Claro';

SELECT DISTINCT empregado.nome, empregado.rg
FROM empregado
WHERE empregado.rg IN (SELECT empregado.rg_supervisor FROM empregado WHERE empregado.rg_supervisor IS NOT NULL);

SELECT empregado.nome
FROM empregado
WHERE empregado.salario >= 2000.00;

SELECT empregado.nome
FROM empregado
WHERE empregado.nome LIKE 'J%';

SELECT empregado.nome
FROM empregado
WHERE empregado.nome LIKE '%Luiz%' OR empregado.nome LIKE '%Luis%';

SELECT empregado.nome
FROM empregado, departamento
WHERE empregado.depto = departamento.numero
AND departamento.nome = 'Engenharia Civil';

SELECT DISTINCT departamento.nome
FROM departamento, departamento_projeto, projeto
WHERE departamento.numero = departamento_projeto.numero_depto
AND departamento_projeto.numero_projeto = projeto.numero
AND projeto.nome = 'Motor 3';

SELECT DISTINCT empregado.nome
FROM empregado, empregado_projeto, projeto
WHERE empregado.rg = empregado_projeto.rg_empregado
AND empregado_projeto.numero_projeto = projeto.numero
AND projeto.nome = 'Financeiro 1';

SELECT empregado.nome
FROM empregado, empregado supervisor
WHERE empregado.rg_supervisor = supervisor.rg
AND supervisor.salario BETWEEN 2000 AND 2500;

SELECT DISTINCT empregado.nome
FROM empregado, dependentes, departamento
WHERE empregado.rg = dependentes.rg_responsavel
AND empregado.rg = departamento.rg_gerente;

UPDATE empregado
SET salario = 3000.00
WHERE depto = 2;

UPDATE empregado
SET salario = salario * 1.10;

SELECT AVG(salario) AS media_salarial
FROM empregado;

SELECT empregado.nome
FROM empregado
WHERE empregado.salario > (SELECT AVG(salario) FROM empregado)
ORDER BY empregado.nome;
