//
//  ViewController.swift
//

import UIKit

class ViewController: UIViewController {
    // Constants
    let diceFaces = [ #imageLiteral(resourceName: "DiceOne"),#imageLiteral(resourceName: "DiceTwo"),#imageLiteral(resourceName: "DiceThree"),#imageLiteral(resourceName: "DiceFour"),#imageLiteral(resourceName: "DiceFive"),#imageLiteral(resourceName: "DiceSix") ]
    
    // Outlets
    // Buttons
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    // Views
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var replayButtonView: UIView!
    // Image views
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    @IBOutlet weak var diceImageView3: UIImageView!
    @IBOutlet weak var opponentDiceIV1: UIImageView!
    @IBOutlet weak var opponentDiceIV2: UIImageView!
    @IBOutlet weak var opponentDiceIV3: UIImageView!
    // Label
    @IBOutlet weak var remainingTryLabel: UILabel!
    // Switches
    @IBOutlet weak var switchDice1: UISwitch!
    @IBOutlet weak var switchDice2: UISwitch!
    @IBOutlet weak var switchDice3: UISwitch!
    
    // Game variables
    var diceValues: [Int] = [1, 1, 1]
    var opponentDiceValues: [Int] = [1, 1, 1]
    // Player remaining tries before turn end
    var remainingTries = 3
    // TRUE if dice must be rerolled
    var dicesMustRoll: [Bool] = [true, true, true]

    override func viewDidLoad() {
        // TBD
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        for index in 0...2 {
            if dicesMustRoll[index] {
                diceValues[index] = Int.random(in: 1...6)   // update dice value
            }
        }
        diceImageView1.image = diceFaces[diceValues[0] - 1]     // change dice image view
        diceImageView2.image = diceFaces[diceValues[1] - 1]
        diceImageView3.image = diceFaces[diceValues[2] - 1]
        
        remainingTries -= 1 // remaining tries decreased by 1
        remainingTryLabel.text = "Remaining tries: " + String(remainingTries)
        
        if remainingTries == 0 {
            rollOpponentDices()
        }
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        remainingTries = 0
        remainingTryLabel.text = "Remaining tries: " + String(remainingTries)
        rollOpponentDices()
    }
    
    @IBAction func replayButtonPressed(_ sender: Any) {
        resetVariables()
    }
    
    func rollOpponentDices() {
        
        for index in 0...2 {
            opponentDiceValues[index] = Int.random(in: 1...6)
        }
        opponentDiceIV1.image = diceFaces[opponentDiceValues[0] - 1]
        opponentDiceIV2.image = diceFaces[opponentDiceValues[1] - 1]
        opponentDiceIV3.image = diceFaces[opponentDiceValues[2] - 1]
        
        var opponentScore = 0; var playerScore = 0
        for index in 0...2 {
            opponentScore += opponentDiceValues[index]
            playerScore += diceValues[index]
        }
        
        if opponentScore > playerScore {
            remainingTryLabel.text = "You loose :-( "
        } else {
            remainingTryLabel.text = "You win !!! "
        }
        remainingTryLabel.text! += "(you: "
        remainingTryLabel.text! += String(playerScore)
        remainingTryLabel.text! += ", cpu: "
        remainingTryLabel.text! += String(opponentScore)
        remainingTryLabel.text! += ")"
        
        // Change button and image view apperances
        rollButton.isHidden = true; acceptButton.isHidden = true; logoView.isHidden = true; replayButtonView.isHidden = false;
    }
    
    func resetVariables() {
        // Change button and image view apperances
        rollButton.isHidden = false
        acceptButton.isHidden = false
        replayButtonView.isHidden = true
        logoView.isHidden = false;
        
        // Reset variables
        for index in 0...2{
            diceValues[index] = 1
            opponentDiceValues[index] = 1
            dicesMustRoll[index] = true
        }
        remainingTries = 3
        
        // Reset outlets
        diceImageView1.image = diceFaces[diceValues[0] - 1]
        diceImageView2.image = diceFaces[diceValues[1] - 1]
        diceImageView3.image = diceFaces[diceValues[2] - 1]
        opponentDiceIV1.image = diceFaces[opponentDiceValues[0] - 1]
        opponentDiceIV2.image = diceFaces[opponentDiceValues[1] - 1]
        opponentDiceIV3.image = diceFaces[opponentDiceValues[2] - 1]
        switchDice1.isOn = true
        switchDice2.isOn = true
        switchDice3.isOn = true
        remainingTryLabel.text = "Remaining tries: " + String(remainingTries)
    }
    
    @IBAction func dice1SwitchActivated(_ sender: Any) {
        dicesMustRoll[0] = !dicesMustRoll[0]    }
    
    @IBAction func dice2SwitchActivated(_ sender: Any) {
        dicesMustRoll[1] = !dicesMustRoll[1]    }
    
    @IBAction func dice3SwitchActivated(_ sender: Any) {
        dicesMustRoll[2] = !dicesMustRoll[2]    }
}

