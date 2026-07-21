![Project Oxxy banner](https://capsule-render.vercel.app/api?type=waving&color=0:0f2027,100:2c5364&height=200&section=header&text=Project%20Oxxy&fontSize=60&fontColor=ffffff&desc=OXXYZ%20-%20Android%20Optimization%20Script&descAlignY=75)
## Project oxxy (OXXYZ)

> Projeto em construção e aberto a expansão. Ainda não tem uma definição fechada — a ideia central é ir incorporando, aos poucos, comandos ADB testados e confirmados que realmente funcionam, com ou sem root, pra otimizar o Android.

Script de otimização para Android via ADB/Shell (aShell + Shizuku), sem precisar de root — com passos extras habilitados automaticamente se o aparelho tiver root.

## O que ele faz

Roda 8 etapas em sequência, com barra de progresso:

1. **RAM** — libera processos em segundo plano (e cache do sistema, se root)
2. **Idle/Doze** — força o dispositivo a entrar em modo de economia em 1 minuto e "congela" o app alvo (App Standby restrito)
3. **CPU** — define governor de performance (somente com root)
4. **Rede** — otimiza Wi-Fi/dados (power save, scan throttling, low latency mode)
5. **Processos** — ativa o freezer de processos em segundo plano
6. **Vulkan (ANGLE)** — força o uso de Vulkan via ANGLE no app alvo e no systemui
7. **GPU** — seleciona o System Graphics Driver, com flags extras exclusivas pra Samsung (detectadas automaticamente)
8. **Game Mode** — ativa o modo Performance oficial do Android para o app alvo

## Requisitos

- Android com **Shizuku** ativo
- App **aShell** (ou outro shell compatível com Shizuku/ADB)
- Root: opcional — sem root, as etapas de RAM/CPU que dependem dele são puladas automaticamente
- Samsung: opcional — flags extras da Samsung só são aplicadas se o script detectar o fabricante

## Como usar

1. Baixe o `prjct-oxxy.sh` para o seu celular
2. Edite a variável `PKG` no início do arquivo, colocando o pacote do app/jogo que você quer otimizar
3. Abra o aShell e rode: sh /sdcard/download/prjct-oxxy.sh (caso o .sh esteja na pasta download)


[

![License](https://img.shields.io/github/license/medinanathanschirmer-lang/oxxy-project)
](https://github.com/medinanathanschirmer-lang/oxxy-project/blob/main/LICENSE)
[

![Stars](https://img.shields.io/github/stars/medinanathanschirmer-lang/oxxy-project)
](https://github.com/medinanathanschirmer-lang/oxxy-project/stargazers)
[

![Last Commit](https://img.shields.io/github/last-commit/medinanathanschirmer-lang/oxxy-project)
](https://github.com/medinanathanschirmer-lang/oxxy-project/commits/main)
[

![Issues](https://img.shields.io/github/issues/medinanathanschirmer-lang/oxxy-project)
](https://github.com/medinanathanschirmer-lang/oxxy-project/issues)