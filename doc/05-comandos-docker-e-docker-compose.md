# Proposito do documento
Este documento tem como objetivo fornecer uma visão geral de como executar comandos Docker para gerenciar imagens, contêineres e volumes.

Consideramos que você já tenha instalado o Docker em sua máquina. Se você ainda não tem o Docker instalado, consulte a documentação que acompanha este template. O documento [Instalação do Docker no Window](./01-instalação-docker.md) te auxiliará no processo de instalação, o [02-preparando-docker-para-python.md](./02-preparando-docker-para-python.md) vai te auxiliar na configuração do ambiente Docker para Python. **_Estes dois documentos são pre requisitos para acompanhar este documento. A não ser que você já tenha o Docker instalado e pretende usar seu próprio Dockerfile._**

### Passo 1: Construir a imagem local

No terminal, dentro da pasta `meu_projeto`, execute:

```bash
# Criar a imagem localmente com o nome:tag "meu_projeto_imagem:latest"
docker build -t meu_projeto_imagem:latest .
```
Isso irá criar a imagem localmente com o nome:tag `meu_projeto_imagem:latest`.

- O ponto final do comando `docker build` indica o diretório atual como o contexto de construção.
- Você pode dar um nome e uma tag para sua imagem personalizada, como: 
  - minha_imagem_python_data_science:v1.0
    - nome: minha_imagem_python_data_science
    - tag: v1.0
  - python_data_science:latest
    - nome: python_data_science
    - tag: latest


Ou se preferir, você pode usar o arquivo `docker-compose.yml` para construir a imagem com o Docker Composer:

```bash
docker-compose build 
```


---

### Passo 6: Executar o container com volume para persistência

Para rodar o container e garantir que seus arquivos permaneçam no seu sistema local, utilizamos a opção `-v` para mapear uma pasta local para a pasta `/app` do container. Você também deverá expor a porta 8888 para acessar o Jupyter Notebook no navegador:

```bash
docker run -it --rm \
    -p 8888:8888 \
    -v "${PWD}"/app:/app \
    --name meu_projeto_container \ 
    meu_projeto_imagem:latest # Substitua pelo nome da sua imagem
```


- **`-p 8888:8888`**: Expõe a porta 8888 do container na porta 8888 da sua máquina, permitindo acessar o Jupyter pelo navegador em `http://localhost:8888`.
- **`-v "${PWD}"/app:/app`**: Mapeia a pasta local `./app` (onde estão seus Jupyter Notebooks) para a pasta `/app` dentro do container. Assim, qualquer alteração nos arquivos será persistida em seu sistema local.
- **`-it`**: Mantém o container em modo interativo, permitindo que você inspecione e interaja com o container.
- **`--rm`**: Remove o container automaticamente quando você interromper o processo.
- **`--name meu_projeto_container`**: Dar um nome facilita o gerenciamento do container.
- **`meu_projeto_imagem:latest`**: Substitua pelo nome:tag da sua imagem. Eu usei `meu_projeto_imagem:latest`, que foi criada no **Passo 5**.

Ou se preferir, você pode usar o arquivo `docker-compose.yml` para executar o container:

```bash
# Iniciar o container com o Docker Composer
docker-compose up
```

O comando `docker-compose up` irá iniciar o container.

Quando o comando terminar de inicializar, você verá no terminal um link ou token para acesso ao Jupyter Notebook. Copie-o e abra em seu navegador.

---

### Passo 7: Trabalhando nos Notebooks

Dentro da interface do Jupyter Notebook, você poderá ver o diretório `/app`, que corresponde à sua pasta `app` local. Crie o diretório notebooks, caso ainda não exista, e crie um notebook `exemplo-001.ipynb`:

Insira o seguinte script no `exemplo-001.ipynb`:

```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Exemplo: Criando um DataFrame
data = {
    'Semana': [1, 2, 3, 4],
    'Estudo (horas)': [10, 12, 8, 15]
}
df = pd.DataFrame(data)
print("DataFrame:\n", df)

# Exemplo: Visualização básica
plt.figure(figsize=(6,4))
sns.barplot(data=df, x='Semana', y='Estudo (horas)')
plt.title('Horas de estudo por semana')
plt.show()
```

Ao executar este notebook no Jupyter em `http://localhost:8888`, você verá a saída do DataFrame e o gráfico gerado. Qualquer arquivo salvo permanecerá na pasta `notebooks` no seu computador.

---

### Passo 8: Limpar o ambiente

Se você não estiver usando o docker-compose, você pode parar e remover o container com:

```bash
# Para listar os containers em execução
docker ps

# Para listar todos os containers (incluindo os parados)
docker ps -a

# Para parar o container específico em execução
docker stop <container_id_ou_nome>

# Para remover o container específico e parado
docker rm <container_id_ou_nome>

# Opcionalmente, você pode remover a imagem pelo nome
# ou pelo ID, substituindo <container_id_ou_nome> pelo nome ou ID do container.
```

📝 **Nota:** Se você usou a flag -rm no passo 6, basta pressionar Ctrl + C para parar e remover automaticamente no terminal.

Se você estiver usando o docker-compose, você pode parar e remover o container com:

```bash
# Após terminar de trabalhar no Jupyter Notebook, você pode parar e remover o container assim:
docker-compose down
# Este comando também removerá redes criadas pelo docker-compose(Quando aplicável, não é o caso aqui)
```

- Os volumes persistentes não serão removidos a menos que especificado com -v. Lembre-se que isso removerá todos os dados que você salvou no container, **USE COM CUIDADO**. 

⚠️ **Atenção**: O comando abaixo removerá todos os dados que você salvou no container. **_USE COM CUIDADO!_**
```bash
# Para remover o container e os volumes persistentes
# O -v remove os volumes persistentes, USE COM CUIDADO!
docker-compose down -v
```

- Caso você queira iniciar novamente, basta repetir o comando do **passo 6**.

---

## Fluxo de trabalho no terminal
Considerando que você já tenha:
- instalado o Docker e o Docker Compose em sua máquina.
- criado a estrutura de diretórios para seu projeto.
- criado o `Dockerfile` para personalizar a imagem Docker para as suas necessidades.
- criado o arquivo `requirements.txt` para definir as dependências do seu projeto.
- criado o arquivo `docker-compose.yml` para definir o serviço do Jupyter Notebook. **_(Opcional: Caso prefira utilizar o Docker Compose)_**
- e esteja com o terminal aberto na pasta do seu projeto.

### Passo 1: Você pode criar a imagem Docker com o seguinte comando:
- com comando docker:
```bash
# 1. Construir a imagem Docker
docker build -t meu_projeto_imagem:latest .
```
- com comando docker-compose:
```bash
# 1. Construir a imagem Docker
docker-compose build
```

📝 **Nota:** Você só precisara repetir este comando caso remova a imagem criada.
- Cenário 1: Você alterou o seu `Dockerfile` ou `requirements.txt`. Então você precisa reconstruir a imagem.
- Cenário 2 **_(Opcional)_**: Você alterou o seu `docker-compose.yml`. Então você precisa reconstruir a imagem.

```bash
# Para remover uma imagem é necessário parar e remover todos os container associados a esta imagem primeiro.
# Então comesse listando os containers:
docker ps -a

# Para parar o container específico em execução associado a imagem:
docker stop <container_id_ou_nome>

# Para remover o container específico e parado associado a imagem:
docker rm <container_id_ou_nome>

# Caso precise listar as imagens:
docker images

# Para remover a imagem específica:
docker rmi <nome_ou_id_da_imagem>

# Se quiser aproveitar para remover todas as imagens que não estão sendo utilizadas:
docker rmi $(docker images -q -f dangling=true)
```

- Agora você pode reconstruir a imagem com `docker run` ou `docker-compose build`, como mostrado acima.

### Passo 2: Execute o container:

Você pode seguir este fluxo de trabalho para construir, executar o container, parar e remover o container:

- Com comandos docker e usando a flag -rm:
  - Cenário: Você deseja executar o container e remover automaticamente quando você sair do terminal.
```bash
# Construir e executar o container
docker run -it --rm -p 8888:8888 -v "${PWD}"/app:/app --name meu_projeto_container meu_projeto_imagem:latest # Substitua pelo nome da sua imagem

# Como usamos a flag --rm, o container será removido automaticamente quando sairmos do terminal ou quando pararmos o container:
# Ctrl + C para sair do terminal ou parando o container com o comando:
docker stop meu_projeto_container # ou o nome do container que você escolheu
```

- Com comando docker e sem usar a flag -rm:
  - Cenário: Você deseja executar o container e manter o container em execução mesmo após sair do terminal.
```bash
# Construir e executar o container
docker run -it -p 8888:8888 -v "${PWD}"/app:/app --name meu_projeto_container meu_projeto_imagem:latest # Substitua pelo nome da sua imagem

# Você pode sair do terminal, ou sair do container e ele continuará em execução.

# Se precisar listar os container em execução:
docker ps

# Para voltar ao container, você pode usar o comando:
docker exec -it meu_projeto_container bash # ou docker exec -it <container_id> bash

# Voce pode fechar o terminal, sair do container, continuando usando seus recursos e voltar a ele quantas vezes desejar.

# Para parar o container:
docker stop meu_projeto_container # ou o nome do container que você escolheu, opcionalmente pode usar o id do container

# Para reexecutar o container parado:
# se precisar liste os containers com o comando: 
docker ps -a

# Para iniciar o container:
docker start meu_projeto_container 

# Para remover o container:
# Certifique-se de que o container esteja parado antes de tentar removê-lo. Use o comando: docker stop <container_nome_ou_id>
docker rm meu_projeto_container # ou o nome do container que você escolheu, opcionalmente pode usar o id do container
```

- Com comando docker-compose:
  - Cenário: Você deseja executar o container e remover automaticamente quando você sair do terminal.
```bash
# Construir e executar o container
docker-compose up -d
# Como usamos a flag -d, o container será removido automaticamente quando sairmos do terminal ou quando pararmos o container:
# Ctrl + C para sair do terminal ou parando o container com o comando:
docker-compose down 
```
  - Cenário: Você deseja executar o container e manter o container em execução mesmo após sair do terminal.
```bash
# Construir e executar o container
docker-compose up

# Você pode sair do terminal, ou sair do container e ele continuará em execução.
# Para sair do container, mantendo-o em execução, você pode usar o comando:
# ??? Isto esta correto neste cenário???

# Se precisar listar os container em execução:
docker ps # ??? Isto esta correto ???
# Para voltar ao container, você pode usar o comando:
docker exec -it meu_projeto_container bash # ??? Isto esta correto ???

# Voce pode fechar o terminal, sair do container, continuando usando seus recursos e voltar a ele quantas vezes desejar.

# Para parar o container sem remove-lo:
docker-compose stop # ??? Isto esta correto ???

# Para reexecutar o container parado:
# se precisar liste os containers com o comando:
docker ps -a

# Reexecutar o container:
docker-compose up # ??? Isto esta correto ???

# Para parar e remover o container:
docker-compose down
```

---

## Resumo

1. **Crie** a estrutura de diretórios para seu projeto.
2. **Crie** o `Dockerfile` para personalizar a imagem Docker para as suas necessidades.  
3. **Crie** o arquivo `requirements.txt` para definir as dependências do seu projeto.
4. **Crie** o arquivo `docker-compose.yml` para definir o serviço do Jupyter Notebook. **_(Opcional)_**
5. **Construa** a imagem localmente.  
6. **Rode** o container mapeando uma pasta local para persistir seus projetos.  
7. **Acesse** o Jupyter Notebook pelo browser em `http://localhost:8888`.  
8. **Crie e edite** arquivos `.ipynb` diretamente no Jupyter, com toda a persistência garantida na sua máquina.

---
## Conclusão

**- Dessa forma, você possui um ambiente isolado pronto para seguir um roteiro de estudos, desenvolvimento de projetos ou pacotes python, desenvolvendo localmente de forma organizada e sem risco de “quebrar” sua instalação principal de Python.**
**- Essa abordagem visa criar um ambiente de desenvolvimento que permita aos usuários explorar e aprender a trabalhar com o Docker de forma prática e interativa.**
**- O processo descrito aqui é uma introdução ao uso do Docker e Python, mas é importante lembrar que o Docker é uma ferramenta poderosa e flexível que pode ser usada para muitas outras finalidades além desses exemplos. Logo você poderá adaptar esses conceitos para suas próprias necessidades, e com outras linguagens.**
 
**_Aproveite bem!☕_**


[Voltar - Usando o VS Code](./04-usando-o-vscode.md)