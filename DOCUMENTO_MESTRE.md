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
