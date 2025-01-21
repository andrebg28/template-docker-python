# Proposito do documento
Abaixo está um exemplo prático de como você pode configurar um ambiente docker com a partir da imagem [python:3.13.1-slim-bookworm](https://hub.docker.com/_/python) para ou desenvolver em python Python voltado. 
Também incluímos um volume para persistência dos arquivos do projeto localmente, arquivos de configuração, etc.
O diretório `.devcontainer` contém arquivos de configuração, `devcontainer.json`, para o VS Code de modo que seja possível desenvolver em Python no VS Code.

Modifique o arquivo `Dockerfile`, `docker-compose.yml`, `\env\requirements.txt`, `\.devcontainer\devcontainer.json` e a estrutura de diretórios, para atender às suas necessidades.


---

### Passo 1: Estrutura de diretórios

Crie uma estrutura de diretórios como a seguinte:
- Recomenda-se que o nome do projeto seja o mesmo do diretório. Então substitua `template-docker-python` pelo nome do seu projeto.

```
template-docker-python
├── .devcontainer
│   └── devcontainer.json
├── app
│   ├── src
│   │   └── __init__.py
│   │   └── exemplo.py
│   ├── notebooks
│   │   └── exemplo.ipynb
│   ├── tests
│   │   └── test_exemplo.py
│   ├── doc
│   │   └── 01-instalação-docker.md
│   │   └── 02-usando-docker-com-python.md
│   ├── mypy.ini
├── env   
│   └── requirements.
│   └── .env
├── .gitignore
├── docker-compose.yml
├── Dockerfile
├── LICENSE
├── README.MD
```

- **`template-docker-python/`**: Pasta raiz do projeto.
- **`/.devcontainer/devcontainer.json`**: Arquivo de configuração para o VS Code, para que ele use o Docker como ambiente de desenvolvimento.
- **`app`**: Aqui você irá colocar seus arquivos, os diretórios do seu projeto ou códigos.
  - **_(Opcional, quando estiver criando um projeto para por em produção ou pacote)_**
- **`mypy.ini`**: Arquivo de configuração do MyPy.
  - **_(Opcional, quando estiver fazendo verificação de tipos e trabalhando em modo estrito)_**
- **`src`**: Aqui você colocara arquivos de código Python, como: `__init__.py`, `exemplo.py`, etc. Aqui você pode desenvolver seu projeto para produção, pacote para o PYPI, etc.
  - **_(Opcional, quando estiver criando um projeto para por em produção ou pacote)_**
- **`notebooks`**: Esse é o local onde você destinará os arquivos Jupyter Notebook (`.ipynb`). 
  - **_(Opcional, quando estiver trabalhando Notebooks.ipynb)_**
- **`tests`**: Aqui você irá colocar seus arquivos de teste, como: `test_exemplo.py`, etc.
- **`doc`**: Aqui você irá encontrar arquivos de documentação deste template, como: `01-instalação-docker.md`, `02-usando-docker-com-python.md`, etc.
  - **_(Opcional, você pode substituir os arquivos por documentação de seu projeto)_**
- **`env`**: Aqui você irá colocar os arquivos de configuração do ambiente virtual, como: `requirements.txt`.
- **`.gitignore`**: Arquivo que define quais arquivos e diretórios serão ignorados pelo Git.
- **`docker-compose.yml`**: Aqui você pode definir as configurações para o Docker Compose, se você estiver usando ele para gerenciar seus contêineres. 
    **_(Opcional. Não é necessário para este exemplo, mas pode ser útil em projetos mais complexos.)_**
- **`Dockerfile`**: Onde definimos a imagem base e as configurações necessárias para instanciar um container.
- **`LICENSE`**: Arquivo que define a licença do seu projeto.
  - **_(Opcional, você pode substituir o arquivo pela licença do seu projeto)_**
- **`README.md`**: Arquivo que contém informações sobre o template.
  - **_(Recomendado, você pode substituir o arquivo pelo README do seu projeto)_**
- **_`requirements.txt`**: Arquivo onde você define as dependências do seu projeto.
- **`.env`**: Arquivo onde você define as variáveis de ambiente do seu projeto.
- **`Estrutura didática`**: **_Opcional, caso seja um ambiente didático, você pode optar pela seguinte estrutura de diretórios, com múltiplos projetos_**


---

### Passo 2: Arquivo Dockerfile

Para este template, na raiz do projeto, foi crie um arquivo, chamado `Dockerfile` com o conteúdo abaixo:

```dockerfile
# Usar a imagem oficial Python 3.13.1-slim-bookworm
FROM python:3.13.1-slim-bookworm

# Atualizar lista de pacotes e instalar dependências do sistema (caso necessário)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Cria o usuário vscode e define permissões
RUN useradd -m -s /bin/bash vscode && \
    usermod -aG sudo vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    mkdir -p /home/vscode && \
    chown -R vscode:vscode /home/vscode

# Define o usuário padrão como vscode
USER vscode

# Definir diretório de configuração
WORKDIR /env

# Copia os arquivos de configuração para o container
COPY ./env/ . 



# Cria o ambiente virtual, atualiza o pip e instala as dependências.
# Importante: o ambiente virtual (.venv) é criado no diretório da aplicação (/app).
RUN python3 -m venv .venv && \
    . .venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Criar o diretorio do projeto
WORKDIR /app

# Copia os arquivos do projeto para o container
COPY ./app/ . 
# Expor a porta padrão do Jupyter Notebook

EXPOSE 8888

# Comando que inicia o Jupyter Notebook dentro do ambiente virtual
CMD ["/env/.venv/bin/jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# CMD-2: Para ativar o ambiente virtual e iniciar o Jupyter automaticamente quando o contêiner for iniciado
# CMD ["/bin/bash", "-c", "source /app/.venv/bin/activate && jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root"]

# CMD-3: Para ativar apenas o ambiente virtual sem iniciar automaticamente o Jupyter
# CMD ["/bin/bash", "-c", "source /app/.venv/bin/activate && /bin/bash"]
```

O que este Dockerfile faz?

- **FROM python:3.13.1-slim-bookworm**: Define a imagem base como a versão 3.13.1 do Python, com a versão slim e bookworm.
- **RUN apt-get update && apt-get install -y --no-install-recommends build-essential**: Atualiza a lista de pacotes e instala as dependências do sistema necessárias para compilar pacotes Python.
- **RUN useradd -m -s /bin/bash vscode && usermod -aG sudo vscode && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && mkdir -p /home/vscode && chown -R vscode:vscode /home/vscode**: Cria o usuário vscode, define permissões e configurações de usuário. Necessário para o vscode acessar o container.
- **WORKDIR /env**: Define o diretório de trabalho como `/env`. É neste diretório que o ambiente virtual Python será criado.
- **COPY ./env/ .**: Copia os arquivos de configuração para o container.
- **RUN python3 -m venv .venv && . .venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt**: Cria o ambiente virtual, atualiza o pip e instala as dependências do projeto descritas no arquivo `requirements.txt`.
- **WORKDIR /app**: Define o diretório de trabalho como `/app`. Ele será o diretório padrão onde o código do projeto será colocado. Um volume será montado para permitir os arquivos do projeto serem acessados a partir do container.
- **COPY ./app/ .**: Copia os arquivos do projeto, que estão no volume `./app/`, para o container.
  - **_(`WORKDIR /app` é o diretório que corresponde ao diretório de trabalho dentro do container. `COPY ./app/ .` é o comando que copia os arquivos persistidos no volume `./app/` para o diretório `/app/` dentro do container. O volume é o diretorio é o diretorio `./app/` que esta na raiz do projeto.)_**
- **EXPOSE 8888**: Exponha a porta 8888 para o Jupyter Notebook.
- **CMD ["/env/.venv/bin/jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]**: Inicia o Jupyter Notebook com as configurações especificadas, assim que o container seja iniciado.

Observação: 
- As opçãos CMD-2 e CMD-3 são alternativas para iniciar o ambiente virtual na inicialização do container.
  - CMD-2: Ativa o ambiente virtual e inicia o Jupyter Notebook automaticamente.
  - CMD-3: Ativa apenas o ambiente virtual sem iniciar automaticamente o Jupyter.
- Após iniciar o contêiner com uma dessas configurações, você pode acessar o shell bash interativo usando docker exec -it <nome_do_container> /bin/bash. O ambiente virtual já estará ativado dentro desse shell.
  - Lembre-se de substituir <nome_do_container> pelo nome real do seu contêiner.
  - Para sair do shell bash, use o comando `exit`.
- Com essas opções, você terá mais controle sobre como o ambiente virtual é usado dentro do seu contêiner Docker.


---

### Passo 3: Criar o arquivo requirements.txt
Verifique o conteúdo de `/env/requirements.txt` remova as dependências desnecessárias e adicione as que fazem parte do seu projeto.
O exemplo abaixo é para um simples projeto de análise de dados.
```
jupyter
pandas
matplotlib
seaborn
```

---

### Passo 4: Crie o arquivo docker-compose.yml _(Opcionalmente: Só se você for utilizar o Docker Composer)_


```yml
version: '3'

services:
  jupyter:
    build: .
    volumes:
      - ./app:/app
    ports:
      - "8888:8888"
    tty: true  # equivalente ao -t
    stdin_open: true  # equivalente ao -i
    restart: always
```
Esse arquivo docker-compose.yml faz o seguinte:

- **"jupyter"**: Define um serviço chamado jupyter
- **"build: ."**:Usa o arquivo Dockerfile para construir a imagem
- **"volumes: ./app:/app"**: Monta o diretório ./app como um volume no container (/app)
- **"ports: "8888:8888""**: Expor a porta do Jupyter (8888) para o host
- **"tty: true"**: Mantém a conexão TTY aberta. Isso é útil para depuração e interação com o container.
- **"stdin_open: true"**: Mantém a entrada padrão aberta. 
- **"restart: always"**: Garante que o container seja reiniciado automaticamente em caso de falha.
---

### Passo 5: Criando o arquivo .devcontainer/devcontainer.json
O arquivo .devcontainer/devcontainer.json é usado para configurar o ambiente de desenvolvimento dentro do Visual Studio Code. Aqui está um exemplo de como configurar o ambiente para um projeto Python com Jupyter Notebook:

```json
{
  "name": "Python Dev Container",
  "build": {
          "dockerfile": "../Dockerfile"
  },
  "remoteUser": "vscode",
  "mounts": [
    "source=${localWorkspaceFolder}/app,target=/app,type=bind"
  ],
  "settings": {
          "python.pythonPath": "/env/.venv/bin/python",
          "terminal.integrated.shell.linux": "/bin/bash"
  },
  "extensions": [
          "ms-python.python",
          "ms-python.vscode-pylance"
  ],
  "forwardPorts": [
    8888
  ],
  "remoteUser": "vscode",
  "postStartCommand": "/env/.venv/bin/jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root"
}
```
- **"name": "Python Dev Container"**: Define o nome do ambiente de desenvolvimento.
- **"build": { "dockerfile": "../Dockerfile" }**: Especifica o Dockerfile a ser usado para construir a imagem.
- **"remoteUser": "vscode"**: Define o usuário remoto como "vscode".
- **"mounts": [ "source=${localWorkspaceFolder}/app,target=/app,type=bind" ]**: Monta o diretório app como um volume no container.
- **"settings": { "python.pythonPath": "/env/.venv/bin/python", "terminal.integrated.shell.linux": "/bin/bash" }**: Configura o caminho do Python e o shell integrado ao container.
- **"extensions": [ "ms-python.python", "ms-python.vscode-pylance" ]**: Instala as extensões Python e Pylance.
- **"forwardPorts": [ 8888 ]**: Encaminha a porta 8888 para o host. Isso permite que você acesse o Jupyter Notebook localmente.
- **"remoteUser": "vscode"**: Define o usuário remoto como "vscode". Esse é o mesmo criado no Dockerfile. É através dele que o VSCode consegue acessar o container.
- **"postStartCommand": "/env/.venv/bin/jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root"**: Executa o comando para iniciar o Jupyter Notebook após o container ser iniciado.

---

## Conclusão
Este guia forneceu uma visão geral dos passos necessários para configurar um ambiente de desenvolvimento Python com Jupyter Notebook usando Docker. Lembre-se de adaptar os arquivos conforme necessário para atender às suas necessidades específicas.

[Voltar - Instalação do Docker no Windows](./01-instalação-docker.md)
[Proximo - Exemplo de requirements.txt](./03-exemplos-de-requirements.txt.md)