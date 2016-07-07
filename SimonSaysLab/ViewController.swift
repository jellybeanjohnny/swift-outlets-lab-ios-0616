//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var displayColorView: UIView!
	@IBOutlet weak var startGameButton: UIButton!
	@IBOutlet weak var winLabel: UILabel!
	
	@IBOutlet weak var redButton: UIButton!
	@IBOutlet weak var greenButton: UIButton!
	@IBOutlet weak var yellowButton: UIButton!
	@IBOutlet weak var blueButton: UIButton!
	
	
	
	var simonSaysGame = SimonSays()
	var buttonsClicked = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.newGame()

	}
	
	func newGame() {
		
		winLabel.hidden = true
		buttonsClicked = 0
	}
	
	@IBAction func redButtonTapped(sender: AnyObject) {
		
		simonSaysGame.guessRed()
		checkForWinner()
	}
	
	@IBAction func greenButtonTapped(sender: AnyObject) {
		simonSaysGame.guessGreen()
		checkForWinner()
	}
	
	@IBAction func yellowButtonTapped(sender: AnyObject) {
		simonSaysGame.guessYellow()
		checkForWinner()
	}
	
	@IBAction func blueButtonTapped(sender: AnyObject) {
		simonSaysGame.guessBlue()
		checkForWinner()
	}
	
	func isMatchingPattern() -> Bool {
		
		print("Chosen Colors: \(simonSaysGame.chosenColors)")
		print("Pattern: \(simonSaysGame.patternToMatch)")
		
		if simonSaysGame.chosenColors[buttonsClicked] != simonSaysGame.patternToMatch[buttonsClicked] {
			return false
		}
		return true
	}

	func checkForWinner() {
		if simonSaysGame.wonGame() {
			print("You won")
			winLabel.hidden = false
			winLabel.text = "You Win"
		}
		else if !isMatchingPattern(){
			winLabel.hidden = false
			winLabel.text = "You Lose"
			print("You lose")
		}
		buttonsClicked += 1
	}
	
	
	
}


// MARK: - SimonSays Game Methods
extension ViewController {
	
	@IBAction func startGameTapped(sender: UIButton) {
		UIView.transitionWithView(startGameButton, duration: 0.9, options: .TransitionFlipFromBottom , animations: {
			self.startGameButton.hidden = true
			}, completion: nil)
		
		displayTheColors()
	}
	
	private func displayTheColors() {
		self.view.userInteractionEnabled = false
		UIView.transitionWithView(displayColorView, duration: 1.5, options: .TransitionCurlUp, animations: {
			self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
			self.displayColorView.alpha = 0.0
			self.displayColorView.alpha = 1.0
			}, completion: { _ in
				if !self.simonSaysGame.sequenceFinished() {
					self.displayTheColors()
				} else {
					self.view.userInteractionEnabled = true
					print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
				}
		})
	}
}
