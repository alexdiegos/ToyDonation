# Projeto de Desenvolvimento Nativo para iOS (Atividade 4)

## Curso: Pós-Graduação em Desenvolvimento Mobile
## Disciplina: Desenvolvimento Nativo para iOS
## Aluno: Alexandre Diego Santos Silva
## Sala: 185835

Como todos nós já fomos criança um dia, é bem provável que tenhamos em casa algum brinquedo que não utilizamos mais. Ou então temos acesso a crianças (irmãos/irmãs mais novas, primos ou até mesmo filhos e filhas) que possuem em seu armário alguns brinquedos que já não fazem mais parte da brincadeira do dia-a-dia. Não seria ótimo se tivesse uma forma de divulgarmos esses brinquedos de modo que crianças carentes ou de famílias mais humildes pudessem ter acesso a esses brinquedos? 

É exatamente isso que se trata o aplicativo, os usuários irão listar ou procurar por brinquedos para doação!

1. O aplicativo terá 2 telas: Listagem de brinquedos, Cadastro/Alteração;

2. A tela inicial será a tela de Listagem de brinquedos, uma TableViewController onde serão listados todos os brinquedos disponíveis no aplicativo. Nesta lista deverá aparecer o nome do brinquedo e o estado de conservação (Novo, Usado, Precisa de reparo);

3. A navegação entre as telas será feita via NavigationController;

4. A partir da tela inicial o usuário poderá cadastrar um novo brinquedo (clicando em algum botão presente) ou selecionar um dos brinquedos listados;

5. Ele também poderá excluir um brinquedo utilizando o gesto de Swipe;

6. Ao selecionar um brinquedo, ele será levado para a tela de Cadastro/Alteração, onde serão apresentados todos os dados do mesmo, que são:

	a. Nome do brinquedo
	
	b. Estado de conservação (segmented control com os 3 estados)
	
	c. Nome do doador
	
	d. Endereço
	
	e. Telefone

Segue abaixo um exemplo:

- Nome do brinquedo: Barbie Sereia

- Estado de conservação: Usado

- Nome do doador: Joaquim de Oliveira

- Endereço: Avenida Lins de Vasconcelos, 5000

- Telefone: (00) 0000-0000

7. A partir dessa tela, ele poderá voltar para a tela de Listagem ou fazer a alteração dos dados do brinquedo;

8. A tela de Edição/Criação servirá tanto para a edição de um novo registro (alteração dos seus dados) quanto para a criação de um novo. Se ela for acessada a partir do botão de criação na tela Listagem de brinquedos, ela entrará no modo "Criação";

9. Os dados deverão ser armazenados utilizando Cloud Firestore;