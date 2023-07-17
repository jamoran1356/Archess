import ArChess from "./archess.cdc"

access(all) contract ArChessGame {

  // Variables públicas
  pub var players: {String: [UInt64]}
  
  // Función para realizar los emparejamientos
  access(account) fun matchPlayers(player1: String, player2: String): String {
    
    // Verificar que ambos jugadores tienen al menos al rey y la reina
    let hasKingAndQueenPlayer1 = self.hasKingAndQueen(player1) //missing argument label: `player`
    let hasKingAndQueenPlayer2 = self.hasKingAndQueen(player2) //missing argument label: `player`
    
    if (!hasKingAndQueenPlayer1 || !hasKingAndQueenPlayer2){
      return "Ambos jugadores deben tener al menos el rey y la reina en su colección."
    }
    
    // Realizar el emparejamiento
    self.players[player1] = []
    self.players[player2] = []
    
    return "Emparejamiento exitoso. El juego puede comenzar."
  }

  // Función para verificar si un jugador tiene al menos el rey y la reina en su colección
  access(account) fun hasKingAndQueen(player: String): Bool {
    let playerCollection= ArChess.getAccountCollection(player)
    
    var hasKing = false
    var hasQueen = false
    
    for pieceID in playerCollection {
      let piece = ArChess.getPieceByID(pieceID)
      
      if (piece.faction == "King") {
        hasKing = true
      } else if (piece.faction == "Queen") {
        hasQueen = true
      }
      
      if (hasKing && hasQueen) {
        return true
      }
    }
    
    return false
  }

  init(){
    self.players = {}
  }
  
}
