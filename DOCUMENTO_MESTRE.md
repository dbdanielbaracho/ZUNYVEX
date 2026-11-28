# ZUNYVEX — Documento Mestre v3.5 (incremento)
23/11/2026. Preserva a cadeia histórica v3.4 e anteriores, incluída no pacote. Universo 10778594708; Place 112566849572143; experiência privada. Prioridade: Criar, Explorar, Jogar, Competir e Compartilhar, sem simulador de trabalho.

## Entrega v2.3 — ciclo de corrida
- Impede reiniciar uma corrida ativa por contato repetido com a largada; permite nova tentativa após conclusão ou expiração.
- Limpa estado ao expirar e ao remover o personagem, evitando continuar uma corrida após renascimento.
- Amplia especificação Luau com casos de reinício e isolamento entre jogadores. Especificação não executada.
- Nove scripts Python de verificação estrutural executados com sucesso (13 mensagens PASS/checks). Evidência: tests/validation_v2_3.txt.
- Commit local de código: 025292d4adaa71501f270ea96862340fe3fdee2c. Histórico Git local reconstruído a partir do ZIP v2.2; não é histórico remoto. Bundle incluído separadamente.
- Busca GitHub por ZUNYVEX na conta dbdanielbaracho retornou lista vazia. Não há ação de criação de repositório na integração GitHub disponível. Luau e Rojo não encontrados no PATH; sem build ou teste Roblox comprovado.
- DataStore permanece desativado. Próximos passos: validação real de corrida multiplayer, exploração e aventuras em paralelo. Não publicar sem acesso autorizado.

## Atualização de governança — 23/11/2026
Repositório dbdanielbaracho/ZUNYVEX criado pelo titular e visível na integração. Este arquivo será o ponto de entrada oficial do Documento Mestre; importar a cadeia histórica integral e o código existente antes de declarar a migração concluída. Atualizar após avanços verificáveis, preservando histórico e evidências.

## v3.6 — migração parcial (23/11/2026)
Repositório remoto confirmado. Importados default.project.json (60bfeafa), GameConfig.luau (4e1ea160), CheckpointRace.luau (e8e8c010) e CheckpointRace.spec.luau (24c43345). Pacote v2.3 recuperado e nove scripts Python reexecutados com 13 verificações estruturais aprovadas. Migração de scripts de produção: 2 de 11; demais scripts, documentação histórica e CI ainda pendentes. Não há build Roblox nem execução Luau comprovados. Não publicar a árvore parcial. Próximo passo: importar os nove scripts restantes e testes, configurar CI sem publicação automática, verificar build e só então avançar exploração e aventuras.

## v3.7 — migração de persistência (23/11/2026)
Migrados os módulos BuildPersistence (6ad5c668) e BuildStore (44067b2c), preservando a lógica do pacote v2.3. DataStore continua inativo. Quatro dos onze scripts de produção registrados remotamente segundo inventário da migração. Não houve compilação nem execução de testes nesta rodada. Próximo passo: importar sete scripts restantes, histórico e CI sem publicação automática.

## v3.8 — migração do circuito (23/11/2026)
Importado RaceCourse.server.luau do pacote v2.3, commit 38dc20caaa01f883eca44791f3bb8208ba15276f. Leitura remota confirmou quatro verificações textuais: Place ID, cinco checkpoints, pontes e preservação de circuito existente. Cinco dos onze scripts de produção migrados segundo inventário acumulado. Não equivale a compilação ou teste de jogabilidade. Próximo passo: migrar seis scripts restantes e histórico, configurar CI sem publicação. DataStore e publicação continuam desativados.

## v3.9 — interface da corrida (23/11/2026)
Importado RaceFeedback.client.luau do pacote v2.3, commit 3e63f97e31e60555e69e9ca53b3ea8a339f8c4c6. Leitura remota confirmou igualdade integral com o conteúdo enviado. Interface apresenta largada, progresso, chegada, tempo esgotado e animação de vitória com 12 estrelas. Seis dos onze scripts de produção migrados segundo inventário acumulado; cinco caminhos restantes retornaram 404 antes da migração. Controlador servidor ainda pendente, portanto interface não operacional isoladamente. Sem compilação, build ou teste de jogabilidade nesta rodada. Próximo passo: importar controlador e scripts de construção/HUD, histórico e CI sem publicação. DataStore permanece desativado.

## v3.10 — controlador servidor (24/11/2026)
Integrado RaceCheckpointController.server.luau, commit 973b0b975a288b2640287774d3a9095612ab6de5. Base v2.3 adaptada: valida classe do RemoteEvent, mantém progresso no servidor, debounce por jogador/portal, limite de velocidade plausível e limpeza de referências a portais removidos e de último portal ao finalizar. Leitura remota confirmou igualdade integral com o conteúdo enviado. Inventário acumulado: 7/11 scripts de produção; faltam HUD, Building cliente, Building servidor e Zunyvex servidor. Sem compilação ou teste real nesta rodada; não publicar. Próximo passo: concluir importação, histórico e CI sem publicação automática. DataStore permanece desativado.

## v3.11 — HUD principal (24/11/2026)
Importado HUD.client.luau do pacote v2.3, commit 62ef26153ae835db5a2f01dd668dd139a514f4b3. Leitura remota confirmou igualdade integral com conteúdo enviado. HUD apresenta estrelas, cristais, dicas e notificações temporárias. Inventário acumulado: 8/11 scripts de produção; faltam Building cliente, Building servidor e Zunyvex servidor. Dependência dos eventos Notice e StatsUpdate no servidor ainda não validada em execução. Sem compilação, build ou teste real nesta rodada. Próximo passo: concluir importação, histórico e CI sem publicação automática. DataStore permanece desativado.

## v3.12 — CI de build (24/11/2026)
Criado workflow .github/workflows/validate.yml no commit 124e6901c9f8e5346a809493cb28d1b2df449b61, com Rojo 7.4.4 via Cargo, geração de RBXLX, verificação de arquivo não vazio e armazenamento de artefato. Sem publicação automática, permissões somente leitura. Leitura remota do workflow confirmada. Execução do CI e compilação Luau ainda não comprovadas; build Rojo não equivale a teste Luau ou jogabilidade. Inventário histórico 8/11 scripts; recuperação dos três restantes pendente. DataStore permanece desativado. Próximo passo: verificar resultado do CI, corrigir falhas e recuperar ou reconstruir módulos faltantes com testes.

## v3.13 — proteção de integridade do build (24/11/2026)
Consulta de workflow do commit 124e6901 retornou lista vazia (integração filtra eventos de PR); consulta de status combinado de 54df7d94 também vazia. Não comprova ausência de execução push nem sucesso. Confirmados 404 nos três entrypoints de produção faltantes: Building cliente, Building servidor e Zunyvex servidor. Workflow atualizado para rejeitar arquivos ausentes ou vazios antes de gerar artefato, commit d7803a1b55d643e4db3eac07aefa90f3ffc0d983. Leitura remota comparada integralmente: igual. Inventário histórico permanece 8/11. Sem execução CI ou jogabilidade comprovada. Próximo passo: recuperar/reconstruir entrypoints e verificar contratos dos módulos existentes; manter publicação e DataStore desativados.

## v3.14 — reconstrução do servidor de construção (24/11/2026)
Confirmado 404 do entrypoint Building.server.luau; reconstruído a partir dos contratos GameConfig e BuildPersistence, commit 5f1059f1a919f30a3edb47a5f14be5b1b4b45dcf. Leitura remota confirmou igualdade integral. Contrato: ZunyvexRemotes/BuildRequest(action, Vector3, color), BuildResult(action, count, max). Servidor valida grade, limites, distância, frequência, ocupação, limite por jogador e propriedade para remoção; peças compartilhadas na sessão, removidas ao sair. Sem DataStore. Inventário 9/11 (8 importados, 1 reconstruído). Faltam cliente de construção e servidor central; validar interação com geometria e dispositivos móveis, testar entradas inválidas, isolamento multiplayer e compilação. Não houve execução Luau ou build comprovado; não publicar.

## v3.15 — reconstrução do cliente de construção (24/11/2026)
Confirmado 404 antes da criação de Building.client.luau. Reconstruído cliente com painel opcional, quatro cores, ações explícitas Colocar/Remover via Activated (toque e mouse), atalhos E/Q, mira pelo centro da câmera, raycast excluindo personagem, encaixe na grade, filtro de propriedade local e contador atualizado por BuildResult. Contrato BuildRequest preservado; servidor continua autoritativo. Commit c4023d86a88782e83a13baf11d7648c916b82c18; leitura remota igual ao conteúdo enviado. Inventário 10/11 (8 importados, 2 reconstruídos). Falta Zunyvex.server.luau. Testar mira, encaixe em superfícies, layout móvel, respostas de rejeição e isolamento multiplayer; sem compilação ou teste real comprovado. DataStore e publicação continuam desativados. Próximo passo: reconstruir servidor central e validar CI.

## v3.16 — reconstrução do servidor central (24/11/2026)
Criado Zunyvex.server.luau, commit 10ffce3b5cbb2c37b46c7ec4b120e0c41d6a2500; leitura remota igual ao código enviado. Inventário histórico 11/11 (8 importados, 3 reconstruídos). Implementados eventos Notice/StatsUpdate, pontuação de sessão, 18 cristais com respawn, portal e sete checkpoints sequenciais, geometria inicial e retorno ao início. Sem DataStore ou publicação. Preserva mundo nomeado existente; integração com mundo autoral, geometria, segurança de recompensas, compilação e jogabilidade ainda exigem validação. Próximo passo: executar CI, testes Luau e revisar integração multiplayer; não publicar sem validação.

## v3.17 — validação por pull request (24/11/2026)
Aberto PR #1 (validation/ci-v316), commit 11d6dca66c6f7c6e0ddcd30de8a01172db231bc0: exige ativação do portal para recompensas do Desafio das Nuvens e limpa estado ao morrer ou concluir. Leitura remota idêntica; alteração ainda não integrada à main. PR permite consultar CI por evento pull_request, contornando limitação de observabilidade dos eventos push. Compilação, build e jogabilidade ainda não comprovados. Próximo passo: consultar jobs do PR, corrigir falhas e integrar após validação. DataStore e publicação desativados.

## v3.18 — primeiro build Rojo confirmado (24/11/2026)
CI do PR #1, execução 45405338126, job 138484384017: sucesso em todas as etapas, incluindo integridade dos entrypoints, instalação Rojo, build RBXLX e upload. Artefato ZUNYVEX-private-build ID 14924799444, ZIP 9422 bytes, digest sha256:d795711526002c11f5652eea1e902ebbf32ea82e63519d3424d5ceb250a20676. PR integrado à main, merge d8b2546b3bdd886b41fd13c46efba48da80409e0. Build de empacotamento comprovado; não equivale a compilação Luau nem execução Roblox. Próximo passo: adicionar verificação sintática Luau e testes executáveis, depois validar multiplayer. DataStore e publicação permanecem desativados.

## v3.19 — gate de compilação Luau (24/11/2026)
Workflow atualizado em branch validation/luau-compile-v319, commit 5eff5b8f88927ab017126d71cc664b43951b22f2. Compilador oficial Luau tag 0.656 construído via CMake no CI; etapa compila arquivos .luau de src e tests antes do Rojo e falha se houver erro. Execução ainda pendente de comprovação; não equivale a testes funcionais. DataStore e publicação permanecem desativados. Próximo passo: validar CI, corrigir erros e executar testes funcionais de módulos puros.

## v3.20 — correção de compatibilidade do compilador (24/11/2026)
CI do PR #2, execução 45439297516, job 138605618657: entrypoints aprovados; configuração CMake falhou antes de compilar Luau, devido à remoção de compatibilidade com versões anteriores a 3.5 no runner Ubuntu 26.04. Corrigido workflow no commit e5adf1060d2c1e5c78d508ed94d00f4f434302d1: runner ubuntu-24.04, CMAKE_POLICY_VERSION_MINIMUM=3.5 e verificação do SHA da fonte Luau 0.656 (c759cd5581f570980cf05186b0db58e65371c9fb). Gate de compilação preservado; novo CI pendente. Não houve teste de jogabilidade nem publicação. Próximo passo: validar novo CI, corrigir falhas remanescentes e executar testes de módulos puros. DataStore e publicação desativados.

## v3.21 — compilação aprovada e integrada (24/11/2026)
CI do PR #2, execução 45450614484, confirmado como completed/success para o head 5eba0fd5bc7884d8306882d483226d703b7a7de5. PR #2 integrado à main com merge 1bba4d1c077a7d71fd3dbfa0189f133ef24d9da4. Gate Luau preservado. Próxima prioridade: executar testes de módulos puros no CI, além da compilação, e validar jogabilidade e multiplayer em ambiente Roblox autorizado. Não houve publicação nem ativação do DataStore.

## v3.22 — gate funcional da corrida (24/11/2026)
Em branch validation/race-functional-v322, especificação CheckpointRace adaptada ao CLI Luau e ampliada com isolamento, tempo inválido, jogador inexistente, entrada inválida e limite temporal exato (0777a8c6c02bbd501a52711f6537aa5535a018cd). Workflow constrói também Luau.Repl.CLI e exige execução das assertions antes do Rojo (ce61adcb8081f7f2df4375bb050f9db5cf58fc2e). Alterações registradas, execução ainda pendente; não equivale a teste multiplayer Roblox. DataStore e publicação permanecem desativados. Próximo passo: verificar CI, corrigir falhas e ampliar testes de construção.

## v3.23 — testes funcionais da corrida aprovados (24/11/2026)
CI do PR #3, head e7351f59ceb93ce0abe9a1a1802616e56b5fba63, execução 45493001833, job 138795990621: compilação Luau e execução CLI de tests/CheckpointRace.spec.luau aprovadas (log: CheckpointRace spec passed). Rojo 7.4.4 gerou RBXLX e upload do artefato 14968091174 (9422 bytes) confirmado. PR #3 integrado à main: 3d0fac0a0452df648522b0fdac4786455d1e24c6. Testes de módulo puro não comprovam jogabilidade nem multiplayer real. Próximo passo: testes de construção livre e validação de integração Roblox. Sem publicação ou ativação de DataStore nesta rodada.

## v3.24 — testes do codec de construção (24/11/2026)
Adicionada especificação CLI do módulo de produção BuildPersistence (1c82a86d870d3ca4992a796eb9557f6bb28aae2c), cobrindo round-trip, grade, limites, cores, duplicatas, NaN/infinito, capacidade 80/81 e payloads inválidos. Gate obrigatório no CI (5f221264e58c3a86c4d397c1de5c2c1872197351). Execução pendente; não comprova propriedade, colisões ou multiplayer Roblox. Próximo passo: validar CI e extrair regras de propriedade/ocupação para testes funcionais do servidor. DataStore e publicação desativados.


## v3.25 — validação do codec integrada (24/11/2026)
PR #4 integrado à main, merge ae2e9b6d8eafe9abc5224aa2a19e4cf5c866797d. CI 45519528604, job 138887570642, confirmou sucesso nas etapas de compilação Luau, testes da corrida, testes do codec de construção, build Rojo e upload. Próxima entrega: extrair regras de propriedade e ocupação do servidor de construção e testar isolamento, remoção e limites. Sem homologação Roblox, publicação ou ativação de DataStore nesta rodada. Estimativa comercial anterior de 30% permanece não auditada.

## v3.26 — propriedade e ocupação (25/11/2026)
Branch validation/build-ownership-v326: módulo BuildLedger (ef7ee913), testes de isolamento, capacidade, remoção e limpeza (af66fc49), integração ao servidor de produção (abeaf4a6). Gate funcional acrescentado ao CI. Commits remotos confirmados; execução CI e integração à main pendentes. Colisões físicas e multiplayer real ainda exigem homologação Roblox. Sem publicação ou ativação do DataStore. Próximo passo: verificar CI, corrigir falhas e integrar; avançar exploração e minijogos.

## v3.27 — propriedade e ocupação validadas (25/11/2026)
CI do PR #5, head fae2f0223d210024618e6f1d4ab69abaac61a031, execução 45578355179: 14 etapas aprovadas, incluindo compilação Luau, testes de corrida, codec e propriedade de construção, build Rojo e upload. PR #5 integrado à main, merge 41b442466e1f4dc420698630f4f391a443343cde. Testes de módulo puro não comprovam colisões físicas ou multiplayer real. Próxima frente: exploração e aventuras, com testes funcionais independentes. Sem publicação ou ativação do DataStore nesta rodada. Estimativa comercial de 30% permanece não auditada.

## v3.28 — regras do Desafio das Nuvens (25/11/2026)
Branch feature/cloud-challenge-v328: módulo CloudChallenge (7bf7ad0c), integrado ao servidor (fbd635da), testes CLI de sequência, repetição, conclusão, reset e isolamento (49e8a15c). Gate CI acrescentado. Commits confirmados; execução CI e integração à main pendentes. Não constitui nova aventura nem homologação Roblox. Próximo passo: validar CI e ampliar conteúdo explorável. Sem publicação ou DataStore.

## v3.29 — Desafio das Nuvens validado (25/11/2026)
PR #6 integrado à main, merge 9e791a26b31b989b6fd26da2e6cf40491e2e1176. CI 45615025103, job 139208081109: 15 etapas com sucesso, inclusive compilação, quatro suítes funcionais, build Rojo e upload. Bloqueio de integração resolvido. A homologação no motor Roblox permanece pendente; testes CLI não substituem testes cliente-servidor. Próxima entrega: conteúdo explorável novo e preparação de testes Studio. Não houve publicação ou alteração de DataStore. Estimativa comercial anterior de 30% não auditada.

## v3.30 — Ilha do Pôr do Sol (25/11/2026)
Branch feature/discovery-island-v330: nova ilha, ponte e monumento com 25 estrelas (2be5f51). Módulo DiscoveryLedger (4086ed93) e testes CLI (44d6d202) isolam descobertas por UserId e impedem recompensa repetida mesmo após reconexão ao mesmo servidor. Estado em memória, sem DataStore. CI ampliado; execução e integração pendentes. Geometria e jogabilidade real ainda não homologadas. Sem publicação.

## v3.31 — Ilha do Pôr do Sol integrada (25/11/2026)
PR #7 integrado à main, merge d12d3396bb41d30fc1e9d50101c91bcf0a15acc7. CI 45667361706, job 139393024246: 16 etapas aprovadas, incluindo compilação Luau, cinco suítes funcionais, build Rojo e upload. Recompensas e isolamento por usuário validados em CLI; geometria, acessibilidade física e multiplayer real ainda não homologados. Sem publicação ou DataStore. Próxima entrega: ampliar minijogos e preparar homologação Studio. Estimativa comercial anterior de 30% não auditada.

## v3.32 — Trilha das Cores (25/11/2026)
Branch feature/color-trail-v332: novo minijogo de quatro portais numerados, 30 segundos, recompensa de 15 estrelas, isolamento de tentativas e limpeza ao morrer/sair. Módulo 203fe31b, integração 3d76155e, testes CLI 6fb32ba2. CI ampliado; execução e integração pendentes. Não comprova física ou multiplayer real. Sem publicação ou DataStore.

## v3.33 — Trilha das Cores integrada (25/11/2026)
PR #8 integrado à main, merge c50e069500cdc165a4f34757c839f9ebeafe3756. CI 45687584675, job 139464157133: 17 etapas aprovadas, incluindo compilação Luau, seis suítes funcionais, build Rojo e upload. Sequência, prazo, isolamento e conclusão única por tentativa validados em CLI. Homologação física e multiplayer real pendentes. Próxima frente: competição por melhores tempos e preparação de testes Studio. Sem publicação ou ativação de DataStore. Estimativa comercial anterior de 30% não auditada.

## v3.34 — competição por melhores tempos (25/11/2026)
Branch feature/color-ranking-v334: ranking de sessão da Trilha das Cores, top 5 em painel físico, recorde pessoal calculado no servidor, desempate determinístico por UserId e precisão de milissegundos. Módulo 50f224cf e testes 751ada58; integração e gate CI registrados. Compilação, testes e integração à main ainda pendentes. Não é ranking global persistente; sem DataStore ou publicação. Próximo passo: validar CI e homologar painel e competição em Roblox.

## v3.35 — ranking competitivo integrado (25/11/2026)
PR #9 integrado à main, merge a1263b795fe8973c92d44e0b34d6a522cc1195b2. CI 45705311505, job 139525650674: 18 etapas aprovadas, incluindo compilação Luau, sete suítes funcionais, build Rojo e upload. Ranking de sessão validado em CLI; painel físico, integridade da movimentação e competição multiplayer ainda exigem homologação no motor Roblox. Sem publicação ou ativação de DataStore. Próxima frente: compartilhamento seguro de criações e preparação de testes Studio. Estimativa comercial anterior de 30% não auditada.

## v3.36 — compartilhamento seguro integrado (26/11/2026)
PR #10 integrado à main, merge 47edd05efe17a469af15161a1be202b13a0722b6. Head validado 11b9864f79b5020bd4c27f291bf106466ad62b68; CI 45777189405: 18 etapas aprovadas, incluindo compilação Luau, sete suítes funcionais (incluindo autorização, revogação, propriedade e limpeza de colaboração), build Rojo, verificação e upload do artefato. Quatro arquivos alterados, 116 adições e 6 remoções. Proprietário concede/revoga permissão de remoção de peças na sessão; servidor mantém propriedade e contagem originais. Interface de seleção de jogadores integrada. Não implica construção conjunta sob propriedade compartilhada nem persistência. Homologação real cliente-servidor, interface móvel, latência e física pendentes. Sem publicação ou ativação de DataStore. Próxima frente: roteiro de homologação multiplayer e ampliação de aventuras/minijogos. Estimativa comercial anterior de 30% permanece não auditada.

## v3.37 — Expedição das Relíquias integrada (26/11/2026)
PR #11 integrado à main, merge 309326bf8bf388b7a35e737210a5f6edf6342f43. Head validado e20db08c1be0ed907d53fa179893bd005509a970; CI 45803106637, job 139851167457: 19 etapas aprovadas, incluindo compilação Luau, oito suítes funcionais, build Rojo, verificação e upload. Cinco relíquias em ordem livre, progresso individual por UserId na sessão e recompensa única de 40 estrelas; testes CLI de IDs inválidos, duplicidade, isolamento e conclusão. Quatro arquivos, 56 adições. Física, acessibilidade das relíquias e multiplayer real ainda não homologados. Sem publicação ou DataStore. Próximo passo: roteiro de homologação e novos minijogos; revisar limites de estado por sessão e segurança de contato no motor. Estimativa comercial histórica de 30% não auditada.

## v3.38 — matriz de homologação Roblox (26/11/2026)
Criado docs/HOMOLOGACAO_ROBLOX.md, commit 3f3f701326bd2bbc9ceed81a8f1d9c5ab5bd8ed1, leitura remota idêntica. Define 16 casos de aceitação multiplayer, segurança, física, recompensas, latência e interface móvel, com evidências e critérios de saída. 0/16 executados; entrega documental, sem alteração Luau, build novo ou publicação. DataStore permanece desativado. Próximo passo: automatizar verificações de integração viáveis e ampliar conteúdo jogável; executar matriz em Studio autorizado quando disponível. Estimativa comercial de 30% permanece não auditada.


## v3.39 — proteção de contato (26/11/2026; proposta em branch)
ContactGuard (4e8a448e), nove assertions (26771be7), integração em sete pontos de contato do servidor (3699e20b), gate CI (0d9f2afc). Rejeita distâncias inválidas e contatos fora de raio conservador observado pelo servidor. Não impede teleporte fraudulento por si só; tolerância e física exigem homologação. Compilação, testes, build e merge ainda pendentes. Sem publicação ou DataStore. Próximo passo: validar CI e testar contatos reais.

## v3.40 — proteção de contato integrada (26/11/2026)
PR #12 integrado à main, merge f6137e0937a257e1fe25902e83b8551e8e2cc46f. Head validado 301bc319d3629c99f21f5199ec7d38772f0b04b0; CI 45831771589, job 139950089097: 20 etapas aprovadas, incluindo compilação Luau, nove suítes funcionais, build Rojo e upload. Artefato 15122344211 (13216 bytes). Sete pontos de contato protegidos, nove assertions de ContactGuard aprovadas. Não comprova física ou proteção contra teleporte no motor. Matriz de homologação real permanece pendente; sem publicação ou DataStore. Próximo passo: ampliar conteúdo jogável e revisar limites de estado por sessão. Estimativa comercial histórica de 30% não auditada.

## v3.41 — Desafio da Memória (26/11/2026; proposta em branch)
Novo minijogo de sequência aleatória de quatro números, três segundos de memorização, 25 segundos de resposta e 20 estrelas por conclusão. Módulo 3f5db72d, testes 0883d864, integração 5a9ac82f e gate CI b619a816. Estado por jogador, limpeza ao morrer/sair e proteção ContactGuard. Compilação, testes, build e merge pendentes; validar legibilidade do aviso, contatos repetidos e jogabilidade real. Sem publicação ou DataStore. Estimativa comercial histórica de 30% não auditada.


## v3.42 — Desafio da Memória integrado (26/11/2026)
PR #13 integrado à main, merge f6463caf7212b399680cf9aabc868e1e1f9cc082. Head validado 7ead972b93ec7da34c429effc0794d7edca6c65e; CI 45851597915, job 140019087691: 21 etapas aprovadas, incluindo compilação Luau, dez suítes funcionais, build Rojo e upload. Artefato 15133623075 (13947 bytes). Homologação física, multiplayer e mobile pendentes; revisar contatos repetidos e legibilidade do aviso no motor. Sem publicação ou DataStore. Próximo passo: ampliar construção livre e revisar limites de estado por sessão. Estimativa comercial histórica de 30% não auditada.


## v3.43 — pintura de blocos (26/11/2026; proposta em branch)
Interface e servidor de pintura registrados anteriormente (2eeeaf5b, 7d13a13f). Política exclusiva do proprietário extraída para BuildLedger (7ad2ba11), usada no servidor (53ce44cb) e coberta por assertions de autorização, colaboração, capacidade e troca de proprietário (46a13bfe). Testes escritos, execução CI e merge pendentes; validação de cores continua no codec. Sem homologação Roblox, publicação ou DataStore. Próximo passo: validar CI e integrar após sucesso.


## v3.44 — pintura de blocos integrada (26/11/2026)
PR #14 integrado à main, merge 1c2184af63906d92532e33d90dc573a6d619bbe3. Head validado 17ee9e1934bcece6e3d2b6dac5b83f3c7ae3055c; CI 45898956091, job 140179737174: 21 etapas aprovadas, incluindo compilação Luau, dez suítes funcionais (regressões de autorização de pintura na suíte BuildLedger), build Rojo e upload. Artefato 15155415265 (14020 bytes). Homologação física, multiplayer e mobile pendentes; testes CLI não comprovam interação real. Sem publicação ou ativação do DataStore. Próxima frente: ampliar construção livre e minijogos cooperativos, revisar limites de estado por sessão. Estimativa comercial histórica de 30% não auditada.


## v3.45 — conta-gotas de construção (26/11/2026; proposta em branch)
Botão Copiar cor permite selecionar a cor de um bloco existente pela mira, sem modificar o bloco ou enviar pedido ao servidor. Interface por Activated para mouse e toque. Commit 4d0d233be0fc28b4d23320041ee036e48d50dbd7. Compilação, CI, merge e homologação real pendentes. Sem publicação ou DataStore. Estimativa comercial histórica de 30% não auditada.


## v3.46 — conta-gotas integrado (26/11/2026)
PR #15 integrado à main, merge 1f8c1d88602fc22df2beec4a877679adc775e2b8. Head validado b38672de1cf1b4ec6ae767e546b8ba2b91348b6f; CI 45912027281, job 140222406098: 21 etapas aprovadas, incluindo compilação Luau, dez suítes funcionais de regressão, build Rojo e upload. Artefato 15160916894 (14175 bytes). Não há teste funcional específico do conta-gotas nem homologação real de mouse/toque; adicionar cobertura e validar layout. Sem publicação ou ativação de DataStore nesta rodada. Próxima frente: testes de paleta compartilhada e novos minijogos cooperativos. Estimativa comercial histórica de 30% não auditada.

## v3.47 — paleta compartilhada e testes (27/11/2026; proposta em branch)
Módulo BuildPalette centraliza cores e reconhecimento do conta-gotas; cliente e servidor integrados. Testes CLI de quatro cores, tolerância, imutabilidade e entradas inválidas (6a17c2a7); gate obrigatório no CI (1d6850f2). Execução dos testes, build, merge e homologação real pendentes. Sem publicação ou DataStore. Estimativa comercial histórica de 30% não auditada. Próximo passo: validar CI e integrar após sucesso.

## v3.48 — paleta compartilhada integrada (27/11/2026)
PR #16 integrado à main no merge 7eecdfe6d372b6acd64c9a6a4faa145163671a2a. Head validado 2fc071554a7406e3d457dba0896726db107aa1f0; CI 45946439229, job 140332102522: 22 etapas aprovadas, incluindo compilação Luau, 11 suítes funcionais CLI (incluindo BuildPalette), build Rojo e upload. Artefato 15174009623 (14335 bytes). Homologação real de mouse/toque, multiplayer e mobile permanece pendente; testes CLI não substituem execução no motor Roblox. Sem publicação ou ativação de DataStore nesta rodada. Próxima frente: minijogos cooperativos e aventuras, preservando construção livre. Estimativa comercial histórica de 30% não auditada.

## v3.49 — integração dos Portais cooperativos (27/11/2026)
Módulo CoopPortals e testes CLI registrados na branch feature/coop-portals-v349. Integração ao cenário gerado, duas plataformas distintas, janela de oito segundos, avisos e efeitos de cor, recompensa de 20 estrelas por participante, cooldown de 30 segundos e limpeza ao morrer/sair: commit 52dbafc4ce46e883f38d347f5e3950d698b122ab, leitura remota idêntica. Arena compartilhada por servidor; não há grupos privados. CI e homologação Roblox pendentes. Sem publicação ou DataStore. Próximo passo: validar PR, corrigir falhas e integrar após aprovação.

## v3.50 — Portais cooperativos validados e integrados (27/11/2026)
PR #17 integrado à main no merge 3bcd5c8e306d0b1e3112e67780c1bf055f690438. Head validado 997600b5664a40cc697d50d5f3cd6fed84a4c05c; CI 45999645207, job 140507711723: 23 etapas aprovadas, incluindo compilação Luau, 12 suítes CLI (CoopPortals incluída), build Rojo e upload. Artefato 15198010909 (15205 bytes), digest sha256:be6ec91c8056c51ca241814281a456b238ccbaa414eb6cfc8b505fc11b618a0e. Homologação real pendente: dois jogadores, toque mobile, recompensa e cooldown no motor Roblox. Sem publicação ou DataStore. Próxima frente: melhorar feedback cooperativo e expandir aventuras. Estimativa comercial histórica de 30% permanece não auditada.


## v3.51 — feedback cooperativo (27/11/2026; proposta em branch)
Commit 8fc8054657a01b823b0c19c3de4a32e041f14710, leitura remota idêntica. Placas dos portais mostram pedido de ajuda, contagem regressiva e vitória; token de geração cancela atualizações antigas. CI, merge e homologação visual/multiplayer pendentes. Sem publicação ou DataStore. Próximo passo: validar CI e ampliar aventuras. Estimativa comercial histórica de 30% não auditada.


## v3.52 — feedback cooperativo integrado (27/11/2026)
PR #18 integrado à main no merge 59e2f0094b6bd00ab278daec42f65a9c3f0aedf1. Head validado 5cff7b17175b5e8d489b6abd1c8c53620daeffa7; CI 46018026559, job 140570087541: 23 etapas aprovadas, incluindo compilação Luau, 12 suítes CLI de regressão, build Rojo e upload. Artefato 15206756860 (15409 bytes), digest sha256:958f950d4cb3acc54e8926b1fc0d2733a392208a8357134ac2c6d87338753cea. Não há teste específico de renderização ou temporização das placas no motor; homologação visual, multiplayer e mobile pendente. Sem publicação ou ativação do DataStore nesta rodada. Próxima frente: expandir aventuras e cobertura de testes do feedback. Estimativa comercial histórica de 30% não auditada.


## v3.53 — Ilha da Lua (27/11/2026; proposta em branch)
Nova região acessível por ponte, cinco rochas decorativas e cristal de descoberta com recompensa de 25 estrelas, usando DiscoveryLedger e proteção de contato existente (ca9e09d2605293421770e8eb14950b0710267072). Seis assertions adicionais cobrem descoberta lunar, duplicidade, isolamento entre jogadores e sessão nova (5a9e01361bf68e3d0c40a17d5b606f129fd9c354); leitura remota conferida. CI, build, merge e homologação física pendentes. Sem publicação ou DataStore. Estimativa comercial histórica de 30% não auditada.


## v3.54 — Ilha da Lua integrada (27/11/2026)
PR #19 integrado à main no merge eb94c58f7cebecc2f619e711500c30ee7e077ae8. Head validado 5bd936024a6ccc0995ca017193794f2d2e818324; CI 46043550819, job 140657041985: 23 etapas aprovadas, incluindo compilação Luau, 12 suítes CLI (seis novas assertions de descoberta), build Rojo e upload. Artefato 15220818451 (15664 bytes), digest sha256:2398f17f6a38a529a36a54484ccd2e3ea3cfbaa2eee002633128d29717e56d20. Homologação física da ponte, contatos, recompensas e multiplayer permanece pendente. Sem publicação ou DataStore. Próxima frente: ampliar aventuras e cobertura de integração. Estimativa comercial histórica de 30% não auditada.


## v3.55 — Observatório Lunar (27/11/2026; proposta em branch)
Aventura opcional com cinco plataformas ascendentes e estrela de descoberta de 30 estrelas, controlada pelo servidor (2f982eb16cc10e6e498ad8213842969553103953). Oito assertions adicionais em DiscoveryLedger cobrem independência da descoberta lunar, duplicidade, isolamento e sessão nova (cfcea16b86e0249c0dc98420f821bf7439308c7a; leitura remota idêntica). CI, build, merge e homologação física pendentes. Sem publicação ou DataStore nesta rodada. Estimativa comercial histórica de 30% não auditada. Próximo passo: validar CI e testar saltos e recompensas no motor Roblox.

## v3.56 — Observatório Lunar integrado (27/11/2026)
PR #20 integrado à main no merge f451d32b409f304b4fd7aadf50963cd7c092eaa8. Head validado 54538c33b9f63061a178ef40c91120d39e136525; CI 46078177655, job 140770726669: 23 etapas aprovadas, incluindo compilação Luau, 12 suítes CLI (DiscoveryLedger ampliado), build Rojo e upload. Artefato 15235583694 (15908 bytes), digest sha256:1dbe512f198082167e15d12abc6cabee702c2abf02b856d5dccd7222496ad37a. Homologação física dos saltos, recompensa e multiplayer pendente; sem publicação ou ativação de DataStore nesta execução. Próxima frente: ampliar construção livre e cobertura de integração, em paralelo à homologação. Estimativa comercial histórica de 30% não auditada.


## v3.57 — retorno opcional do Observatório Lunar (27/11/2026; proposta em branch)
Adicionado ProximityPrompt para retorno voluntário à Ilha da Lua, com interação por teclado/toque, validação de personagem vivo e distância no servidor (890f7ce803e0e20fbe6508e12a4409e688025e44; leitura remota idêntica). Sem recompensa adicional. Validar compilação e regressão no CI; homologar acionamento mobile, rejeição remota e destino livre no motor Roblox. Sem publicação ou DataStore. Estimativa comercial histórica de 30% não auditada.

## v3.58 — retorno lunar integrado (27/11/2026)
PR #21 integrado à main no merge dd439e3da5f5ac7cf050145cb118562a7857d6fd. Head validado 998be08403d3ea4781a092c3febdb9329fc76565; CI 46088471991, job 140803521491: 23 etapas aprovadas, incluindo compilação Luau, 12 suítes CLI de regressão, build Rojo e upload. Artefato 15240317294 (16158 bytes), digest sha256:b6dbb8f8ad1e09c07e0213f94ce5ec058dd0baf08d66f7070275350ad5470c73. Não há teste específico do ProximityPrompt no motor; homologar toque, teclado, distância e destino. Sem publicação ou ativação de DataStore nesta execução. Próxima frente: construção livre e testes de integração. Estimativa comercial histórica de 30% não auditada.


## v3.59 — mira de construção (28/11/2026; proposta em branch)
Mira central visível somente no modo Criar, alinhada ao raio de seleção da câmera, com contraste e sem capturar interação. Commit bc0fbf3568ce46cedbf04ae802de9388799b48c4, leitura remota idêntica. Validar compilação e regressão no CI; homologar alinhamento, áreas seguras e layout em celular e desktop no motor Roblox. Sem publicação ou DataStore. Estimativa comercial histórica de 30% não auditada.

## v3.60 — mira de construção integrada (28/11/2026)
PR #22 integrado à main no merge 6fadaf33dbe402cae3a91600d84bb63168286a20. Head validado e3a760e2f3ee363bbfed80d5c0e6cd4e0a193805; CI 46104024266, job 140852619310: 23 etapas aprovadas, incluindo compilação Luau, 12 suítes CLI de regressão, build Rojo e upload. Artefato 15246648473 (16375 bytes), digest sha256:ab653f50725eb70b15af2be83bb518c1d3644e1c875720711a4ed7897ebd7cb8. Sem teste visual específico da mira no motor; homologar alinhamento, áreas seguras e controles mobile/desktop. Sem publicação ou ativação de DataStore nesta execução. Próxima frente: separar a mira da interface de controles para preservar áreas seguras, se necessário, e ampliar ferramentas criativas. Estimativa comercial histórica de 30% não auditada.

## v3.61 — áreas seguras da construção (28/11/2026; proposta em branch)
Separados os ScreenGui da mira e dos controles: painel usa CoreUISafeInsets; mira usa viewport integral sem recorte de área segura, mantendo o raio central existente. Commit ebae1d4c0e0777bd6707078a15c65668205da183; leitura remota idêntica. CI, merge e homologação visual pendentes. Validar orientação retrato/paisagem, recortes de tela, barra superior, alinhamento da mira e toque; sem publicação ou DataStore. Estimativa comercial histórica de 30% não auditada.


## v3.62 — áreas seguras integradas (28/11/2026)
PR #23 integrado à main no merge 58cb3209f9e614ad7a455c4188be4ecb385a0d57. Head validado 89612790d53ed7d4ca3e67a875b19d0b258839a5; CI 46117673272, job 140895026772: 23 etapas aprovadas, incluindo compilação Luau, 12 suítes CLI de regressão, build Rojo e upload. Artefato 15252263795 (16445 bytes), digest sha256:a632aa43e33272eb481ccc632e3e790c1dd683373970714c4cd8291eee09314d. Sem teste visual específico no motor; homologar retrato/paisagem, recortes, alinhamento e toque. Sem publicação ou DataStore nesta execução. Próxima frente: ampliar ferramentas criativas e minijogos, em paralelo à homologação. Estimativa comercial histórica de 30% não auditada.
