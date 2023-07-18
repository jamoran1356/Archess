access(all) contract ArChess_ {

  pub var totalSupply: UInt64
  pub var tokenURI: String
  pub var packPrice: UFix64

  access(account) fun addtokenURI(_tokenURI: String): String{
    self.tokenURI = _tokenURI
    return self.tokenURI
  } 

  //Estructura para representar a un jugador
  pub resource Player {
      pub var wallet: Address
      pub var experience: UInt64
      pub var level: UInt32
      pub var pieces: @[Piece] 
      pub var sets: @[Set] 
      pub var ownedNFTs: @{UInt64: Piece}
  
      access(all) fun getOwnedPieces(): &[Piece] {
          return &self.pieces as &[Piece]
      }
  
      init(_wallet: Address){
          self.wallet = _wallet
          self.experience = 0
          self.level = 0
          self.pieces <- []
          self.sets <- []
          self.ownedNFTs <- {}
      }
  
      destroy() {
          destroy self.pieces
          destroy self.sets
          destroy self.ownedNFTs
      }
  }
  

  // Estructura para representar una pieza de ajedrez
  pub resource Piece {
    pub let id: UInt64 
    pub var staking: Bool
    pub var faction: String
    pub var color: String
    pub var experience: Int
    pub var position: String
    pub var attack: Int
    pub var defense: Int
    pub var ownedNFTs: @{UInt64: Piece}
    pub let price: Int
    pub var minSellingPrice: Int

    init(){
      self.id = ArChess_.totalSupply
      ArChess_.totalSupply = ArChess_.totalSupply + 1
      self.staking = false
      self.faction = ""
      self.color = ""
      self.experience = 0
      self.position = ""
      self.attack = 0
      self.defense = 0
      self.ownedNFTs <- {}
      self.price = 0
      self.minSellingPrice = 0
    }

     pub fun setMinSellingPrice() {
      //self.minSellingPrice = self.calculateMinSellingPrice()
    }

     
    
    pub fun deposit(token: @Piece){
      self.ownedNFTs[token.id] <-! token
    }

    pub fun withdraw(id: UInt64): @Piece?{
      let token <- self.ownedNFTs.remove(key: id)
      return <-token
    }

    pub fun getID(): [UInt64]{
      return self.ownedNFTs.keys
    }


    destroy() {
      destroy self.ownedNFTs
    }

  }
   
  pub resource Set {
    pub let id: UInt64
    pub let pieces: @[Piece]

    init() {
      self.id = ArChess_.totalSupply
      ArChess_.totalSupply = ArChess_.totalSupply + 1
      self.pieces <- self.createPieces()
    }

  access(account) fun createPieces(): @[Piece] {
    var pieces: @[Piece] <- []
    var i: UInt64 = 0
    while i < 16 {
      pieces.append(<- create Piece())
      i = i + 1
    }
    return <- pieces
  }

    destroy() {
      // Destruir todos los recursos Piece en el arreglo pieces
        destroy self.pieces
    }

  }

  pub resource Pack {
    pub let id: UInt64
    pub let sets: @[Set]

    init(){
      self.id = ArChess_.totalSupply
      ArChess_.totalSupply = ArChess_.totalSupply + 1
      self.sets <- self.createSets()
    }

  access(account) fun createSets(): @[Set] {
    var sets: @[Set] <- []
    var i: UInt = 0
    while i < 5000 {
      sets.append(<- create Set())
      i = i + 1
    }
    return <- sets
  }

    destroy() {
      // Destruir todos los recursos Set en el arreglo sets
        destroy self.sets
    }
  }

  pub fun createPack(): @Pack {
    return <- create Pack()
  }

  init() {
    self.totalSupply = 0
    self.tokenURI = "https://ArChess_.club/assets/NFT/collection/"
    self.packPrice = 0.00
  }
  

  
}