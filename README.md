# Template para Desenvolvimento de Microsserviços com Python, Docker e VS Code

Este template foi criado para servir como base para o desenvolvimento de microsserviços em Python, utilizando Docker para containerização e VS Code como ambiente de desenvolvimento. Ele inclui uma estrutura de diretórios organizada, arquivos de configuração essenciais e documentação detalhada para ajudar você a começar rapidamente.

## Índice da Documentação

1. **[Instalação do Docker no Windows](./01-instalação-docker.md)**: Guia passo a passo para instalar e configurar o Docker no Windows usando WSL2.
2. **[Preparando o Docker para Python](./02-preparando-docker-para-python.md)**: Configuração do ambiente Docker para desenvolvimento em Python, incluindo a criação de um `Dockerfile` e `docker-compose.yml`.
3. **[Exemplos de requirements.txt](./03-exemplos-de-requirements.txt.md)**: Exemplos de como configurar o arquivo `requirements.txt` para gerenciar dependências do projeto.
4. **[Usando o VS Code com Docker](./04-usando-o-vscode.md)**: Configuração do VS Code para desenvolvimento em Python dentro de um container Docker.
5. **[Comandos Docker e Docker Compose](./05-comandos-docker-e-docker-compose.md)**: Lista de comandos úteis para gerenciar containers, imagens e volumes com Docker e Docker Compose.

## Estrutura de Diretórios

A estrutura de diretórios do template foi projetada para ser flexível e adaptável às necessidades do seu projeto. Aqui está uma visão geral:

```
nome-do-projeto/
├── .devcontainer/
│   └── devcontainer.json
├── app/
│   ├── src/
│   │   └── __init__.py
│   │   └── exemplo.py
│   ├── notebooks/
│   │   └── exemplo.ipynb
│   ├── tests/
│   │   └── test_exemplo.py
│   ├── doc/
│   │   └── 01-instalação-docker.md
│   │   └── 02-usando-docker-com-python.md
│   ├── mypy.ini
├── env/
│   └── requirements.txt
├── .gitignore
├── docker-compose.yml
├── Dockerfile
├── LICENSE
├── README.md
```

### Descrição dos Diretórios e Arquivos

- **`.devcontainer/`**: Contém o arquivo `devcontainer.json` para configurar o VS Code para desenvolvimento dentro de um container Docker.
- **`app/`**: Diretório principal do projeto, onde o código-fonte, notebooks, testes e documentação são armazenados.
  - **`src/`**: Código-fonte Python.
  - **`notebooks/`**: Jupyter Notebooks para análise de dados ou prototipagem.
  - **`tests/`**: Testes unitários e de integração.
  - **`doc/`**: Documentação do projeto.
- **`env/`**: Contém o arquivo `requirements.txt` para gerenciar dependências do projeto.
- **`.gitignore`**: Lista de arquivos e diretórios que devem ser ignorados pelo Git.
- **`docker-compose.yml`**: Configuração do Docker Compose para gerenciar múltiplos serviços (opcional).
- **`Dockerfile`**: Configuração da imagem Docker para o projeto.
- **`LICENSE`**: Licença do projeto. **Substitua pelo tipo de licença que deseja usar.**
- **`README.md`**: Este arquivo. **Adapte-o para refletir as informações específicas do seu projeto.**

## Como Usar Este Template

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/andrebg28/template-docker-python
   cd template-docker-python
   ```

2. **Adapte os arquivos e a estrutura de diretórios**:
   - **`README.md`**: Atualize este arquivo para refletir as informações específicas do seu projeto.
   - **`LICENSE`**: Escolha e adicione a licença apropriada para o seu projeto.
   - **`Dockerfile`**: Personalize o `Dockerfile` conforme as necessidades do seu projeto (por exemplo, adicionando dependências específicas).
   - **`docker-compose.yml`**: Se necessário, adicione mais serviços (como banco de dados, filas, etc.) ao `docker-compose.yml`.
   - **`requirements.txt`**: Adicione as dependências do seu projeto ao arquivo `requirements.txt`.
   - **`.gitignore`**: Revise e ajuste o arquivo `.gitignore` para incluir ou excluir arquivos específicos do seu projeto.
   - **`devcontainer.json`**: Personalize o arquivo `devcontainer.json` para configurar o ambiente de desenvolvimento no VS Code de acordo com as necessidades do seu projeto.

3. **Configure o ambiente de desenvolvimento**:
   - Siga o guia de [Instalação do Docker no Windows](./01-instalação-docker.md) para configurar o Docker.
   - Use o guia [Preparando o Docker para Python](./02-preparando-docker-para-python.md) para configurar o ambiente Docker.
   - Configure o VS Code seguindo o guia [Usando o VS Code com Docker](./04-usando-o-vscode.md).

4. **Desenvolva e teste**:
   - Use o VS Code para desenvolver e testar seu código dentro do container Docker.
   - Execute testes unitários e de integração no diretório `app/tests/`.

5. **Compartilhe e colabore**:
   - Compartilhe o repositório com sua equipe e comece a colaborar no desenvolvimento do microsserviço.

## Licença

Este template é distribuído sob a licença [MIT](LICENSE). Sinta-se à vontade para usá-lo, modificá-lo e distribuí-lo conforme necessário. **Não se esqueça de substituir o arquivo `LICENSE` pela licença apropriada para o seu projeto.**

---

## Conclusão

Este template foi projetado para ser uma base sólida para o desenvolvimento de microsserviços em Python, mas **é essencial adaptar os arquivos e a estrutura de diretórios para atender às necessidades específicas do seu projeto**. Comece substituindo o `README.md`, `LICENSE`, `Dockerfile`, `docker-compose.yml`, `requirements.txt`, `.gitignore` e `devcontainer.json` conforme necessário.

Se precisar de mais ajuda ou tiver dúvidas, consulte a documentação ou entre em contato. Boa codificação! 🚀

---

### Links Úteis
- [Documentação do Docker](https://docs.docker.com/)
- [Documentação do VS Code](https://code.visualstudio.com/docs)
- [Documentação do Python](https://docs.python.org/3/)

---

### Arquivos que Devem Ser Adaptados

Aqui está uma lista dos arquivos que **devem ser revisados e adaptados** para o seu projeto:

1. **`README.md`**: Atualize este arquivo para refletir as informações específicas do seu projeto.
2. **`LICENSE`**: Escolha e adicione a licença apropriada para o seu projeto.
3. **`Dockerfile`**: Personalize o `Dockerfile` para incluir dependências e configurações específicas do seu projeto.
4. **`docker-compose.yml`**: Adicione ou remova serviços conforme necessário (por exemplo, banco de dados, filas, etc.).
5. **`requirements.txt`**: Adicione as dependências do seu projeto ao arquivo `requirements.txt`.
6. **`.gitignore`**: Revise e ajuste o arquivo `.gitignore` para incluir ou excluir arquivos específicos do seu projeto.
7. **`devcontainer.json`**: Personalize o arquivo `devcontainer.json` para configurar o ambiente de desenvolvimento no VS Code de acordo com as necessidades do seu projeto.

---

Esse `README.md` agora inclui explicitamente `.gitignore`, `requirements.txt` e `devcontainer.json` na lista de arquivos que devem ser adaptados, garantindo que os usuários saibam exatamente o que precisam personalizar para o novo projeto. Se precisar de mais ajustes, é só me avisar! 😊