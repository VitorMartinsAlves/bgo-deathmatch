# Comandos ADM - BGO Rio

Guia rapido com os comandos que voce mais vai usar no dia a dia.

## 1) Painel e acesso

- Painel admin MTA: tecla `P`
- Painel VIP jogador: tecla `F10`
- Painel VIP admin: `/vipadmin` (somente ACL `Console`)
- Listar todos comandos carregados: `/commands` (requer `acc:admin >= 8` ou `Console`)

## 2) Comandos essenciais (staff)

- Entrar/sair modo admin: `/adminduty`
- Kick custom: `/chutar [id/nome] [motivo]`
- Jail online: `/prender [id/nome] [minutos] [motivo]`
- Jail offline: `/prenderoff [nome_completo] [minutos] [motivo]`
- Soltar da jail admin: `/liberar [id/nome]`
- Setar nivel admin: `/setadminlevel [id/nome] [0-10]`
- Alterar admin nick: `/setadminnick [id/nome] [novo nick]`

## 3) Economia (admin alto)

Formato de status:
- `1 = setar`
- `2 = acumular`
- `3 = retirar`

Comandos:
- Dinheiro mao: `/money [id/nome] [1|2|3] [valor]`
- Banco: `/banco [id/nome] [1|2|3] [valor]`
- Premium points: `/setpp [id/nome] [1|2|3] [valor]`

## 4) Teleporte e utilitarios

- Ir ate player: `/goto [id/nome]`
- Puxar player: `/gethere [id/nome]`
- Ir ate carro: `/gotocar [id/nome]`
- Puxar carro: `/getcar [id/nome]`
- Consertar veiculo: `/fixveh [id/nome]`
- Vanish: `/v` ou `/vanish`
- Fly: `/fly`
- Ver ID: `/id`
- Ver stats: `/stats [id/nome]`

## 5) Banimento (admin padrao MTA)

No admin padrao (`P`) e tambem por comando:
- `/ban [id/nome] [motivo] [tempo]`
- `/kick [id/nome] [motivo]`
- `/banip [ip]`
- `/banserial [serial]`
- `/unbanip [ip]`
- `/unbanserial [serial]`

## 6) Grupos, policia e faccao

Comandos de gerenciamento de grupo/faccao (admin):
- Listar grupos: `/vgrupos`
- Criar grupo: `/criargrupo [tipo] [nome]`
- Setar lider: `/setlider [id/nome] [grupoID]`
- Colocar no grupo: `/setpgrupo [id/nome] [grupoID]`
- Remover do grupo: `/removerpgrupo [id/nome] [grupoID]`

Depois que o player entra no grupo:
- Entrar/sair de servico: `/trabalhar`

IDs de faccao mapeados no codigo (exemplos):
- `11` Policia Federal
- `20` Policia Militar
- `21` Policia Civil
- `4` Samu
- `12` Taxi
- `8` CV
- `10` PCC

## 7) VIP

Painel:
- `/vipadmin` para abrir painel de codigos VIP (ACL `Console`)

ACL direta (alternativa):
- Adicionar VIP: `aclGroupAddObject VIP user.NOME_DA_CONTA`
- Remover VIP: `aclGroupRemoveObject VIP user.NOME_DA_CONTA`
- Recarregar ACL: `reloadacl`

## 8) Sintaxe rapida (copiar e usar)

- `/chutar 23 anti-rp`
- `/prender 23 60 RDM`
- `/liberar 23`
- `/setadminlevel 23 6`
- `/setpgrupo 23 11`
- `/setlider 23 11`
- `/money 23 1 50000`
- `/banco 23 2 100000`
- `/setpp 23 2 500`

## 9) Observacoes importantes

- Muitos comandos exigem `adminduty` ativo.
- Hierarquia de admin e respeitada: admin menor nao altera admin maior.
- Para auditoria e seguranca, prefira usar comandos com motivo.

## 10) Permissao minima por comando

Baseado no codigo atual do servidor (pode mudar se o script for alterado).

Comandos staff (bgo_admin):
- `acc:admin >= 1`: `/chutar`, `/prender`, `/liberar`, `/goto`, `/fly`
- `acc:admin >= 2`: `/gethere`, `/sethp`
- `acc:admin >= 3`: `/prenderoff`, `/fixveh`
- `acc:admin >= 7`: `/setadminnick`, `/setadminlevel`
- `acc:admin >= 8`: `/setpp`, `/commands`
- `acc:admin >= 10`: `/money`, `/banco`

Comandos de grupo/faccao (bgo_dashboard):
- `acc:admin >= 6`: `/criargrupo`, `/setlider`, `/setpgrupo`, `/removerpgrupo`

VIP:
- `/vipadmin`: somente quem estiver na ACL `Console`

Observacoes sobre permissao:
- Em varios comandos, se voce nao for `>= 7`, precisa estar com `adminduty` ligado.
- Para mudar admin level alto, existe hierarquia (admin menor nao sobe/rebaixa admin maior).
- O comando `/adminduty` tem protecao extra por serial/lista interna (nao e apenas nivel).
