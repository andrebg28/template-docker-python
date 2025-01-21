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
WORKDIR /environment

# Copia os arquivos de configuração para o container
COPY ./environment/ . 



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
CMD ["/environment/.venv/bin/jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]