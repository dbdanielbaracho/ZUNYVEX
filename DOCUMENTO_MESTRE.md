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
