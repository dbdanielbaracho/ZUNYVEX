# Homologação Roblox — roteiro de aceitação v3.38
26/11/2026. Universo 10778594708; Place 112566849572143. Executar em cópia local do RBXLX, sem publicar, sem habilitar DataStore ou acesso a serviços de produção.
## Preparação
- Baixar artefato do CI aprovado para o commit sob teste; registrar SHA, run, versão Studio e dispositivo.
- Abrir cópia local no Studio; usar Test > Server & Clients com dois clientes; repetir com três.
- Registrar Output do servidor e clientes, capturas e resultado PASS/FAIL/BLOCKED por caso. Não marcar PASS sem execução.
## Casos obrigatórios
| ID | Ação | Resultado esperado |
|---|---|---|
| H01 | Entrar com A e B | HUD e mundo carregam sem erros; pontuação independente |
| H02 | A coloca peça, B tenta removê-la sem permissão | Servidor rejeita; peça permanece |
| H03 | A concede acesso a B, B remove peça de A | Remoção autorizada; contagem de A atualizada |
| H04 | A revoga acesso; B tenta remover outra peça | Rejeição; peça permanece |
| H05 | B sai e retorna | Permissões antigas não sobrevivem à saída |
| H06 | A e B coletam a mesma relíquia | Progresso independente |
| H07 | A coleta repetidamente a mesma relíquia | Sem duplicação de progresso ou prêmio |
| H08 | A encontra cinco relíquias em ordem livre | 40 estrelas uma única vez na sessão |
| H09 | Percorrer fisicamente todas as relíquias | Todas acessíveis sem ferramentas administrativas |
| H10 | Corrida: repetir largada e morrer durante tentativa | Sem reinício indevido; estado limpo ao morrer |
| H11 | Desafio das Nuvens: tentar checkpoint sem portal | Sem recompensa indevida |
| H12 | Trilha das Cores: ordem errada e prazo excedido | Sem prêmio; nova tentativa possível |
| H13 | Dois jogadores completam Trilha das Cores | Ranking ordenado pelo tempo do servidor |
| H14 | Emulador de telefone: construir, compartilhar, revogar | Controles acessíveis sem sobreposição ou corte |
| H15 | Jogar com latência simulada | Sem duplicação de recompensa ou autorização obsoleta |
| H16 | Sair/reentrar repetidamente | Sem erros ou crescimento indevido de objetos por jogador |
## Critério de saída
Todos os casos obrigatórios aprovados, sem erros novos no Output e sem regressão do CI. Emulador não substitui teste em aparelho físico. Registrar falhas com passos de reprodução e corrigir antes de homologar. Publicação privada ou pública é etapa separada, sujeita a autorização e acesso.
## Registro
Estado inicial: 0/16 executados. Nenhum resultado de jogabilidade alegado.
