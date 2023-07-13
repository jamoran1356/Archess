import ArChess from "./archess.cdc"

pub contract ArcGame{
    pub fun play(gameId: UInt64, moveString: String): Bool {
        let archesses = getArchesses()
        if!archesses[gameId].isPlaying():
        return false
        // TODO implement the game logic here
    }
    private fun isPlaying(_ archess: ArchEss) -> Bool {
        switch (archess._state){
            case State.waitingForPlayersToJoin:
            break;
            default:
            true
        }
    }
    pub var gamesCount : Int32{
        state.gamesCounter
        }
        init(){
            self.state <- GameState()
            }
            struct GameState{
                gamesCounter:Int32
                players:[Address]
                currentPlayerIndex:UInt8
                boardState:BoardState?
                

}