//
//  GameScene.swift
//  Dandee
//
//  Created by DAM2T1 on 23/4/18.
//  Copyright © 2018 Thor. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Guía oficial de Apple sobre SpriteKit
    /* https://developer.apple.com/documentation/spritekit */
    
    // Scene: es el nodo raíz de todos los objetos SpriteKit que se desplegarán en una vista.
    // Para desplegar una "scene" tienes que presentarla desde un objeto SKView
    // Node: un nodo es el bloque fundamental de construcción de casi todo el contenido en SpriteKit.
    // Un nodo puede estar vacío y no dibujar nada en pantalla, para poder dibujar algo en pantalla
    // hay que utilizar subclases de SKNode, por ejemplo SKSpriteNode para dibujar un sprite.
    // SpriteNode: Para crear un SpriteNode, es necesario una textura (imagen) y de un Frame, el cual
    // contiene un rectángulo que define el área que cubrirá el SpriteNode
    // Todo SpriteNode tiene una posición (position) y un punto de anclado (Anchor Point)
    // El punto de anclado de un nodo Sprite es la propiedad que determina que punto de su
    // "Frame" está situado en la posición del sprite (por defecto - (0.5, 0.5) en medio - va de 0.0 a 1.0)
    
    // La propiedad categoryBitMask es un número que define el tipo de objeto que el cuerpo físico del nodo
    // tendrá y es considerado para las colisiones y contactos.
    // La propiedad collisionBitMask es un número que define con qué categorías de objeto este nodo debería colisionar
    // La propiedad contactTestBitMask es un número que define qué colisiones no serán notificadas
    // Si le das a un nodo números de Collision BitMask pero no le das números de contactTestBitMask, significa
    // que los nodos podrán colisionar pero no tendrás manera de saber cuándo ocurrió en código (no se notifica al sistema)
    // Si haces lo contraro (no collisionBitMask pero si contactTestBitMask), no chocarán o colisionarán, pero
    // el sistema te podrá notificar el momento en que tuvieron contacto.
    // Si a las dos propiedades les das valores entonces notificará y a la vez los nodos podrán colisionar
    // De forma predeterminada los cuerpos físicos tienen su propiedad collisionBitMask a todo y su
    // contactBitMask a nada
    
    // Todo elemento en pantalla es un nodo
    
    // Nodo de tipo SpriteKit para la mosquita
    
    //Nodo de tipo SpriteKit para el mainCharacter
    var ashKethup = SKSpriteNode()
    
    //Nodo de tipo SpriteKit para los bichos malos
    var pkmn1 = SKSpriteNode()
    var pkmn2 = SKSpriteNode()
    var pkmn3 = SKSpriteNode()
    
    //Nodo de tipo SpriteKit para las pokeBalas
    var pokeBall = SKSpriteNode()

    //Nodo de tipo SpriteKit para el disparo del mainCharacter
    var disparo = SKSpriteNode()
    
    //Nodo para el fondo de la pantalla
    var fondo = SKSpriteNode()
    
    //Nodo para la plataforma de ashKetchup
    var plataformaNodo = SKSpriteNode()
    
    //Nodo label para la puntuacion
    var labelPts  = SKLabelNode()
    var puntuacion = 0
    
    //Nodo para vida
    var vida1 = SKSpriteNode()
    var vida2 = SKSpriteNode()
    var vida3 = SKSpriteNode()
    var arrayVidas :[SKSpriteNode] = [SKSpriteNode]()
    var contadorVidas = 3
    
    //Textura vida
    var texturaVida = SKTexture()
    
    //Texturas ashKethup
    var texturaAsh1 = SKTexture()
    var texturaAsh2 = SKTexture()
    var texturaAsh3 = SKTexture()
    var texturaAsh4 = SKTexture()
    
    //Texturas bichoMalo 1
    var texturaPKM11 = SKTexture()
    var texturaPKM12 = SKTexture()
    var texturaPKM13 = SKTexture()
    var texturaPKM14 = SKTexture()
    
    //Texturas pokeball
    var texturaPKB1 = SKTexture()
    var texturaPKB2 = SKTexture()
    var texturaPKB3 = SKTexture()
    var texturaPKB4 = SKTexture()
    var texturaPKB5 = SKTexture()
    var texturaPKB6 = SKTexture()
    
    
    //Texturas bichoMalo 2
    var texturaPKM21 = SKTexture()
    var texturaPKM22 = SKTexture()
    var texturaPKM23 = SKTexture()
    var texturaPKM24 = SKTexture()
    /*
    //Texturas bichoMalo 3
    var texturaPKM31 = SKTexture()
    var texturaPKM32 = SKTexture()
    var texturaPKM33 = SKTexture()
    var texturaPKM34 = SKTexture()
    
    //Texturas bichoMalo 4
    var texturaPKM41 = SKTexture()
    var texturaPKM42 = SKTexture()
    var texturaPKM43 = SKTexture()
    var texturaPKM44 = SKTexture()
    */
    
    //Para limitar el total de pokeballs que se lanzan a la vez
    var totalPokeballsEscena = 0
    
    //altura aleatoria a la que salen los bichosMalos
    var alturaAleatoriaAparicionBicho = CGFloat()
    
    //timer para que salgan los bichosMalos
    var timer = Timer()
    //boolean para saber si el juego está activo o finalizado
    //(si algun bichoMalo llega a la plataforma de ashKetchup, gameover)
    var gameOver = false
    
    //variables para mostrar los tipos de bichomalo aleatoriamente
    var cantidadAleatoria = CGFloat()
    // altura en la que aparecen los bichosMalos
    var alturaBichoMalo = CGFloat()
    
    //Variables para calcular el intervalo en el que aparecen los bichos
    var interval = 3.0
    var timeInterval = 3.0
    
    //Variable para mostrar aleatoriamente un pokemon u otro
    var pokemonAleatorio = 0.0
    
    //Enumeracion de los nodos que pueden colisionar
    enum tipoNodo : UInt32{
        case bicho = 1   //Si el bicho llega hasta la plataforma
        case plataforma = 2
        case bala = 4
        case disparoBicho = 6       // Si el disparo toca al bicho
    }
    
    // Función equivalente a viewDidLoad
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        // Nos encargamos de las colisiones de nuestros nodos
        self.physicsWorld.contactDelegate = self
        reiniciar()
    }
    
    func reiniciar() {
        // Creamos los bichosMalos de manera constante e indefinidamente
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.crearBichosMalos), userInfo: nil, repeats: true)
        
        
        // El orden al poner los elementos es importante, el último tapa al anterior
        // Se puede gestionar también con la posición z de los sprite

        
        crearFondo()
        crearPlataforma()
        crearMainCharacter()
        crearBichosMalos()
        ponerPuntuacion()
        ponerVida()
    }
    
    func ponerPuntuacion() {
        labelPts.fontName = "Arial"
        labelPts.fontSize = 80
        labelPts.text = "0"
        labelPts.position = CGPoint(x: self.frame.midX, y: self.frame.maxY-80)
        labelPts.zPosition = 1
        self.addChild(labelPts)
    }
    
    func ponerVida(){
        
        vida1.position = CGPoint(x: self.frame.maxX, y: self.frame.maxY)
        vida2.position = CGPoint(x: self.frame.minX, y: self.frame.maxY)
        vida3.position = CGPoint(x: self.frame.maxX-80, y: self.frame.maxY)
        
        arrayVidas.append(vida1)
        arrayVidas.append(vida2)
        arrayVidas.append(vida3)

        
        let texturaVida = SKTexture(imageNamed: "vida.png")
        vida1 = SKSpriteNode(texture: texturaVida)
        vida2 = SKSpriteNode(texture: texturaVida)
        vida3 = SKSpriteNode(texture: texturaVida)

        self.addChild(vida1)
        self.addChild(vida2)
        self.addChild(vida3)

        
    }
    
    func crearPlataforma() {
       
        //TO-DO: darle forma
        //Textura
        
        plataformaNodo.zPosition = 0
        
        plataformaNodo.position = CGPoint(x: self.frame.minX + 120, y: 0.0)
        plataformaNodo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: self.size.height))
        // la plataforma tiene que estar quieta
        plataformaNodo.physicsBody!.isDynamic = false
        
        // Categoría para collision
        plataformaNodo.physicsBody!.categoryBitMask = tipoNodo.plataforma.rawValue
        // Colisiona con el bichoMalo
        plataformaNodo.physicsBody!.collisionBitMask = tipoNodo.bicho.rawValue
        // contacto con el suelo
        plataformaNodo.physicsBody!.contactTestBitMask = tipoNodo.bicho.rawValue
        
        self.addChild(plataformaNodo)
    }
    
    func crearFondo(){
        //Textura
        let texturaFondo = SKTexture(imageNamed: "fondo.png")
        fondo = SKSpriteNode(texture: texturaFondo)
        fondo.position = CGPoint(x: 0.0, y: 0.0)
        fondo.size.height = self.frame.height
        fondo.size.width = self.frame.width
        fondo.zPosition = -1
        
        print("Altura pantalla",self.frame.height)
        print("Ancho pantalla", self.frame.width)
        self.addChild(fondo)
    }
    
    func crearMainCharacter(){
        //Asignamos texturas al ashKetchup
        texturaAsh1 = SKTexture(imageNamed: "ash1.png")
        
        // Le ponemos la textura inicial al nodo
        ashKethup = SKSpriteNode(texture: texturaAsh1)
        // Posición inicial en la que ponemos a la mosquita
        // (0.5, 0.0)
        ashKethup.position = CGPoint(x: self.frame.minX + 90, y: self.frame.midY)

        ashKethup.zPosition = 1
        
        // Ponemos ashKetchup en la escena
        self.addChild(ashKethup)
    }
    
    func crearBala(vector: CGVector){
        // Acción para mover la bala a donde tocamos
        let path = UIBezierPath()
        path.move(to: CGPoint(x: ashKethup.position.x, y: ashKethup.position.y))
        path.addLine(to: CGPoint(x: vector.dx, y: vector.dy))
        
        let crearBullet = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        // Acción para borrar las balas cuando lleguen al destino
        let borrarPokeball = SKAction.removeFromParent()
        
        // Acción que enlaza las dos acciones
        let moverBorrarPokeball = SKAction.sequence([crearBullet, borrarPokeball])
    
        //let crearBullet = SKAction.move(by: CGVector(dx: vector.dx, dy: vector.dy), duration: TimeInterval(self.frame.width / 10))

        //ASIGNAMOS TEXTURAS
        texturaPKB1 = SKTexture(imageNamed: "pkb1.png")
        texturaPKB2 = SKTexture(imageNamed: "pkb2.png")
        texturaPKB3 = SKTexture(imageNamed: "pkb3.png")
        texturaPKB4 = SKTexture(imageNamed: "pkb4.png")
        texturaPKB5 = SKTexture(imageNamed: "pkb5.png")
        texturaPKB6 = SKTexture(imageNamed: "pkb6.png")
        
        // Acción que indica las texturas y el tiempo de cada uno
        let animacion = SKAction.animate(with: [texturaPKB1, texturaPKB2, texturaPKB3, texturaPKB4, texturaPKB5, texturaPKB6], timePerFrame: 0.1)
        let animacionInfinita = SKAction.repeatForever(animacion)
        pokeBall = SKSpriteNode(texture: texturaPKB1)
        //pokeBall.position = CGPoint(x: ashKethup.position.x, y: ashKethup.position.y)
        pokeBall.zPosition = 0
        
        // Le damos cuerpo físico al tubo
        pokeBall.physicsBody = SKPhysicsBody(rectangleOf: texturaPKB1.size())
        // Para que no caiga
        pokeBall.physicsBody!.isDynamic = true
        // Categoría de collision
        pokeBall.physicsBody!.categoryBitMask = tipoNodo.bala.rawValue
        
        // con quien colisiona
        pokeBall.physicsBody!.collisionBitMask = tipoNodo.bicho.rawValue
        
        // Hace contacto con
        pokeBall.physicsBody!.contactTestBitMask = tipoNodo.bicho.rawValue
        
        pokeBall.run(animacionInfinita)
        pokeBall.run(moverBorrarPokeball)
        
        self.addChild(pokeBall)
    }
    
    @objc func crearBichosMalos(){
        
        // Acción para mover los bichosMalos
        //TODO RECTO
        let moverBichosMalos = SKAction.move(by: CGVector(dx: -3 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width / CGFloat(puntuacion+10)))
       
        // Acción para borrar los bichos cuando llegan a la plataforma
        let borrarBichosMalos = SKAction.removeFromParent()
        
        // Acción que enlaza las dos acciones (la que pone mueve los bichos y la que los borra)
        let moverBorrarBichosMalos = SKAction.sequence([moverBichosMalos, borrarBichosMalos])
        
        // Numero entre 0 y la mitad de alto de la pantalla (para que los bichos aparezcan a alturas diferentes)
        //calculamos el máximo que podemos
        var calculo = self.frame.maxY - pkmn1.size.height
        cantidadAleatoria = randomCGFloat(min: -calculo , max: calculo)

        print("cantidadAleatoria", cantidadAleatoria)
        
        //ASIGNAMOS TEXTURAS
        texturaPKM11 = SKTexture(imageNamed: "pkmn11.png")
        texturaPKM12 = SKTexture(imageNamed: "pkmn12.png")
        texturaPKM13 = SKTexture(imageNamed: "pkmn13.png")
        texturaPKM14 = SKTexture(imageNamed: "pkmn14.png")
        
        texturaPKM21 = SKTexture(imageNamed: "pkmn21.png")
        texturaPKM22 = SKTexture(imageNamed: "pkmn22.png")
        texturaPKM23 = SKTexture(imageNamed: "pkmn23.png")
        texturaPKM24 = SKTexture(imageNamed: "pkmn24.png")

        // Acción que indica las texturas y el tiempo de cada uno
        let animacionPKM1 = SKAction.animate(with: [texturaPKM11, texturaPKM12, texturaPKM13, texturaPKM14], timePerFrame: 0.2)
        let animacion1Infinita = SKAction.repeatForever(animacionPKM1)
        
        let animacionPKM2 = SKAction.animate(with: [texturaPKM21, texturaPKM22, texturaPKM23, texturaPKM24], timePerFrame: 0.2)
        let animacion2Infinita = SKAction.repeatForever(animacionPKM2)
        
        
        
        pkmn1 = SKSpriteNode(texture: texturaPKM11)
        pkmn1.position = CGPoint(x: self.frame.maxX, y: cantidadAleatoria)
        pkmn1.zPosition = 0
        
        pkmn2 = SKSpriteNode(texture: texturaPKM21)
        pkmn2.position = CGPoint(x: self.frame.maxX, y: cantidadAleatoria)
        pkmn2.zPosition = 0
        
        
        // Le damos cuerpo físico al tubo
        pkmn1.physicsBody = SKPhysicsBody(rectangleOf: texturaPKM11.size())
        pkmn2.physicsBody = SKPhysicsBody(rectangleOf: texturaPKM21.size())

        // Para que no caiga
        pkmn1.physicsBody!.isDynamic = true
        pkmn2.physicsBody!.isDynamic = true
        
        // Categoría de collision
        pkmn1.physicsBody!.categoryBitMask = tipoNodo.bicho.rawValue
        pkmn2.physicsBody!.categoryBitMask = tipoNodo.bicho.rawValue

        // con quien colisiona
        pkmn1.physicsBody!.collisionBitMask = tipoNodo.plataforma.rawValue
        pkmn2.physicsBody!.collisionBitMask = tipoNodo.plataforma.rawValue

        // Hace contacto con
        pkmn1.physicsBody!.contactTestBitMask = tipoNodo.plataforma.rawValue
        pkmn2.physicsBody!.contactTestBitMask = tipoNodo.plataforma.rawValue

        //Calculamos el intervalo en el que apareceran los bichos
        timeInterval = 4.5-Double((puntuacion+20)/10)
        interval = 0.0
        if(timeInterval <= 0.5) {
            interval = 0.2
        }
        else {
            interval = timeInterval
        }
        
        
        pokemonAleatorio = Double(cantidadAleatoria*3/2)
        print("PokemonAleatorio", pokemonAleatorio)
        if(pokemonAleatorio > 100){
            pkmn1.run(animacion1Infinita)
            pkmn1.run(moverBorrarBichosMalos)
            self.addChild(pkmn1)
        }else{
            pkmn2.run(animacion2Infinita)
            pkmn2.run(moverBorrarBichosMalos)
            self.addChild(pkmn2)
        }
        
       
    }
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    // Función para tratar las colisiones o contactos de nuestros nodos
    func didBegin(_ contact: SKPhysicsContact) {
        // en contact tenemos bodyA y bodyB que son los cuerpos que hicieron contacto
        let bichoMalo = contact.bodyA
        let plataforma = contact.bodyB
        let pokebala = contact.bodyB
        
        // Miramos si el bicho malo ha tocado la plataforma o al reves
        if (bichoMalo.categoryBitMask == tipoNodo.bicho.rawValue && plataforma.categoryBitMask == tipoNodo.plataforma.rawValue) || (bichoMalo.categoryBitMask == tipoNodo.plataforma.rawValue && plataforma.categoryBitMask == tipoNodo.bicho.rawValue) {
            contadorVidas = contadorVidas - 1
            arrayVidas[contadorVidas].removeFromParent()
            print("contadorVidas", contadorVidas)
            if(contadorVidas == 0){
                gameOver = true
                puntuacion = 0
                // Frenamos todo
                self.speed = 0
                // Paramos el timer
                timer.invalidate()
                labelPts.text = "Game Over"
            }
        }
        
        //Miramos si la pokeBala ha tocado un bichoMalo (aka pokemonnnn)
        if(bichoMalo.categoryBitMask == tipoNodo.bicho.rawValue && pokebala.categoryBitMask == tipoNodo.bala.rawValue) || (pokebala.categoryBitMask == tipoNodo.bicho.rawValue && bichoMalo.categoryBitMask == tipoNodo.bala.rawValue){
            bichoMalo.node?.removeFromParent()
            pokebala.node?.removeFromParent()
            puntuacion += 1
            labelPts.text = String(puntuacion)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            var vector = CGVector(dx: t.location(in: self).x, dy: t.location(in: self).y)
            print(totalPokeballsEscena)
            if(totalPokeballsEscena >= 3){
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.totalPokeballsEscena = 0
                }
            }else{
                totalPokeballsEscena += 1
                crearBala(vector: vector)
            }
            
        }
    }
    
    //funcion que genera numero aleatorio en rango
    func randomCGFloat(min: CGFloat, max:CGFloat) -> CGFloat {
        return min + CGFloat(arc4random_uniform(UInt32(max - min + 1)))
    }


}
