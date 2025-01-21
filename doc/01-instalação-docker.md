## Instalação do Docker no Windows

A instalação do Docker é um passo crucial para começar a trabalhar com contêineres. Vamos abordar o processo de instalação do Docker em diferentes ambientes, com foco específico na instalação no Windows utilizando o WSL2 (Windows Subsystem for Linux 2) e no Ubuntu 20.04. Além disso, vamos configurar o Docker Desktop e verificar se a instalação foi bem-sucedida.

### 1. Instalação no Windows com WSL2 (Ubuntu)

O WSL2 (Windows Subsystem for Linux 2) permite que você execute uma distribuição Linux nativamente no Windows, sem a necessidade de uma máquina virtual. Isso torna o WSL2 uma excelente opção para desenvolvedores que desejam usar ferramentas Linux no ambiente Windows, incluindo o Docker.

#### Passo 1: Habilitar o WSL2 e o Hyper-V

Antes de instalar o Docker, é necessário habilitar o WSL2 e o Hyper-V no Windows. O Hyper-V é necessário para que o WSL2 funcione corretamente, pois ele fornece suporte para a execução de sistemas operacionais convidados.

1. **Habilitar o WSL2 e o Hyper-V**:
   Ao final desta seção, há um glossário com os comandos utilizados.
   - Abra o PowerShell como administrador e execute o seguinte comando para instalar o WSL2:

   ```powershell
   wsl --install
   ```
   

   - O proximo comando lista todas a distribuições válidas que podem ser instaladas.
   ```powershell
   wsl -l -o
   ```

   - Eu optei por instalar a o Ubuntu 24.04 LTS, que era a versão mais recente disponível no momento da criação deste documento.
   ```powershell
   wsl --install -d Ubuntu-24.04
   ```
   
   - Em seguida, habilite o Hyper-V:

   ```powershell
   Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
   ```

   -Reinicie o computador após a conclusão desses passos.

   ##### Glossário:
   - **WSL2 (Windows Subsystem for Linux 2)**: Uma tecnologia que permite que você execute um sistema operacional Linux diretamente no Windows, sem a necessidade de uma máquina virtual.
   - **Hyper-V**: Um recurso do Windows que permite a execução de sistemas operacionais convidados, como o WSL2, dentro do Windows.
   - **PowerShell**: Um shell e linguagem de script do Windows que fornece um ambiente de script poderoso e flexível.
   - **wsl**: Um comando do PowerShell que permite interagir com o WSL2.
   - **wsl --install**: Um comando do PowerShell que instala o WSL2.
   - **wsl -l -o**: O parâmetro`-l` lista todas as distribuições válidas que podem ser instaladas. `-o` lista todas as distribuições instaladas.
   - **wsl --install -d Ubuntu-24.04**: Parâmetro `-d` especifica a distribuição a ser instalada. `Ubuntu-24.04` é a distribuição específica que está sendo instalada.
   - **Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All**: Um comando do PowerShell que habilita o Hyper-V.

#### Passo 2: Instalar o Docker no WSL2

Depois de habilitar o WSL2, você pode instalar o Docker diretamente no Ubuntu. Siga os passos abaixo:

1. **Atualize os pacotes do sistema**:
   - Abra o terminal do Ubuntu e execute:

   ```bash
   sudo apt update
   sudo apt upgrade -y
   ```

2. **Instale as dependências necessárias**:
   - O Docker requer algumas dependências para funcionar corretamente. Instale-as com o seguinte comando:

   ```bash
   sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
   ```

3. **Adicione a chave GPG oficial do Docker**:
   - Para garantir que você está instalando o Docker de uma fonte confiável, adicione a chave GPG oficial do Docker ao seu sistema:

   ```bash
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
   ```

4. **Adicione o repositório do Docker**:
   - Adicione o repositório oficial do Docker ao seu sistema:

   ```bash
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   ```

5. **Instale o Docker Engine**:
   - Agora, instale o Docker Engine:

   ```bash
   sudo apt update
   sudo apt install docker-ce docker-ce-cli containerd.io -y
   ```

6. **Inicie e habilite o serviço do Docker**:
   - Inicie o serviço do Docker e configure-o para iniciar automaticamente quando o sistema iniciar:

   ```bash
   sudo systemctl start docker
   sudo systemctl enable docker
   ```

7. **Adicione seu usuário ao grupo `docker`**:
   - Para executar o Docker sem a necessidade de usar `sudo`, adicione seu usuário ao grupo `docker`:

   ```bash
   sudo usermod -aG docker $USER
   ```

   Após essa alteração, reinicie o terminal ou faça logout e login novamente para que as mudanças tenham efeito.

##### Passo 3: Verificar a instalação do Docker

Para verificar se o Docker foi instalado corretamente, execute o comando:

```bash
docker run hello-world
```

Este comando baixará a imagem `hello-world` do Docker Hub e executará um contêiner que exibe uma mensagem de boas-vindas. Se tudo estiver funcionando corretamente, você verá uma saída semelhante a esta:

```
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

### 2. Configuração do Docker Desktop

O Docker Desktop é uma interface gráfica que facilita a gestão de contêineres e imagens Docker. Ele também inclui recursos avançados, como integração com Kubernetes, gerenciamento de volumes e redes, e suporte a pipelines de CI/CD.

#### Passo 1: Baixar e instalar o Docker Desktop

1. **Baixe o Docker Desktop**:
   - Acesse o site oficial do Docker ([https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)) e baixe o instalador para Windows.

2. **Execute o instalador**:
   - Depois de baixar o instalador, execute-o e siga as instruções na tela. Durante a instalação, você terá a opção de habilitar o WSL2 como backend para o Docker. Certifique-se de selecionar essa opção, pois ela permitirá que o Docker funcione de forma mais eficiente no WSL2. 

3. **Configurar o Docker Desktop**:
   - Após a instalação, o Docker Desktop iniciará automaticamente. Na primeira execução, você será solicitado a fazer login com sua conta do Docker. Se você ainda não tiver uma conta, crie uma gratuitamente.

#### Passo 2: Configurar o Docker Desktop para usar o WSL2

Para garantir que o Docker Desktop utilize o WSL2 como backend, siga estes passos:

1. **Abra as configurações do Docker Desktop**:
   - Clique no ícone do Docker na barra de tarefas e selecione "Settings".

2. **Ativar o WSL2**:
   - No menu lateral, selecione "General" e marque a opção "Use the WSL 2 based engine". Em seguida, vá para a seção "Resources" > "WSL Integration" e ative a integração com o Ubuntu 20.04.

3. **Reinicie o Docker Desktop**:
   - Após fazer essas alterações, reinicie o Docker Desktop para que as configurações entrem em vigor.

### 3. Verificação da Instalação

Agora que o Docker Desktop está configurado para usar o WSL2, vamos verificar se tudo está funcionando corretamente.

1. **Verifique o status do Docker**:
   - No terminal do Ubuntu, execute o comando:

   ```bash
   docker info
   ```

   Isso exibirá informações sobre a instalação do Docker, incluindo a versão, o número de contêineres em execução e a configuração do WSL2.

2. **Execute um contêiner de teste**:
   - Execute novamente o comando `docker run hello-world` para garantir que o Docker está funcionando corretamente.

3. **Verifique os contêineres em execução**:
   Use o comando `docker ps -a` para listar todos os contêineres em execução. Como o contêiner `hello-world` é efêmero, ele não aparecerá na lista. Para ver todos os contêineres, inclusive os que já foram parados, use:

   ```bash
   docker ps -a
   ```

### Conclusão

Com a instalação e configuração do Docker concluídas, você está pronto para começar a explorar o mundo dos contêineres. O uso do WSL2 no Windows oferece uma experiência de desenvolvimento quase idêntica à de um ambiente Linux nativo, permitindo que você aproveite todo o poder do Docker sem precisar lidar com as limitações de uma máquina virtual.

No próximo passo, você aprenderá a executar seus primeiros comandos Docker, criando e gerenciando contêineres e imagens. Continue seguindo o plano de estudos para aprofundar seu conhecimento e dominar as ferramentas de contêinerização.

[Proximo - Preparando o Docker para desenvolver em Python](./02-preparando-docker-para-python.md)