#  Anotações Curso IOS

## Modulo 4 - Estruturas de Pastas

### AppDelegate
Primeiro arquivo/classe que o IOS reconhece para inicializar o app, comportamentos
Exemplo de uso: inicialização de banco de dados, firebase e etc... (tudo que precisa configurar quando inicializa o app)

### SceneDelegate
Vem após o delegate e define como a interface grafica vai ser fornecida

### ViewController
Cada tela tem um Controller (viewController) para administra-las
    1. OUVIR OS EVENTOS DE INPUT (TOUCH)
    2. RENDERIZAR/CONTROLAR OS COMPONENTES DE INTERFACE GRAFICA

### Main.storyboard
Interface grafica para conseguir desenhar o app. Aqui é a primeira tela do App.

### Assets (Pasta)
Onde colocamos nossos recursos (images, paleta de cores, audio, fonts)

### LaunchScreen (storyboard)
Tela inicial do app quando abrimos

### Info.plist
Definimos informações relevantes para o App (configurações do app)
ex: acessos a camera, gps, versao do app e etc ... 

## Modulo 5 - Fundação do SDK e UIKit

### Fluxo de Execução
1. LauchScreen
2. didFinishLaunchingWithOptions
3. scenedelegate (desenha o main storyboard)
4. ViewController

### Fundamentos de Storyboard
Inteface gráfica para criar o app (usa o conceito de drag'n'drop para criar os componentes)

### Linha do Tempo IOS
Começou com o Objective-C
 - era muito verbosa

E do xib (xcode interface builder)

2015 ou 2016 -> Swift + Storyboard
 - Story (fluxo do app em um unico lugar)
 - Visualmente
 - AutoLayout (points) - Não se utiliza pixels pois cada iphone tem uma densidade e tamanho de pixel
 
 Problemas do Storyboard
  - Por baixo dos panos é um arquivo XML (scrito pelo xcode)
  - Impossibilita um grupo de desenvolvedores por ser bem complicado versão controlle de versão.
  - Perdemos na performance por ter que ler o XML
  - Pra perder referencias é bem facil kk

View Code
 - mais performance por ser uma linguagem compilada  
  
  
### Configurando app para viewCode
1. Excluir o main.storyboard
2. Remover do arquivo de configurações (info.plist)
 - Storyboard name
3. Remover da configuração do projeto e do build settings também

### Primeira tela com ViewCode
Configuração inicial
        //Frame é a largura e altura do app
        window = UIWindow(frame: windowScene.coordinateSpace.bounds) // retorna o tamanho da janela
        window?.rootViewController = ViewController()
        window?.windowScene = windowScene
        //se não colocar, não renderiza a tela
        window?.makeKeyAndVisible()

### AutoLayout
Problemas ao usar FRAME
 1. tem que fazer muita matematica
 2. não tem autolayout

Com auto layout conseguimos adaptar nosso layout para qualquer dispositivo "automaticamente"
é sempre necessário desabilitar a seguinte prop no componente para utilizar o auto layout
myComponent.translatesAutoresizingMaskIntoConstraints = false


## Modulo 6 - Arquitetura de software mobile

### Intro Arquitetura Projetos IOS
Reponsabilidade ViewController
1. ouvir eventos touch 
2. Criar Layout

### Arquitetura MVVM com UIKit

Model
    1. Abrir conexões com bancos
    2. Ler arquivos 
    3. Requests ...

View (View Controller)
    1. Eventos 
    2. Eventos SO
    3. Layout
    
ViewModel
    1. Regra de negócio
    2. Ações
    3. Formatar o modelo de visualização
    
A view tem uma referencia da view model e vai observar o viewModel. 
Sempre que o viewModel notificar uma mudança a view renderiza algo.
A viewmodel observa a camada model

### Navigation Controller
Precisamos de um Navigation Controller para conseguir navegar pelas telas
