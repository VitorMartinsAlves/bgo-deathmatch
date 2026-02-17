--[[
inventoryElem = { 'craft', 'weapon', 'key', 'bag'}
row = 5 
column = 10 
baseWeight = 25 
oneLevelBag = 35 
premiumLevelBag = 45 
oneLevelBagID = 150 
premiumLevelBagID = 151
maxCraftSlot = 16
maxCraftRecipe = 9 
]]--


itemLists = {
	{name = "Hamburger", desc="Sabores favoritos da América se juntam com delicadeza.", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --1
	{name = "Taco", desc="O melhor fast food da cidade.", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --2
	{name = "Big Mac", desc="McDonald's.", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --3
	{name = "Sanduíche", desc="Sanduíche de queijo ricamente embalado.", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --4
	{name = "Pizza", desc="A comida mais popular da cidade.", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --5
	{name = "bolo", desc="Muitos são doces doces.", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --6
	{name = "Bebida laranja", desc="O café da manhã é refrescante.", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --7
	{name = "Copo de água", desc="Uma das chaves para a sobrevivência.", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --8
	{name = "Cerveja engarrafada", desc="Uma bebida favorita com amigos.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --9
	{name = "Vodka", desc="O álcool é uma bebida popular.", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --10
	{name = "Whiskey", desc="Uma bebida alcoólica forte.", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --11
	{name = "Cola", desc="A bebida popular da cidade.", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --12
	{name = "Uma caixa de cigarros", desc="É bom para o nervosismo a qualquer momento.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --13
	{name = "cocaína", desc="Droga forte que pode ser absorvida.", weight=0.4, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --14
	{name = "heroína", desc="É um tipo popular de drogas.", weight=0.4, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --15
	{name = "Iphone 7", desc="O meio mais importante de comunicação.", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --16
	{name = "Energético", desc="Dê uma acelerada em sua vida!", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --17
	{name = "Lock Pick", desc="Ideal para abrir as coisas.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --18
	{name = "Chave segura", desc="Chave para um cofre.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'key'}, --19
	{name = "Radio", desc="Ferramenta de contato rápido.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --20
	{name = "Ferro e Plástico", desc="Usado em craft de itens!", weight=2.0, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --21
	{name = "Dinheiro Sujo", desc="Isso não é legal!", weight=0, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --22
	{name = "Streamer BGO", desc="Sou streamer oficial do BGO", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --23
	{name = "C4", desc="Util para explodir as coisas.", weight=2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --24
	{name = "corda", desc="Dispositivo usado para interceptar outro.", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --25
	{name = "Gasolina", desc="Porque a gasolina é sempre boa.", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --26
	{name = "Dipiroca", desc="Remedio para tratamento do vicio.", weight=0.4, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --27
	{name = "licença", desc="Acarta de condução.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --28
	{name = "Cartão de identificação", desc="Sua identificação pessoal.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --29
	{name = "máscara de gás", desc="Dispositivo usado para evitar fumaça.", weight=0.4, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --30
	{name = "Granada de fumaça", desc="Granada de fumaça.", weight=0.5, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --31
	{name = "Algemas", desc="Dispositivo para capturar pessoas.", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --32
	{name = "Chave de fixação", desc="Uma chave para um grampo.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --33
	{name = "Identificação de deficiente auditivo", desc="Queremos você aqui com a gente! S2", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --34
	{name = "boxeador", desc="É uma arma popular de tentativas.", weight=1, stack = false, weaponID = 1, AmmoID = false, level=2, itemTypes= 'weapon'}, --35
	{name = "machado", desc="Ferramenta para cortar madeira.", weight=1, stack = false, weaponID = 2, AmmoID = false, level=0, itemTypes= 'bag'}, --36
	{name = "cassetete", desc="Uma arma popular de defesa.", weight=0.7, stack = false, weaponID = 3, AmmoID = false, level=2, itemTypes= 'weapon'}, --37
	{name = "faca", desc="Ferramenta de corte poderosa que é perigosa.", weight=0.7, stack = false, weaponID = 4, AmmoID = false, level=2, itemTypes= 'weapon'}, --38
	{name = "Baseball", desc="Uma ferramenta popular para esportes de beisebol.", weight=1, stack = false, weaponID = 5, AmmoID = false, level=2, itemTypes= 'weapon'}, --39
	{name = "Machado Premium", desc="Rápido rápido e rápido....", weight=0.2, stack = false, weaponID = 12, AmmoID = false, level=0, itemTypes= 'bag'}, --40
	{name = "Picareta Premium", desc="Rápido rápido e rápido....", weight=1, stack = false, weaponID = 10, AmmoID = false, level=0, itemTypes= 'bag'}, --41
	{name = "Picareta", desc="O objeto usado para mineração.", weight=1, stack = false, weaponID = 11, AmmoID = false, level=0, itemTypes= 'bag'}, --42
	{name = "Molotov", desc="Há um fogo forte quando você joga.", weight=0.4, stack = false, weaponID = 18, AmmoID = false, level=4, itemTypes= 'weapon'}, --43
	{name = "Desert Eagle", desc="Uma arma com risco de vida contendo munição forte.", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --44
	{name = "Arna de choque", desc="É uma arma popular de aplicação da lei.", weight=1, stack = false, weaponID = 23, AmmoID = false, level=0, itemTypes= 'weapon'}, --45
	{name = "Colt-45", desc="O menor pedaço de pistola.", weight=1.5, stack = false, weaponID = 22, AmmoID = 57, level=3, itemTypes= 'weapon'}, --46
	{name = "Espingarda shotgun espingarda", desc="Arma grande calibre que é muito perigoso.", weight=3, stack = false, weaponID = 26, AmmoID = 60, level=3, itemTypes= 'weapon'}, --47
	{name = "Combat shotgun", desc="Arma popular do terrorista.", weight=4, stack = false, weaponID = 27, AmmoID = 60, level=3, itemTypes= 'weapon'}, --48
	{name = "Micro Uzi", desc="A arma popular dos julgamentos.", weight=3.5, stack = false, weaponID = 28, AmmoID = 61, level=3, itemTypes= 'weapon'}, --49
	{name = "MP5", desc="Arma popular do terrorista.", weight=2.5, stack = false, weaponID = 29, AmmoID = 61, level=3, itemTypes= 'weapon'}, --50
	{name = "AK-47", desc="Arma grande calibre que é perigoso.", weight=4.1, stack = false, weaponID = 30, AmmoID = 58, level=3, itemTypes= 'weapon'}, --51
	{name = "M16", desc="Arma grande calibre que é perigoso.", weight=3.5, stack = false, weaponID = 31, AmmoID = 59, level=3, itemTypes= 'weapon'}, --52
	{name = "Tec-9", desc="A arma popular dos julgamentos.", weight=1.8, stack = false, weaponID = 32, AmmoID = 61, level=3, itemTypes= 'weapon'}, --53
	{name = "Spray", desc="Pintura de parede é sua ferramenta favorita.", weight=0.7, stack = false, weaponID = 41, AmmoID = false, level=1, itemTypes= 'weapon'}, --54
	{name = "Extintor de incêndio", desc="Um objeto usado para extinguir um incêndio.", weight=1, stack = false, weaponID = 42, AmmoID = false, level=0, itemTypes= 'weapon'}, --55
	{name = "câmera", desc="Um par de boas fotos vem a qualquer momento bem.", weight=0.5, stack = false, weaponID = 43, AmmoID = false, level=1, itemTypes= 'weapon'}, --56
	{name = "Amortecedor", desc="Peças para arrumar um veículo.", weight=0.03, stack = true, weaponID = false, AmmoID = false, level=3, itemTypes= 'weapon'}, --57
	{name = "Para-brisa", desc="Peças para arrumar um veículo.", weight=0.04, stack = true, weaponID = false, AmmoID = false, level=3, itemTypes= 'weapon'}, --58
	{name = "Porta Malas", desc="Peças para arrumar um veículo.", weight=0.04, stack = true, weaponID = false, AmmoID = false, level=3, itemTypes= 'weapon'}, --59
	{name = "Porta", desc="Peças para arrumar um veículo.", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=3, itemTypes= 'weapon'}, --60
	{name = "Motor", desc="Peças para arrumar um veículo.", weight=0.03, stack = true, weaponID = false, AmmoID = false, level=3, itemTypes= 'weapon'}, --61
	{name = "Cofre", desc="Guarde suas coisas em um cofre seguro!", weight=9.2, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --62
	{name = "Paraquedas", desc="Para amortecer a queda!", weight=5.0, stack = true, weaponID = 46, AmmoID = 50, level=0, itemTypes= 'weapon'}, --63
	{name = "Kit de primeiros socorros", desc="É necessário para salvar a vida.", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --64
	{name = "Primeiros Socorros", desc="Injeta adrenalina!", weight=0.02, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --65
	{name = "Objeto desconhecido", desc="Nenhuma descrição...", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --66
	{name = "isqueiro", desc="É bom para o charuto a qualquer momento.", weight=0.05, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --67
	{name = "Magnum Sniper", desc="Uma segmentação e baaammm.", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --68
	{name = "Capo", desc="Peças para arrumar um veículo.", weight=0.04, stack = true, weaponID = false, AmmoID = false, level=3, itemTypes= 'weapon'}, --69
	{name = "Cartão Reparar", desc="Imediatamente repara o veículo para a rede.", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --70
	{name = "Cartão de reabastecimento", desc="Puxa o veículo para fora.", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --71
	{name = "Bilhete de PP (5000)", desc="Bilhete com 5000 PP!", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --72
	{name = "cortando tensão", desc="Os bombeiros podem precisar disso enormemente.", weight=2.5, stack = false, weaponID = 6, AmmoID = false, level=0, itemTypes= 'bag'}, --73
	{name = "Alicate", desc="O veículo é uma ferramenta para joalharia.", weight=0.4, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --74
	{name = "chave", desc="Bombeiros são realmente usados para desligar.", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --75
	{name = "Bilhete de PP (1000)", desc="Bilhete com 1000 PP!", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --76
	{name = "Bilhete de PP (2000)", desc="2.000 ingressos de PP!", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --77
	{name = "Cartão HP", desc="Médico? Resgate? vc não precisa disso!", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --78
	{name = "Balas expostas", desc="Uma bala de uma pessoa ferida.", weight=0.03, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --79
	{name = "pinça", desc="Ferramenta para remover cartuchos.", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --80
	{name = "desfibrilador", desc="Dispositivos de resgate de ambulância.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --81
	{name = "Bloco de ouro", desc="Banco famoso de Foster Valleyi...", weight=2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --82
	{name = "furadeira", desc="Seu nome também mostra o que é bom.", weight=5, stack = false, weaponID = false, AmmoID = false, level=3, itemTypes= 'weapon'}, --83
	{name = "Colete à prova de balas", desc="Uma pessoa prevenida sempre tem um.", weight=2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --84
	{name = "vara de pesca", desc="Um bom momento para carregar.", weight=0.4, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --85
	{name = "carpa", desc="É isso! Nice mordida!", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --86
	{name = "sargo", desc="É isso! Nice mordida!", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --87
	{name = "bota", desc="Um par de botas que estão em mau estado.", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --88
	{name = "Peixe morto", desc="Ele nadou no topo da água...", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --89
	{name = "lata", desc="Uma lata vazia.", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --90
	{name = "alga", desc="Sobre a água.", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --91
	{name = "atum", desc="É isso! Mordida agradável!", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --92
	{name = "polvo", desc="É isso! Nice mordida!", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --93
	{name = "pescador", desc="É isso! Nice mordida!", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --94
	{name = "espadarte", desc="É isso! Nice mordida", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --95
	{name = "linguado", desc="É isso! Nice mordida!", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --96
	{name = "Troféu Urso", desc="Uma lembrança de urso com fome!", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --97
	{name = "Troféu de raposa", desc="Uma lembrança de uma raposa faminta!", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --98
	{name = "Troféu lobo", desc="Lembrança de um lobo faminto!", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --99
	{name = "pele de urso", desc="Uma lembrança de urso faminto!", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --100
	{name = "troféu de raposa", desc="Uma lembrança de raposa faminta!", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --101
	{name = "pele de lobo", desc="Lembrança de um lobo faminto!", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --102
	{name = "Rifle M40A1", desc="Arma popular dos caçadores.", weight=4, stack = false, weaponID = 33, AmmoID = 69, level=3, itemTypes= 'weapon'}, --103
	{name = "Alfa no peito", desc="O que você pode esconder?", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --104
	{name = "Caixa de armas simples", desc="O que você pode esconder?", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --105
	{name = "Caixa de armas Dourada", desc="TESTE SUA SORTE!!!", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --106
	{name = "Caixa de armas Patriota", desc="TESTE SUA SORTE!!!", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --107
	{name = "Caixa de armas premium", desc="O que você pode esconder?", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --108
	{name = "20 milhões", desc="20 milhões de reais.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --109
	{name = "Bilhete de loteria", desc="Um cupom que pode trazer alguma coisa para o futuro.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --110
	{name = "Passaporte", desc="Passaporte para los santos!", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --111
	{name = "Porte de Arma", desc="Permissão para guardar armas.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --112

	{name = "Cartão de reparo!", desc="Reparar veiculo 100%", weight=4.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --113
	{name = "Gasolina 100%", desc="Abastecer veiculo 100%", weight=4.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --114
	{name = "Virar veiculo capotado!", desc="desvirar veiculo!", weight=4.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --115


	{name = "MP5 Royal", desc="Adesivo de arma..", weight=2.5, stack = false, weaponID = 29, AmmoID = 61, level=3, itemTypes= 'weapon'}, --116
	{name = "MP5 Hyper Beast", desc="Adesivo de arma..", weight=2.5, stack = false, weaponID = 29, AmmoID = 61, level=3, itemTypes= 'weapon'}, --117
	{name = "MP5 Fade", desc="Adesivo de arma..", weight=2.5, stack = false, weaponID = 29, AmmoID = 61, level=3, itemTypes= 'weapon'}, --118
	{name = "Pinky Desert Eagle", desc="O PODER ROSA!", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --199
	{name = "M16 BOOM", desc="SHOW, SHOW! A MELHOR!", weight=3.5, stack = false, weaponID = 31, AmmoID = 59, level=3, itemTypes= 'weapon'}, --120
	--{name = "Iphone 7", desc="O meio mais imp", weight=0.3, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --16


	{name = "Red Shade Uzi", desc="Adesivo de arma..", weight=3.5, stack = false, weaponID = 28, AmmoID = 61, level=3, itemTypes= 'weapon'}, --121
	{name = "MP5 Cobalt", desc="Adesivo de arma..", weight=2.5, stack = false, weaponID = 29, AmmoID = 61, level=3, itemTypes= 'weapon'}, --122
	{name = "Gold Uzi", desc="Adesivo de arma..", weight=3.5, stack = false, weaponID = 28, AmmoID = 61, level=3, itemTypes= 'weapon'}, --123
	{name = "Blue Camo Uzi", desc="Adesivo de arma..", weight=3.5, stack = false, weaponID = 28, AmmoID = 61, level=3, itemTypes= 'weapon'}, --124
	{name = "Desert Eagle - LEGALIZADA", desc="Não é VIP", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --125
	{name = "M16 Plublack", desc="ELA VOLTO A SER VIP!", weight=3.5, stack = false, weaponID = 31, AmmoID = 59, level=3, itemTypes= 'weapon'}, --126
	{name = "Artic Magnum", desc="Adesivo de arma..", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --127
	{name = "Shoutgun", desc="A sörtétesek legidősebb darabja.", weight=4, stack = false, weaponID = 25, AmmoID = 60, level=3, itemTypes= 'weapon'}, --128
	{name = "Shoutgun Asiimov", desc="Diz a lenda que ninguem sobrevive a 1 tiro.", weight=4, stack = false, weaponID = 25, AmmoID = 60, level=3, itemTypes= 'weapon'}, --129
	{name = "Shotgun Viper", desc="Adesivo de arma..", weight=4, stack = false, weaponID = 25, AmmoID = 60, level=3, itemTypes= 'weapon'}, --130
	{name = "Tec-9 BOOM", desc="Adesivo de arma..", weight=1.8, stack = false, weaponID = 32, AmmoID = 61, level=3, itemTypes= 'weapon'}, --131
	{name = "Red Vein Tec-9", desc="Não consegue né? a melhor TEC 9", weight=1.8, stack = false, weaponID = 32, AmmoID = 61, level=3, itemTypes= 'weapon'}, --132
	{name = "AK-47 Asiimov", desc="Adesivo de arma..", weight=4.1, stack = false, weaponID = 30, AmmoID = 58, level=3, itemTypes= 'weapon'}, --133
	{name = "Spider faca", desc="Adesivo de arma..", weight=0.7, stack = false, weaponID = 4, AmmoID = false, level=2, itemTypes= 'weapon'}, --134
	{name = "Camo faca", desc="Adesivo de arma..", weight=0.7, stack = false, weaponID = 4, AmmoID = false, level=2, itemTypes= 'weapon'}, --135
	{name = "Licença de caça", desc="Licença para caçar.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --136
	{name = "Semente de maconha", desc="ilegal...", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --137
	{name = "amolador", desc="Uma estrutura útil!", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --138
	{name = "semente de cocaína", desc="ilegal...", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --139
	{name = "vazo vazia", desc="Um vazo vazio.", weight=0.5, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --140
	{name = "vazo com terra", desc="um vazo com terra.", weight=1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --141
	{name = "vazo com semente (k)", desc="Uma vazo com semente de cocaína.", weight=1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --142
	{name = "vazo com semente (m)", desc="Uma vazo com sementes de maconha.", weight=1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --143
	{name = "Cigarro Maconha", desc="ilegal...", weight=0.4, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --144
	{name = "Maconha não processada", desc="ilegal.", weight=2.0, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --145
	{name = "envasamento solo", desc="Material básico para plantio.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --146
	{name = "Regador", desc="Para cuidar de flores.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --147
	{name = "OCB", desc="OCB...", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --148
	{name = "Maconha moída", desc="Um punhado de maconha picada...", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --149
	{name = "Bolsa", desc="Se você precisar de mais objetos, sempre vem bem.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --150
	{name = "Bolsa premium", desc="Se você precisar de mais objetos, sempre vem bem.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --151
	{name = "Escudo da polícia", desc="Vale a pena defender com isso.", weight=1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --152
	{name = "vara", desc="Um pedaço de pau.", weight=1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --153
	{name = "linha de pesca", desc="linha para a vara de pesca.", weight=1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --154
	{name = "gancho", desc="Para pegar peixe.", weight=1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --155
	{name = "isca", desc="Uma isca para um gancho.", weight=1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --156
	{name = "fuso", desc="Coloque no pau depois de pescar e pescar.", weight=1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --157
	{name = "vara de pesca( Com ísca )", desc="Uma ferramenta para pescar", weight=0.4, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --158
	{name = "martelo", desc="Ferramenta para DIY.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --159
	{name = "Estrutura interna AK-47", desc="Uma estrutura interna AK-47.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --160
	{name = "Tubo de AK-47", desc="Um tubo AK-47.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --161
	{name = "Garra AK-47", desc="Um aperto AK-47.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --162
	{name = "AK-47 Astúcia", desc="Um corpo de AK-47.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --163
	{name = "Biblioteca AK-47", desc="Um pacote AK-47.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --164
	{name = "Suporte de ombro AK-47", desc="Um suporte de ombro AK-47.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --165
	{name = "estrutura interna M16", desc="Uma estrutura interna M16.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --166
	{name = "Punho Do Tubo M16", desc="Um clipe de tubo M16.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --167
	{name = "Tubo M16", desc="Com um tubo M16.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --168
	{name = "Guiador M16", desc="Um aperto M16.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --169
	{name = "M16 Astúcia", desc="EM16 rima.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --170
	{name = "Alcatrão M16", desc="Uma tara M16.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --171
	{name = "Suporte de ombro M16", desc="Um suporte de ombro M16.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --172
	{name = "Estrutura Interna Desert Eagle", desc="A estrutura interna de uma Desert Eagle.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --173
	{name = "Desert Eagle repositório", desc="Um aperto Eagle Desert.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --174
	{name = "Desert Eagle manhoso", desc="Uma framboesa Águia do deserto.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --175
	{name = "Desert Eagle repositório", desc="Um repositório Desert Eagle.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --176
	{name = "Colt-45 Estrutura interna", desc="Uma estrutura interna de um Colt-45.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --177
	{name = "Colt-45 punho", desc="Um aperto Colt-45.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --178
	{name = "Colt-45 repositório", desc="Uma runa do Colt-45.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --179
	{name = "Alcatrão Colt-45", desc="Uma repositório Colt-45.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --180
	{name = "M40A1 Estrutura interna", desc="Uma estrutura interna de um M40A1.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --181
	{name = "Binóculos M40A1", desc="Um telescópio M40A1.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --182
	{name = "Tubo M40A1", desc="Um tubo M40A1.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --183
	{name = "M40A1 Astúcia", desc="Uma navalha de um M40A1.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --184
	{name = "Alcatrão M40A1", desc="Um pacote M40A1.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --185
	{name = "Suporte de ombro M40A1", desc="Um suporte de ombro M40A1.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --186
	{name = "Estrutura Interna MP5", desc="Uma estrutura interna de um MP5.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --187
	{name = "Tubo mp5", desc="um tubo MP5.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --188
	{name = "Guiador MP5", desc="Um aperto MP5.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --189
	{name = "MP5 Cunning", desc="Um ancinho MP5.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --190
	{name = "Suporte de ombro MP5", desc="Um suporte de ombro MP5.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --191
	{name = "Armazenamento MP5", desc="Uma tara MP5.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --192
	{name = "Micro Uzi Estrutura interna", desc="Uma estrutura interna de uma Micro Uzi.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --193
	{name = "Tubo Micro Uzi", desc="Um tubo Micro Uzi.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --194
	{name = "Punho de tubo micro Uzi", desc="Um aperto de tubo Micro Uzi.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --195
	{name = "Micro Uzi manhoso", desc="Um Micro Uzi Ravass.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --196
	{name = "Micro Uzi tara", desc="Uma tara Micro Uzi.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --197
	{name = "Suporte Micro Ombro Uzi", desc="Suporte de ombro Micro Uzi.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --198
	{name = "Estrutura Interior Shotgun", desc="Uma estrutura interna de uma espingarda.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --199
	{name = "Tubo de espingarda", desc="Um tubo de shotgun.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --200
	{name = "Estrutura de rolamento de espingarda", desc="Uma estrutura de enrolador de espingarda.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --201
	{name = "Espingarda espingarda", desc="Um, espingarda espingarda.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --202
	{name = "Suporte de Ombro de Espingarda", desc="Suporte de ombro de espingarda.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --203
	{name = "Tec9 Estrutura Interna", desc="Estrutura interna de um Tec9.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --204
	{name = "Tubo Tec9", desc="Um tubo Tec9.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --205
	{name = "Tec9 Markolat", desc="Um aperto Tec9.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --206
	{name = "Tec9 ravas", desc="Um Tec9 ravas.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --207
	{name = "Tec9 Tara", desc="Uma t9 Tec9.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --208
	{name = "Estrutura interna do Magnum Sniper", desc="A estrutura interna de um Magnum Sniper.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --209
	{name = "Binóculos Magnum Sniper", desc="Egy Magnum Sniper távcsőve.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --210
	{name = "Tubo de Atirador Magnum", desc="Um tubo magnum sniper.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --211
	{name = "Magnum Sniper Cute", desc="Uma investida de Magnum Sniper.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --212
	{name = "Magnum Sniper Store", desc="Um Magnum Sniper Tare.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --213
	{name = "Suporte Magnum Sniper Shoulder", desc="Suporte para Ombro Sniper Magnum.", weight=0.2, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --214
	{name = "cigarro", desc="Um cigarro de fibra .", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --215
	{name = "talão de cheques", desc="Para a polícia.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --216
	{name = "verificar", desc="cheque para ser pago.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --217
	{name = "Arbusto de cocaína", desc="ILEGAL.", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --218
	{name = "Arbusto de cocaína moída", desc="ILEGAL.", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --219
	{name = "Cortador de grama da mão", desc="Um cortador de grama de mão que é bom para cortar grama!", weight=1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --220
	{name = "Chave do portão", desc="A chave para um portão!", weight=1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --221
	{name = "Vice Magnum", desc="Adesivo de arma..", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --222
	{name = "Aliança Magnum", desc="Adesivo de arma..", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --223
	{name = "Dragon Magnum", desc="Adesivo de arma..", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --224
	{name = "Hyper Beast Magnum", desc="Adesivo de arma..", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --225
	{name = "Asiimov Magnum", desc="Adesivo de arma..", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --226
	{name = "UMA NOVIDADE ESTÁ POR VIR", desc="UMA NOVIDADE ESTÁ POR VIR", weight=0.05, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --227
	{name = "Contrato de venda", desc="Um contrato..", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --228
	{name = "caneta", desc="Para assinar contratos", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --229
	{name = "Blocos de dinheiro", desc="Tem dinheiro ilegal.", weight=0.00, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --230
	{name = "Heroina não Processada", desc="Heroina não refinada.", weight=2.00, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --231
	{name = "Heroina Processada", desc="Heroiba processada.", weight=2.00, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --232
	{name = "Pasta Base", desc="Cocaina.", weight=2.00, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --233
	{name = "Cocaina não processada", desc="Cocaina.", weight=2.00, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --234
	{name = "Laranja", desc="Produto legal.", weight=2.00, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --235
	{name = "Madeira", desc="Produto legal.", weight=2.00, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --236
	{name = "Trigo", desc="Produto legal.", weight=2.00, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --237
	{name = "M4A01 Masterbook", desc="Livro M4A01.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --238
	{name = "MP5 Masterbook", desc="Livro MP5.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --239
	{name = "Micro Uzi Masterbook", desc="Livro Micro Uzi.", weight=0.01, stack = false, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --240
	{name = "AK-47 Camo", desc="Excelente AK, uma das melhores!", weight=4.1, stack = false, weaponID = 30, AmmoID = 58, level=3, itemTypes= 'weapon'}, --241
	{name = "AK-47 Urban Camo", desc="Deixará de ser VIP no dia 03/04/2020..", weight=4.1, stack = false, weaponID = 30, AmmoID = 58, level=3, itemTypes= 'weapon'}, --242
	{name = "Desert Eagle Camo", desc="Adesivo de arma..", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --243
	{name = "MP5 Camo", desc="Adesivo de arma..", weight=2.5, stack = false, weaponID = 29, AmmoID = 61, level=3, itemTypes= 'weapon'}, --244
	{name = "MP5 Gold", desc="Adesivo de arma..", weight=2.5, stack = false, weaponID = 29, AmmoID = 61, level=3, itemTypes= 'weapon'}, --245
	{name = "Blue Colt-45", desc="Adesivo de arma..", weight=1.5, stack = false, weaponID = 22, AmmoID = 57, level=3, itemTypes= 'weapon'}, --246
	{name = "Army Camo Colt-45", desc="Adesivo de arma..", weight=1.5, stack = false, weaponID = 22, AmmoID = 57, level=3, itemTypes= 'weapon'}, --247
	{name = "M16 Maya", desc="Adesivo de arma..", weight=3.5, stack = false, weaponID = 31, AmmoID = 59, level=3, itemTypes= 'weapon'}, --248
	{name = "Minério de pedra de diamante", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --249
	{name = "Minério de ébano", desc="Que minério.", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --250
	{name = "Minério fossilizado", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --251
	{name = "Minério de ouro", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --252
	{name = "Minério de jade", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --253
	{name = "Minério de cristal", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --254
	{name = "Minério de cobre", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --255
	{name = "Minério de prata", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --256
	{name = "Minério de ouro branco", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --257
	{name = "Minério de rubi", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --258
	{name = "Minério de pólvora", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --259
	{name = "Minério de turmalina", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --260
	{name = "Minério de esmeralda", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --261
	{name = "Rejeitos de Minério", desc="Bem, não ganhou..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --262
	{name = "Minério de Ferro", desc="Que minério..", weight=0.05, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --263
	{name = "Barra de Ferro", desc="Uma pesada barra de ferro.", weight=1.5, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --264
	{name = "Esmeralda Faca", desc="Adesivo de arma..", weight=0.7, stack = false, weaponID = 4, AmmoID = false, level=2, itemTypes= 'weapon'}, --265
	{name = "Rubint faca", desc="Nada melhor quem um golpe sorrateiro", weight=0.7, stack = false, weaponID = 4, AmmoID = false, level=2, itemTypes= 'weapon'}, --266
	{name = "diamante faca", desc="Adesivo de arma..", weight=0.7, stack = false, weaponID = 4, AmmoID = false, level=2, itemTypes= 'weapon'}, --267
	{name = "diamante faca", desc="Valioso...", weight=3, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --268
	{name = "Rubi", desc="valioso...", weight=3, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --269
	{name = "esmeralda", desc="valioso...", weight=3, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --270
	{name = "zenhe", desc="Um látex.", weight=0.2, stack = true, weaponID = false, AmmoID = false, level=1, itemTypes= 'bag'}, --271
	{name = "Bilhete de PP (100)", desc="100 bilhete de PP!", weight=0.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --272
	{name = "chinelo", desc="2019 VERÃO!", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --273
	{name = "bola", desc="2019 VERÃO!", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --274
	{name = "sorvete", desc="2019 VERÃO!", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --275
	{name = "flutuador", desc="2019 VERÃO!", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --276
	{name = "Drone", desc="Veja tudo de cima!", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --277
	{name = "Aliança de Casamento", desc="Felizes para sempre!", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --278
	{name = "Aliança de Casamento Johnny & Elias", desc="Companheiros na vida real!", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --279
	{name = "Estepe", desc="Reparar pneu de seu veiculo", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --280
	{name = "Livro secreto ( EVENTO )", desc="É setembro...", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --281
	{name = "Bilhete OX", desc="É setembro...", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --282
	{name = "M16 EVENTO", desc="EVENTO", weight=0.1, stack = false, weaponID = 31, AmmoID = 284, level=0, itemTypes= 'weapon'}, --283
	{name = "EVENTO munição", desc="EVENTO", weight=0.01, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'weapon'}, --284
	{name = "Magnum EVENTO", desc="EVENTO", weight=0.1, stack = false, weaponID = 34, AmmoID = 284, level=0, itemTypes= 'weapon'}, --285
	{name = "MP5 EVENTO", desc="EVENTO", weight=0.1, stack = false, weaponID = 29, AmmoID = 284, level=0, itemTypes= 'weapon'}, --286
	{name = "Desert Eagle Halloween", desc="Halloweeni Adesivo de arma..", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --287
	{name = "Mascara de gas", desc="Mascara para camuflar", weight=1.5, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'weapon'}, --288
	{name = "Palhaço", desc="Mascara para camuflar", weight=4, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'weapon'}, --289
	{name = "Macaco", desc="Mascara para camuflar", weight=3.5, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'weapon'}, --290
	{name = "Cavalo", desc="Mascara para camuflar", weight=2.5, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'weapon'}, --291
	{name = "Caveira", desc="Mascara para camuflar", weight=4.1, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'weapon'}, --292
	{name = "Coruja", desc="Mascara para camuflar", weight=3.5, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'weapon'}, --293
	{name = "Boina policial", desc="Mascara para camuflar", weight=1.8, stack = false, weaponID = false, AmmoID = false, level=0, itemTypes= 'weapon'}, --294
	{name = "Boi chifre", desc="Mascara para camuflar", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --295
	{name = "Cloro", desc="Usado para limpar piscona", weight=2, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --296
	{name = "madeira", desc="Kpedaço de madeira cortada", weight=0.1, stack = true, weaponID = false, AmmoID = false, level=0, itemTypes= 'bag'}, --297
	{name = "M4 - Halloween", desc="Halloweeni Adesivo de arma..", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --298
	{name = "AK-47 - Halloween", desc="Halloweeni Adesivo de arma..", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --299
	{name = "Sniper - Halloween", desc="Halloweeni Adesivo de arma..", weight=2.2, stack = false, weaponID = 34, AmmoID = 57, level=3, itemTypes= 'weapon'}, --300
	{name = "Halloween", desc="Mascara para camuflar", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --301
	{name = "Gorro Natal", desc="Gorro Natal", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --302
	
	{name = "M4 - Natal", desc="EDIÇÃO NATAL 2019", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --303
	{name = "AK-47 - Natal", desc="EDIÇÃO NATAL 2019", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --304
	{name = "Sniper - Natal", desc="EDIÇÃO NATAL 2019", weight=2.2, stack = false, weaponID = 34, AmmoID = 57, level=3, itemTypes= 'weapon'}, --305
	{name = "Desert - Natal", desc="EDIÇÃO NATAL 2019", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --306


	{name = "M4A1 - PATRIOTA", desc="EDIÇÃO PATRIOTA", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --307
	{name = "AK-47 - PATRIOTA", desc="EDIÇÃO PATRIOTA", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --308
	{name = "AWM - PATRIOTA", desc="EDIÇÃO PATRIOTA", weight=2.2, stack = false, weaponID = 34, AmmoID = 57, level=3, itemTypes= 'weapon'}, --309


	{name = "DESERT - PATRIOTA", desc="EDIÇÃO PATRIOTA", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --310
	{name = "FACA - PATRIOTA", desc="EDIÇÃO PATRIOTA", weight=0.7, stack = false, weaponID = 4, AmmoID = false, level=2, itemTypes= 'weapon'}, --311
	{name = "TEC-9 - PATRIOTA", desc="EDIÇÃO PATRIOTA", weight=1.8, stack = false, weaponID = 32, AmmoID = 61, level=3, itemTypes= 'weapon'}, --312
	{name = "SHOUTGUN - PATRIOTA", desc="EDIÇÃO PATRIOTA", weight=4, stack = false, weaponID = 25, AmmoID = 60, level=3, itemTypes= 'weapon'}, --313
	{name = "MP5 - PATRIOTA", desc="EDIÇÃO PATRIOTA", weight=2.5, stack = false, weaponID = 29, AmmoID = 61, level=3, itemTypes= 'weapon'}, --314
	{name = "UZI - PATRIOTA", desc="EDIÇÃO PATRIOTA", weight=3.5, stack = false, weaponID = 28, AmmoID = 61, level=3, itemTypes= 'weapon'}, --315


	{name = "VISÃO NOTURNA - PATRIOTA", desc="EDIÇÃO PATRIOTA", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --316
	{name = "VISÃO INFRAVERMELHO - PATRIOTA", desc="EDIÇÃO PATRIOTA", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --317




	{name = "M4A1 - FOLIA", desc="Edição Carnaval", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --318
	{name = "AK-47 - FOLIA", desc="Edição Carnaval", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --319
	{name = "AWM - FOLIA", desc="Edição Carnaval", weight=2.2, stack = false, weaponID = 34, AmmoID = 57, level=3, itemTypes= 'weapon'}, --320
	{name = "DESERT - FOLIA", desc="Edição Carnaval", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --321
	{name = "AK-47 - FLAMENGO", desc="Muito barulhento!", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --322
	
	
	 
	{name = "M4A1 - DOURADA", desc="EDIÇÃO DOURADA", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --323
	{name = "AK-47 - DOURADA", desc="EDIÇÃO DOURADA", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --324
	{name = "AWM - DOURADA", desc="EDIÇÃO DOURADA", weight=2.2, stack = false, weaponID = 34, AmmoID = 57, level=3, itemTypes= 'weapon'}, --325
	{name = "DESERT - DOURADA", desc="EDIÇÃO DOURADA", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --326
	{name = "TEC-9 - DOURADA", desc="EDIÇÃO DOURADA", weight=1.8, stack = false, weaponID = 32, AmmoID = 61, level=3, itemTypes= 'weapon'}, --327
	{name = "SHOUTGUN - DOURADA", desc="EDIÇÃO DOURADA", weight=4, stack = false, weaponID = 25, AmmoID = 60, level=3, itemTypes= 'weapon'}, --328
	{name = "MP5 - DOURADA", desc="EDIÇÃO DOURADA", weight=2.5, stack = false, weaponID = 29, AmmoID = 61, level=3, itemTypes= 'weapon'}, --329
	{name = "UZI - DOURADA", desc="EDIÇÃO DOURADA", weight=3.5, stack = false, weaponID = 28, AmmoID = 61, level=3, itemTypes= 'weapon'}, --330

	{name = "Baseball - GROVE", desc="Uma ferramenta popular para esportes de beisebol.", weight=1, stack = false, weaponID = 5, AmmoID = false, level=2, itemTypes= 'weapon'}, --331
	{name = "Baseball - DRAGON", desc="Uma ferramenta popular para esportes de beisebol.", weight=1, stack = false, weaponID = 5, AmmoID = false, level=2, itemTypes= 'weapon'}, --332

	{name = "FACA - DOURADA", desc="EDIÇÃO DOURADA", weight=0.7, stack = false, weaponID = 4, AmmoID = false, level=2, itemTypes= 'weapon'}, --333

	{name = "M4A1 - SAKURA", desc="Homenagem ao CrossFire", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --334


	{name = "M4A1 - CAVEIRA", desc="NEM TENTE A SORTE!", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --335
	{name = "AK-47 - RED DRAGON", desc="Homenagem ao CrossFire", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --336
	{name = "AWM - ALPHA", desc="Edição ALPHA", weight=2.2, stack = false, weaponID = 34, AmmoID = 57, level=3, itemTypes= 'weapon'}, --337
	{name = "DESERT - RED DRAGON", desc="Homenagem ao CrossFire", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --338

	{name = "M4A1 - RED DRAGON", desc="Homenagem ao CrossFire", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --339
	{name = "AWM - RED DRAGON", desc="Homenagem ao CrossFire", weight=2.2, stack = false, weaponID = 34, AmmoID = 57, level=3, itemTypes= 'weapon'}, --340
	

	{name = "Coelhinho", desc="Mascara para camuflar", weight=5, stack = false, weaponID = false, AmmoID = false, level=3, itemTypes= 'weapon'}, --341

 	{name = "M4A1 - ASIIMOV", desc="ASIIMOV TOP", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --342
	{name = "DESERT - ASIIMOV", desc="ASIIMOV TOP", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --343






	{name = "M4A1 - VULCAN", desc="NEM TENTE A SORTE!", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --344
	{name = "AK-47 - VULCAN", desc="NEM TENTE A SORTE", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --345
	{name = "AWM - VULCAN", desc="NEM TENTE A SORTE", weight=2.2, stack = false, weaponID = 34, AmmoID = 57, level=3, itemTypes= 'weapon'}, --346
	{name = "DESERT - VULCAN", desc="NEM TENTE A SORTE", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --347


	{name = "M4A1 - IMPERADOR", desc="NEM TENTE A SORTE!", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --348


	{name = "M4A1 - STICKBOMBS", desc="NEM TENTE A SORTE!", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --349
	{name = "AK-47 - STICKBOMBS", desc="NEM TENTE A SORTE", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --350
	{name = "AWM - STICKBOMBS", desc="NEM TENTE A SORTE", weight=2.2, stack = false, weaponID = 34, AmmoID = 57, level=3, itemTypes= 'weapon'}, --351
	{name = "DESERT - STICKBOMBS", desc="NEM TENTE A SORTE", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --352
	{name = "M4A1 - HELLFIRE", desc="Fogo Infernal", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --353
	{name = "AK-47 - BRASIL", desc="ESPECIAL 7 DE SETEMBRO", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --354
	
	

	{name = "M4A1 - ROSE", desc="Especial Hallowen", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --355
	{name = "AK-47 - ROSE", desc="Especial Hallowen", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --356
	
	{name = "M4A1 - TA NA DISNEY?", desc="Especial Natal 2020", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --357
	{name = "AK-47 - TA NA DISNEY?", desc="Especial Natal 2020", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --358
	
	{name = "Chifre de RENA!", desc="Chifre de corno, DIGO RENA!", weight=5, stack = false, weaponID = 34, AmmoID = 69, level=3, itemTypes= 'weapon'}, --359
	
	{name = "AK-47 - GALAXY", desc="Muito linda!", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --360
	{name = "M4A1 - GALAXY", desc="Muito linda!", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --361
	{name = "AWM - GALAXY", desc="Muito linda!", weight=2.2, stack = false, weaponID = 34, AmmoID = 57, level=3, itemTypes= 'weapon'}, --362
	{name = "DESERT - GALAXY", desc="Muito linda!", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --363
	{name = "FACA - GALAXY", desc="Muito linda!", weight=0.7, stack = false, weaponID = 4, AmmoID = false, level=2, itemTypes= 'weapon'}, --364
	
	{name = "AK-47 - RIO", desc="Edição de abertura do BGO RIO", weight=2.2, stack = false, weaponID = 30, AmmoID = 57, level=3, itemTypes= 'weapon'}, --365
	{name = "M4A1 - RIO", desc="Edição de abertura do BGO RIO", weight=2.2, stack = false, weaponID = 31, AmmoID = 57, level=3, itemTypes= 'weapon'}, --366
	{name = "AWM - RIO", desc="Edição de abertura do BGO RIO", weight=2.2, stack = false, weaponID = 34, AmmoID = 57, level=3, itemTypes= 'weapon'}, --367
	{name = "DESERT - RIO", desc="Edição de abertura do BGO RIO", weight=2.2, stack = false, weaponID = 24, AmmoID = 57, level=3, itemTypes= 'weapon'}, --368
	{name = "FACA - RIO", desc="Edição de abertura do BGO RIO", weight=0.7, stack = false, weaponID = 4, AmmoID = false, level=2, itemTypes= 'weapon'}, --369

}




craftLists = {



	[1] = {
		name = 'Radio Frequência',
		level = 0,
		giveCraftItem = 20,
		craftDimension = false,
		craftFaction = false,
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1100,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[6] = {263, 5},
		},
	},



	[2] = {
		name = 'Vara de Pesca',
		level = 0,
		giveCraftItem = 85,
		craftDimension = false,
		craftFaction = false,
		craftTool = 159,
		craftMaxWant = 4,
		craftProgress = 600,
		craftSlots  = {
			--[Slot] = {ItemID, Darabszám}
			[2] = {153, 1},
			[6] = {157, 1},
			[10] = {154, 1},
			[15] = {155, 1},
		},
	},
	[3] = {
		name = 'Vara de pesca( Com isca )',
		level = 0,
		giveCraftItem = 158,
		craftDimension = false,
		craftFaction = false,
		craftMaxWant = 2,
		craftTool = false,
		craftProgress = 300,
		craftSlots  = {
			--[Slot] = {ItemID, Darabszám}
			[2] = {85, 1},
			[6] = {156, 1},
		},
	},

	[4] = {
		name = 'AK-47',
		level = 3,
		giveCraftItem = 51,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 6,
		craftProgress = 1200,
		craftSlots  = {
			--[Slot] = {ItemID, Darabszám}
			[5] = {165, 1},
			[6] = {160, 1},
			[7] = {161, 1},
			[9] = {162, 1},
			[10] = {163, 1},
			[11] = {164, 1},
		},
	},

	[5] = {
		name = 'M16',
		level = 3,
		giveCraftItem = 52,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 7,
		craftProgress = 1200,
		craftSlots  = {
			--[Slot] = {ItemID, Darabszám}
			[5] = {172, 1},
			[6] = {166, 1},
			[7] = {167, 1},
			[8] = {168, 1},
			[9] = {169, 1},
			[10] = {170, 1},
			[11] = {171, 1},
		},
	},

	[6] = {
		name = 'Desert Eagle',
		level = 3,
		giveCraftItem = 44,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 4,
		craftProgress = 1000,
		craftSlots  = {
			--[Slot] = {ItemID, Darabszám}
			[2] = {173, 1},
			[6] = {174, 1},
			[7] = {175, 1},
			[10] = {176, 1},
		},
	},

	[7] = {
		name = 'M40A1 rifle',
		level = 3,
		giveCraftItem = 103,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftProgress = 1300,
		craftMaxWant = 6,
		craftSlots  = {
			--[Slot] = {ItemID, Darabszám}
			[5] = {186, 1},
			[6] = {181, 1},
			[7] = {183, 1},
			[2] = {182, 1},
			[10] = {184, 1},
			[11] = {185, 1},
		},
	},

	[8] = {
		name = 'MP5',
		level = 3,
		giveCraftItem = 50,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 6,
		craftProgress = 1200,
		craftSlots  = {
			--[Slot] = {ItemID, Darabszám}
			[5] = {191, 1},
			[6] = {187, 1},
			[7] = {188, 1},
			[9] = {189, 1},
			[10] = {190, 1},
			[11] = {192, 1},
		},
	},

	[9] = {
		name = 'Micro Uzi',
		level = 3,
		giveCraftItem = 49,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 6,
		craftProgress = 1200,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[5] = {198, 1},
			[6] = {193, 1},
			[7] = {195, 1},
			[8] = {194, 1},
			[10] = {196, 1},
			[11] = {197, 1},
		},
	},

	[10] = {
		name = 'Shotgun',
		level = 3,
		giveCraftItem = 128,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 5,
		craftProgress = 1100,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[5] = {203, 1},
			[6] = {199, 1},
			[7] = {200, 1},
			[9] = {202, 1},
			[10] = {201, 1},
		},
	},

	[11] = {
		name = 'Tec9',
		level = 3,
		giveCraftItem = 53,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 5,
		craftProgress = 1100,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[5] = {204, 1},
			[6] = {205, 1},
			[9] = {206, 1},
			[10] = {207, 1},
			[11] = {208, 1},
		},
	},

	[12] = {
		name = 'Magnum Sniper',
		level = 3,
		giveCraftItem = 68,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 6,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {210, 1},
			[5] = {214, 1},
			[6] = {209, 1},
			[7] = {211, 1},
			[10] = {212, 1},
			[11] = {213, 1},
		},
	},




	[13] = {
		name = 'Estrutura interna AK',
		level = 3,
		giveCraftItem = 160,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 5},

		},
	},





	[14] = {
		name = 'Tubo de AK',
		level = 3,
		giveCraftItem = 161,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},

		},
	},





	[15] = {
		name = 'Gara de AK',
		level = 3,
		giveCraftItem = 162,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},

		},
	},




	[16] = {
		name = 'Astúcia de AK',
		level = 3,
		giveCraftItem = 163,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},

		},
	},





	[17] = {
		name = 'Pente de AK',
		level = 3,
		giveCraftItem = 164,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},

		},
	},


	[18] = {
		name = 'Sup ombro de AK',
		level = 3,
		giveCraftItem = 165,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},

		},
	},





	[19] = {
		name = 'Estrutura interna M16',
		level = 3,
		giveCraftItem = 166,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 5},

		},
	},
	
	
	[20] = {
		name = 'Punho do tupo M16',
		level = 3,
		giveCraftItem = 167,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},

		},
	},
	
	[21] = {
		name = 'Tubo M16',
		level = 3,
		giveCraftItem = 168,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},

		},
	},
	
	
	[22] = {
		name = 'Guiador M16',
		level = 3,
		giveCraftItem = 169,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},

		},
	},
	
	
	
	
	
	[23] = {
		name = 'Astúcia M16',
		level = 3,
		giveCraftItem = 170,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},

		},
	},
	
	
	
	
	
	[24] = {
		name = 'Alcatrão M16',
		level = 3,
		giveCraftItem = 171,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},

		},
	},


	[25] = {
		name = 'Suporte Ombro M16',
		level = 3,
		giveCraftItem = 172,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},
		},
	},
	
	
	[26] = {
		name = 'Estrutura Deagle',
		level = 3,
		giveCraftItem = 173,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 4},
		},
	},	
	
	
	[27] = {
		name = 'Repositório Deagle',
		level = 3,
		giveCraftItem = 174,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},
		},
	},	
	
	
	
	[28] = {
		name = 'Manhoso Deagle',
		level = 3,
		giveCraftItem = 175,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},
		},
	},	
	
	
	[29] = {
		name = 'Repositório 2 Deagle',
		level = 3,
		giveCraftItem = 176,
		craftDimension = 2,
		craftFaction = {13},
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1300,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {264, 2},
		},
	},	
	
	

	

	[30] = {
		name = 'Barra de Ferro',
		level = 0,
		giveCraftItem = 264,
		craftDimension = false,
		craftFaction = false,
		craftTool = 159,
		craftMaxWant = 1,
		craftProgress = 1100,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[6] = {263, 1000},
		},
	},



	[31] = {
		name = 'Vazo com terra',
		level = 3,
		giveCraftItem = 141,
		craftDimension = false,
		craftFaction = false,
		craftTool = false,
		craftMaxWant = 2,
		craftProgress = 1100,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {140, 1},
			[6] = {146, 1},
		},
	},	
	
	[32] = {
		name = 'Vazo Maconha (M)',
		level = 3,
		giveCraftItem = 143,
		craftDimension = false,
		craftFaction = false,
		craftTool = false,
		craftMaxWant = 2,
		craftProgress = 1100,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {137, 1},
			[6] = {141, 1},
		},
	},	
	
	[33] = {
		name = 'Vazo cocaina (C)',
		level = 3,
		giveCraftItem = 142,
		craftDimension = false,
		craftFaction = false,
		craftTool = false,
		craftMaxWant = 2,
		craftProgress = 1100,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {139, 1},
			[6] = {141, 1},
		},
	},	
	
	[34] = {
		name = 'Maconha moída',
		level = 3,
		giveCraftItem = 149,
		craftDimension = false,
		craftFaction = {10, 11, 13, 9},
		craftTool = 138,
		craftMaxWant = 1,
		craftProgress = 1100,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {145, 1},
		},
	},	
	
	[35] = {
		name = 'Maconha',
		level = 3,
		giveCraftItem = 144,
		craftDimension = false,
		craftFaction = false,
		craftTool = false,
		craftMaxWant = 2,
		craftProgress = 1100,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[6] = {148, 1},
			[7] = {149, 5},
		},
	},	
	
	[36] = {
		name = 'Arbusto de coca moída',
		level = 3,
		giveCraftItem = 219,
		craftDimension = 818,
		craftFaction = {10, 11, 13, 9},
		craftTool = 220,
		craftMaxWant = 1,
		craftProgress = 1100,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[6] = {218, 1},
		},
	},	
	
	[37] = {
		name = 'Cocaína',
		level = 3,
		giveCraftItem = 14,
		craftDimension = false,
		craftFaction = false,
		craftTool = false,
		craftMaxWant = 2,
		craftProgress = 1100,
		craftSlots  = {
			-- [Slot] = {ItemID, Darabszám}
			[2] = {26, 1},
			[6] = {219, 3},
		},
	},	

}

--exports.bgo_items:giveItem(source, 120, math.random(11111111,99999999), 1, 0, true)


specialItems = {
	[116] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[117] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[118] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[119] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,

	[120] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,

	[121] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,

	[122] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[123] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[124] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[125] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[126] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[127] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[128] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[129] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[130] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[131] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[132] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[133] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[134] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[135] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[222] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[223] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[224] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[225] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[226] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[241] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[242] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[243] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[244] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[245] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[246] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[247] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[248] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[287] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,


	[349] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[350] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[351] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	[352] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,

	[353] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	
		[354] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	
		[355] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	
	[356] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,

	[357] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,	
	[358] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	
		[365] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	
		[366] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	
		[367] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	
		[368] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,
	
		[369] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFA700ID: ".. value
	end,

	[13] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700Faz um cigarro: ".. value .. ""
	end,
	[16] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700{número de telefone: ".. value .."}\n#FFFFFFNível requerido: #00AEFF"..getItemNeedLevel(item)..""
	end,
	[17] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")\n#FFFFFFNível requerido: #00AEFF"..getItemNeedLevel(item)..""
	end,
	[18] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")\n#FFFFFFNível requerido: #00AEFF"..getItemNeedLevel(item)..""
	end,
	[19] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")\n#FFFFFFNível requerido: #00AEFF"..getItemNeedLevel(item)..""
	end,
	[20] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")\n#FFFFFFNível requerido: #00AEFF"..getItemNeedLevel(item)..""
	end,
	[29] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		local values = fromJSON(value)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. values[2] ..")"
	end,
	[34] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[278] = function(item,value)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(".. value ..")"
	end,
	

	[57] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFFFFFNível requerido: #00AEFF"..getItemNeedLevel(item)
	end,
	[58] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFFFFFNível requerido: #00AEFF"..getItemNeedLevel(item)
	end,
	[59] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFFFFFNível requerido: #00AEFF"..getItemNeedLevel(item)
	end,
	[60] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFFFFFNível requerido: #00AEFF"..getItemNeedLevel(item)
	end,
	[61] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(peso: "..getItemWeight(item).."kg)\n#FFFFFFNível requerido: #00AEFF"..getItemNeedLevel(item)
	end,
	
	[298] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	[299] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	[300] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[229] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	
	[303] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	[304] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	[305] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	[306] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[307] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[308] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[309] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[310] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[311] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[312] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[313] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[314] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[315] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,

	[110] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		local values = fromJSON(value)
  		return "#7cc576" --"..name .. "#FFFFFF\n" .. desc,"#ffffffDia jogo: #00AEFF"..values[1] .. "\n#FFFFFFnúmeros: #FFA700" .. values[2] .. " | "..values[3] .. " | "..values[4] .. " | "..values[5] .. " | "..values[6]
	end,
	
	[348] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[318] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[319] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[320] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[321] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[322] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[323] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[324] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[325] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[326] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[327] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[328] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[329] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[330] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[331] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[332] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[333] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[334] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	
	[335] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[336] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[337] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[338] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[339] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[340] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	
	[360] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,	
	[361] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	[362] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	[363] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
	[364] = function(item,value,count)
		name = getItemName(item)
		desc = getItemDescription(item)
		return "#7cc576"..name .. "#FFFFFF\n" .. desc,"#FFA700(valor/ID: ".. value ..")"
	end,
}

	
	
vehicleWeight = {
	-- [VehID] = peso,
	[499] = 20,
	[414] = 40,
	[456] = 60,
	[524] = 80,
}

function getType(element)
	if(getElementType(element)=="player")then
		return 0
	elseif(getElementType(element)=="vehicle")then
		return 1
	elseif(getElementType(element)=="object") and (getElementModel(element) == 2332) then
		return 2
	end
end

function getOwnerID(element)
	if(getElementType(element)=="player")then
		return tonumber(getElementData(element, 'acc:id') or -1)
	elseif(getElementType(element)=="vehicle")then
		return tonumber(getElementData(element, 'veh:id') or -1)
	elseif(getElementType(element)=="object") and (getElementModel(element) == 2332) then
		return tonumber(getElementData(element, "safe->ID")  or -1)
	end
end

function getItemName(id)
	if itemLists[id] then
		return itemLists[id].name
	end
end

function getItemWeight(id)
	if itemLists[id] then
		return itemLists[id].weight
	end
end

function getItemDescription(id)
	if itemLists[id] then
		return itemLists[id].desc
	end
end

function getItemType(id)
	if itemLists[id] then
		return itemLists[id].itemTypes
	end
end

function getItemWeaponID(id)
	if itemLists[id] then
		return itemLists[id].weaponID
	end
end

function getItemNeedLevel(item)
	if tonumber(itemLists[item].level) > 0 then
		return tonumber(itemLists[item].level)
	else
		return 0
	end
end

function getItemToType(element, items)
	local itemType = "bag"
	if items then
		if tonumber(getType(element)) == 1 or tonumber(getType(element)) == 2 then
			itemType = tostring('bag')
		else
			itemType = tostring(itemLists[tonumber(items)].itemTypes)
		end
	end
	return itemType
end

function getItemTable()
	return itemLists
end

function getItemImg(item)
--outputDebugString(item, 0, 25, 181, 254)
	return fileExists(":bgo_items/files/items/"..item..".png") and ":bgo_items/files/items/"..item..".png" or ":bgo_items/files/items/0.png"
end

function getWeaponID(itemid)--ItemID-ről fegyo ID-re
	if itemLists[tonumber(itemid)].weapon then
		return itemLists[tonumber(itemid)].weapon
	else
		return 0
	end
end
function getWeaponAmmo(item)
	if itemLists[tonumber(item)].ammo then
		return itemLists[tonumber(item)].ammo
	else
		return 1
	end
end

function getItemsStackable(item)
	return itemLists[tonumber(item)].stack or false
end

function isReloadableWeapon(item)
	return itemLists[tonumber(item)].weapon
end

isStickerWeapon = {
	--[ItemID] = "neve a képnek" (bgo_fegyverPJ ben lévő mappában a kép!!!)
	[113] = "ak_1",
	[114] = "ak_2",
	[115] = "ak_3",
	[133] = "ak_4",
	[241] = "ak_5",
	[242] = "ak_6",
	[116] = "mp_1",
	[117] = "mp_2",
	[118] = "mp_3",
	[122] = "mp_4",
	[244] = "mp_5",
	[245] = "mp_6",
	[120] = "m4_1",
	[121] = "uzi_1",
	[123] = "uzi_2",
	[124] = "uzi_3",
	[119] = "desert_1",
	[125] = "desert_2",
	[243] = "desert_3",
	[126] = "m4_2",
	[248] = "m4_3",
	[283] = "m4_4",
	[285] = "m4_4",
	[286] = "m4_4",
	[127] = "sniper_1",
	[222] = "sniper_2",
	[223] = "sniper_3",
	[224] = "sniper_4",
	[225] = "sniper_5",
	[226] = "sniper_6",
	[129] = "shoutgun_1",
	[130] = "shoutgun_2",
	[131] = "tec9_1",
	[132] = "tec9_2",
	[134] = "knife_1",
	[135] = "knife_2",
	[265] = "knife_3",
	[266] = "knife_4",
	[267] = "knife_5",
	[246] = "colt_1",
	[247] = "colt_2",
	[287] = "halloween",
	[288] = "halloween",
	[289] = "halloween",
	[290] = "halloween",
	[291] = "halloween",
	[292] = "halloween",
	[293] = "halloween",
	[294] = "halloween",
	[295] = "halloween",


	[298] = "m4_halloween",
	[299] = "ak_halloween",
	[300] = "sniper_halloween",

	[303] = "m4_natalina",
	[304] = "ak_natalina",
	[305] = "sniper_natalina",
	[306] = "desert_natalina",
	
	[307] = "m4_brasil",
	[308] = "ak_brasil",
	[309] = "sniper_brasil",
	[310] = "desert_brasil",
	[311] = "knife_brasil",
	[312] = "tec9_brasil",
	[313] = "shotgun_brasil",
	[314] = "mp_brasil",
	[315] = "uzi_brasil",
	
	
	[318] = "m4_folia",
	[319] = "ak_folia",
	[320] = "sniper_folia",
	[321] = "desert_folia",
	--[322] = "ak_vulcan",
	[322] = "ak_flamengo",
	
	
	[323] = "m4_ouro",
	[324] = "ak_ouro",
	[325] = "sniper_ouro",
	[326] = "desert_ouro",
	[327] = "tec9_ouro",
	[328] = "shoutgun_ouro",
	[329] = "mp_ouro",
	[330] = "uzi_ouro",

	[331] = "bat_grove",
	[332] = "bat_dragon",
	
	[333] = "knife_ouro",
	[334] = "m4_sakura",
	

	[335] = "m4_alpha",
	[336] = "ak_alpha",
	[337] = "sniper_alpha",
	[338] = "desert_reddragon",
	
	[339] = "m4_reddragon",
	
	[340] = "sniper_reddragon",
	
	
	[342] = "m4_asiimov",
	[343] = "desert_asiimov",
	

	[344] = "m4_vulcan",
	[345] = "ak_vulcan",
	[346] = "awm_vulcan",
	[347] = "desert_vulcan",
	
	[348] = "m4_imperador",
	
	[349] = "m4_stickbombs",
	[350] = "ak_stickbombs",
	[351] = "awm_stickbombs",
	[352] = "desert_stickbombs",
	
	[353] = "m4_diablo",
	
	[354] = "ak_bgo",
	
	[355] = "m4_rose",
	[356] = "ak_rose",
	
	[357] = "m4_doce",
	[358] = "ak_doce",
	[360] = "ak_galaxy",
	[361] = "m4_galaxy",
	[362] = "awp_galaxy",
	[363] = "deagle_galaxy",
	[364] = "faca_galaxy",
	
	[365] = "ak_rio",
	[366] = "m4_rio",
	[367] = "awp_rio",
	[368] = "deagle_rio",
	[369] = "faca_rio",
	
	
	[46] = "pistol_cimento",
}

function getStickerWeapon(itemID)
	return isStickerWeapon[itemID]
end

local itemIDtoWeapon = {
	[44] = 24,
	[45] = 23,
	[46] = 22,
	[47] = 26,
	[48] = 27,
	[49] = 28,
	[50] = 29,
	[286] = 29,
	[51] = 30,
	[52] = 31,
	[53] = 32,
	[54] = 41,
	[55] = 42,
	[56] = 43,
	[68] = 34,
	[103] = 33,

	-- Skines fegyók

	[298] = 31,
	[299] = 30,
	[300] = 34,



	[287] = 24,
	[288] = 22,
	[289] = 25,
	[290] = 28,
	[291] = 29,
	[292] = 30,
	[293] = 31,
	[294] = 32,
	[295] = 34,
	[113] = 30,
	[114] = 30,
	[115] = 30,
	[241] = 30,
	[242] = 30,
	[116] = 29,
	[244] = 29,
	[245] = 29,
	[117] = 29,
	[118] = 29,
	[119] = 24,
	[243] = 24,
	[120] = 31,
	[121] = 28,
	[122] = 29,
	[123] = 28,
	[124] = 28,
	[125] = 24,
	[126] = 31,
	[248] = 31,
	[283] = 31,
	[127] = 34,
	[222] = 34,
	[223] = 34,
	[224] = 34,
	[225] = 34,
	[226] = 34,
	[285] = 34,
	[128] = 25,
	[129] = 25,
	[130] = 25,
	[131] = 32,
	[132] = 32,
	[133] = 30,
	[134] = 4,
	[135] = 4,
	[246] = 22,
	[247] = 22,
	[265] = 4,
	[266] = 4,
	[267] = 4,
	--[40] = 6,
	
	
	[298] = 31,
	[299] = 30,
	[300] = 34,
	
	
	[303] = 31,
	[304] = 30,
	[305] = 34,
	[306] = 24,
	
	
	[307] = 31,
	[308] = 30,
	[309] = 34,
	[310] = 24,
	[311] = 4,
	[312] = 32,
	[313] = 25,
	[314] = 29,
	[315] = 28,
	
	
	[318] = 31,
	[319] = 30,
	[320] = 34,
	[321] = 24,
	[322] = 30,
	
	
	
	[323] = 31,
	[324] = 30,
	[325] = 34,
	[326] = 24,
	[327] = 32,
	[328] = 25,
	[329] = 29,
	[330] = 28,
	
	[331] = 5,
	[332] = 5,
	
	[333] = 4,
	[334] = 31,
	
	
	[335] = 31,
	[336] = 30,
	[337] = 34,
	[338] = 24,
	
	
	[339] = 31,
	[340] = 34,
	
	[342] = 31,
	[343] = 24,
	
	
	
	
	[344] = 31,
	[345] = 30,
	[346] = 34,
	[347] = 24,
	
	[348] = 31,
	
	
	[349] = 31,
	[350] = 30,
	[351] = 34,
	[352] = 24,
	
	[353] = 31,
	
	[354] = 30,
	
	[355] = 31,
	[356] = 30,
	
	[357] = 31,
	[358] = 30,
	[360] = 30,
	
	[361] = 31,
	[362] = 34,
	[363] = 24,
	[364] = 4,
	
	[365] = 30,
	[366] = 31,
	[367] = 34,
	[368] = 24,
	[369] = 4,
}



	
	
	
function getWeaponID(itemid)
	if itemIDtoWeapon[itemid] then
		return itemIDtoWeapon[itemid]
	else
		return 0
	end
end

function isWeapon(itemid)
	if itemIDtoWeapon[itemid] then
		return true
	else
		return false
	end
end
