//
//  ViewController.swift
//  FastestSolver
//
//  Created by Leo Shakhb on 11.08.22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Subviews

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var configurationsLabel: UILabel!
    @IBOutlet weak var plusMinusButton: UIButton!
    @IBOutlet weak var multiplyDevineButton: UIButton!
    @IBOutlet weak var allOptionsButton: UIButton!
    @IBOutlet weak var goToTasksButton: UIButton!

    // MARK: - Model

    var game = Game()
    var difficulty: Game.Difficulty?
    var configuration: Game.Configuration?


    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        goToTasksButton.isEnabled = false
    }

    private func didSetAllConfig() {
        goToTasksButton.isEnabled = nameTextField.text?.isEmpty == false &&
        difficulty != nil  &&
        configuration != nil
    }

    // MARK: - Callbacks

    @IBAction func didEditNameTextField(_ sender: Any) {
        didSetAllConfig()
    }

    @IBAction func didTapDifficultyButton(_ sender: UIButton) {
        difficulty = Game.Difficulty(rawValue: sender.tag)
        difficultyLabel.text = sender.titleLabel?.text
        didSetAllConfig()
    }

    @IBAction func didTapConfiguration(_ sender: UIButton) {
        configuration = Game.Configuration(rawValue: sender.tag)
        configurationsLabel.text = sender.titleLabel?.text
        didSetAllConfig()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Task" {
            guard let taskViewController = segue.destination as? TasksViewController
            else {
                fatalError()
            }

            taskViewController.difficulty = difficulty
            taskViewController.configuration = configuration
        }
    }

}

