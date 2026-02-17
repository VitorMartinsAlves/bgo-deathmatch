# BGO Rio Server - README Operacional

Este documento centraliza o que voce precisa saber para manter o servidor funcionando com estabilidade.

## 1) Visao geral

- Plataforma: MTA:SA (mod `deathmatch`)
- Porta de jogo: `22003`
- Porta HTTP interna: `22006`
- Banco principal: MySQL (`bgo`)
- Recurso de conexao MySQL: `resources/bgo_mysql/server.lua`
- Config principal do servidor: `mtaserver.conf`
- Controle de permissao global: `acl.xml`

Configuracao atual importante (arquivo `mtaserver.conf`):
- `serverip=auto`
- `serverport=22003`
- `httpport=22006`
- `maxplayers=2021`
- `disableac=47`
- `auth_serial_http=0`
- `auth_serial_groups` vazio

## 2) Estrutura de pastas

- `resources/`: recursos Lua/XML do servidor
- `resource-cache/`: cache HTTP/unzipped do servidor
- `logs/`: logs principais (`server.log`, `scripts.log`, `server_auth.log`)
- `backups/`: backups locais
- `databases/`: bases internas locais do MTA

Arquivos centrais:
- `mtaserver.conf`: rede, anti-cheat, versao minima, etc
- `acl.xml`: grupos ACL (`Admin`, `Console`, etc)
- `bgoriodb.sql`: dump/base de referencia
- `resources/bgo_mysql/server.lua`: host/user/password/database do MySQL
- `resources/bgo_accounts/Szerver.lua`: login/registro/criacao de personagem

## 3) Dependencias e pre-requisitos

- Windows com permissao para abrir portas `22003/udp` e `22006/tcp`
- MySQL/MariaDB ativo
- Banco `bgo` importado (ou equivalente compativel)
- Usuario MySQL com permissoes no schema `bgo`
- Executar `MTA Server.exe` preferencialmente como Administrador

## 4) Banco de dados

Conexao atual no recurso MySQL (`resources/bgo_mysql/server.lua`):
- host: `localhost`
- user: `bgo_mta`
- database: `bgo`

### Tabelas criticas

- `accounts`: autenticacao, serial, nivel admin (`admin`)
- `characters`: dados do personagem

### Erro conhecido ja corrigido

Problema:
- `dbExec failed; (1364) Field 'data' doesn't have a default value`

Causa:
- `INSERT` de personagem nao preenchia o campo `characters.data`.

Correcao aplicada:
- Em `resources/bgo_accounts/Szerver.lua`, o `INSERT INTO characters` agora inclui `data = NOW()`.

## 5) Fluxo de login e personagem (alto nivel)

1. Jogador conecta
2. Faz login em `accounts`
3. Sistema seta `acc:id`, `acc:admin` e estado de sessao
4. Criacao de personagem grava em `characters`
5. Sistema chama validacao/carregamento do personagem

Ponto de codigo:
- `resources/bgo_accounts/Szerver.lua`

## 6) Como iniciar/parar

### Iniciar

1. Suba o MySQL
2. Abra `MTA Server.exe`
3. Confirme no `logs/server.log`:
   - `Banco de dados conectado RIO!`
   - `Server started and is ready to accept connections!`

### Parar

- No console do servidor: `shutdown`
- Ou `Ctrl+C`

## 7) Admin: como funciona neste projeto

Este servidor usa dois niveis de permissao:

1. ACL do MTA (`acl.xml`)
2. Nivel de admin na tabela `accounts.admin`

Para ter admin completo, configure os dois:

### 7.1 Banco

```sql
UPDATE accounts
SET admin = 10
WHERE username = 'SEU_USUARIO';
```

### 7.2 ACL

No console do MTA:

```txt
aclGroupAddObject Admin user.SEU_USUARIO
aclGroupAddObject Console user.SEU_USUARIO
reloadacl
```

Depois relogue no servidor.

## 8) Logs e diagnostico

Arquivos:
- `logs/server.log`: eventos de startup, connect/quit, warnings/errors
- `logs/scripts.log`: mensagens de script (debug e prints)
- `logs/server_auth.log`: autenticacao/login ACL

Comandos uteis (PowerShell):

```powershell
Get-Content logs/server.log -Tail 200
Get-Content logs/scripts.log -Tail 200
Select-String -Path logs/server.log -Pattern "ERROR|WARNING|dbExec failed"
```

## 9) Troubleshooting rapido

### 9.1 CD47 / TURN OFF VPN

- Nao necessariamente vem de script proprio
- Checar `mtaserver.conf` (`disableac`, `auth_serial_http`, `auth_serial_groups`)
- Confirmar cliente e servidor em builds compativeis

### 9.2 CD48 / HTTP file mismatch

Sintoma comum:
- arquivo baixado com tamanho `55` bytes e MD5 incorreto

Causa comum:
- HTTP interno retornando `404` para arquivo de recurso

Caso real corrigido:
- Recurso `dances` tinha arquivos `.ifp` com espacos no nome
- Ajustado para:
  - `Fortnite_pt1.ifp`
  - `Fortnite_pt2.ifp`
  - `Fortnite_pt3.ifp`
- Referencias atualizadas em `resources/dances/meta.xml` e `resources/dances/client.lua`
- Cache HTTP do recurso limpo (`resource-cache/http-client-files/dances`)

### 9.3 Erro de criacao de personagem ao salvar

- Conferir se reapareceu:
  - `Field 'data' doesn't have a default value`
- Se sim, validar o `INSERT` em `resources/bgo_accounts/Szerver.lua` com `data = NOW()`

## 10) Checklist de manutencao

Diario:
- Verificar `server.log` por `ERROR` e `dbExec failed`
- Confirmar status do MySQL

Semanal:
- Backup de banco (`mysqldump`) e arquivos criticos (`mtaserver.conf`, `acl.xml`, recursos alterados)
- Revisar recursos com warning frequente

Antes de alterar recurso grande:
- Fazer backup
- Alterar
- Reiniciar recurso/servidor
- Validar logs e conexao de teste

## 11) Seguranca minima recomendada

- Rotacionar senha de banco regularmente
- Nao deixar senha real em locais publicos
- Limitar quem entra em `Console` ACL
- Manter backup fora da maquina principal

## 12) Comandos uteis de operacao

No console do MTA:

```txt
help
refresh
start <resource>
restart <resource>
stop <resource>
reloadacl
```

No PowerShell (pasta do servidor):

```powershell
Get-Process | Where-Object { $_.ProcessName -like '*MTA*' }
netstat -ano | findstr :22003
netstat -ano | findstr :22006
```

---

## Estado atual (resumo)

- Servidor sobe e conecta no banco
- Correcao de criacao de personagem aplicada (`data = NOW()`)
- Correcao de mismatch HTTP no recurso `dances` aplicada
- ACL com grupos `Admin` e `Console` ativos

Se surgir erro novo, sempre registre:
- horario exato
- acao feita (ex: "cliquei salvar personagem")
- ultimas 100-200 linhas de `logs/server.log`
