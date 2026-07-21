# Contribuindo com o Project Oxxy (OXXYZ)

Esse projeto vive de comandos ADB **testados de verdade** no aparelho, não de coisas copiadas de fórum sem confirmar. Se você testou algo e funcionou, é bem-vindo contribuir.

## Como contribuir com um comando novo

Abra uma **Issue** ou **Discussion** com o título `[Comando] <nome curto>` e preencha:

- **Comando exato** (linha completa, com `settings put`, `cmd`, etc.)
- **Categoria**: RAM / CPU / Rede / Idle-Doze / Vulkan / GPU / Processos / Outro
- **Aparelho testado**: fabricante + modelo + versão do Android
- **Requer root?**: sim / não
- **Resultado observado**: o que mudou de fato (ex: "ping caiu de 80ms pra 40ms em jogo X", "bateria parada durou mais 2h")
- **Fonte** (se tiver): link de documentação oficial, fórum, ou "testei sozinho"

## Regras básicas

1. **Não envie comando que você não testou.** Se leu em algum lugar mas não confirmou no seu aparelho, deixe isso claro na Issue — ainda é útil, mas não vai direto pro script sem alguém validar.
2. **Separe claramente o que é Google/AOSP oficial do que é fabricante-específico** (ex: flags só-Samsung). O script já detecta o fabricante automaticamente — mantenha esse padrão.
3. **Comandos que exigem root** devem ser marcados como tal, para caírem no bloco condicional certo do script.
4. **Nada de comandos destrutivos ou irreversíveis** sem aviso explícito (ex: algo que exija reset de fábrica pra desfazer).

## Enviando um Pull Request

Se quiser editar o `prjct-oxxy.sh` diretamente:

1. Fork do repositório
2. Adicione o comando na etapa correta (ou crie uma nova etapa, se não se encaixar nas atuais)
3. Atualize o `README.md` se a mudança adicionar uma etapa nova
4. Abra o PR descrevendo o que foi testado e onde

## Dúvidas

Se não tiver certeza de onde encaixar algo, abra uma Discussion e a gente decide junto.