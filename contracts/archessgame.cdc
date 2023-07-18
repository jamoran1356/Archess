import ArChess_ from "./archess_v01.cdc"

access(all) contract ArChessGame {

  // Variables públicas
  pub var players: {String: [UInt64]}
  pub var player1: Address
  pub var player2: Address
  pub var player1Color: String
  pub var player2Color: String
  pub var player1Level: UInt64
  pub var player2Level: UInt64
  pub var boardId: UInt64
  pub var date: String

  // Función para realizar los emparejamientos e inicializar la información de los jugadores
  init(_player1: Address, _player2: Address, _player1Color: String, _player2Color: String, _player1Level: UInt64, _player2Level: UInt64, _boardId: UInt64, _date: String){
    self.players = {}
    self.player1 = _player1
    self.player2 = _player2
    self.player1Color = _player1Color
    self.player2Color = _player2Color
    self.player1Level = _player1Level
    self.player2Level = _player2Level
    self.boardId = _boardId
    self.date = _date
  }

  // Función para verificar si ambos jugadores tienen al rey y la reina
  pub fun verifyKingAndQueen(player1Name: String, player2Name: String): Bool {
    let player1Pieces = self.players[player1Name]
    let player2Pieces = self.players[player2Name]

    let player1HasKingAndQueen = checkKingAndQueen(player1Pieces)
    let player2HasKingAndQueen = checkKingAndQueen(player2Pieces)

    return player1HasKingAndQueen && player2HasKingAndQueen
  }

  // Función auxiliar para verificar si un jugador tiene al rey y la reina
  fun checkKingAndQueen(pieces: [UInt64]): Bool {
    var hasKing = false
    var hasQueen = false

    for pieceID in pieces {
      let piece = getPieceByID(pieceID)
      if piece.color == "black" && piece.type == "king" {
        hasKing = true
      }
      if piece.color == "black" && piece.type == "queen" {
        hasQueen = true
      }
    }

    return hasKing && hasQueen
  }

  // Función auxiliar para obtener una pieza por su identificador
  pub fun getPieceByID(pieceID: UInt64): Piece {
    let arChessContract = getAccount(ArChess_.address).getCapability<&{ArChess_.ArChess_}>() //error puedes modificar para no usar getCapability?
      .borrow()
      ??panic("No se pudo obtener el contrato de ArChess_")

    return arChessContract.getPieceByID(pieceID)
  }

  // Function to randomly select a color for each player
  access(account) fun gameCounter(player1: Address, player2: Address, p1_level: UInt64, p2_level: UInt64, boardid: UInt64) {
        
      fun selectColor(): String {
          let colors: [String] = ["Red", "Blue", "Green", "Yellow"]
          return colors[Math.random(colors.length)]
      }
  
      // Randomly select colors for both players
      let p1_color: String = selectColor()
      let p2_color: String = selectColor()
  
      // Determine which player makes the first move
      let firstPlayer: Address = Math.random() >= 0.5 ? player1 : player2
        
  }

  
  
  access(account) fun fightSquare(player1: Address, player2: Address, player1_piece: String, player2_Piece: String, square: string, arcadegameid: UInt64, time: uint) {
    // Verificar si la pieza del jugador 1 está ocupando el cuadro
    if(player1_piece == square) {
      // Elegir un número aleatorio entre 1 y 30 para el juego arcade
      let randomArcadeGame = random(1, 30)
      // Lógica del juego arcade...
      // ...
      // Si el jugador 1 gana el juego arcade
      if(player1Wins) {
        // Actualizar la experiencia de la pieza del jugador 1
        let newExperience = time + 0.0000005
        player1_piece.experience = newExperience
  
        // La pieza del jugador 1 se queda con el cuadro
        square.owner = player1
  
      } else if (player2Wins) {
        // Actualizar la experiencia de la pieza del jugador 2
        let newExperience = time + 0.0000005
        player2_piece.experience += newExperience
  
        // La pieza del jugador 2 se queda con el cuadro
        square.owner = player2
      }
    }
  }
  
  
}

