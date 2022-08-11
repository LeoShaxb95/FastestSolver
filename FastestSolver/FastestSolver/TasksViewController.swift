//
//  TasksViewController.swift
//  FastestSolver
//
//  Created by Leo Shakhb on 11.08.22.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var taskPlaceLabel: UILabel!
    @IBOutlet weak var variantAButton: UIButton!
    @IBOutlet weak var variantBButton: UIButton!
    @IBOutlet weak var variantCButton: UIButton!
    @IBOutlet weak var variantDButton: UIButton!
    @IBOutlet weak var myPointsLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resultsButton: UIButton!

    let taskCounts = [5, 10, 15]
    var taskCount = 0
    var tasks = 1
    var optionType: Int?
    var difficulty: Game.Difficulty?
    var configuration: Game.Configuration?
    var answers: Game.Answers?
    var choosenAnswerIndex = 0
    var rightAnswerIndex = 0
    var rightAnswer: Int!
    var shuffledArrayOfAnswers: [Int] = []
    var buttonsEnabled = true
    var nextButtonEnabled = false
    var resultsButtonEnabled = false
    var countOfRightAnswers = 0
    var countOfWrongAnswers = 0
    var firstRandom = 0
    var secondRandom = 0
    var myPoints = 0
    var addPoints = 0
    var minusPoints = 0
    var timer = Timer()
    var time = 14 {
        didSet {
            timeLabel.text = "\(time)"
        }
    }

    @objc private func timerik() {
        time -= 1

        if time == 0 {
            resultsButtonEnabled = true
            timer.invalidate()
            buttonsEnabled = false
            resultsButtonEnable()
        }
    }

    func resultsButtonEnable() {
        resultsButton.isEnabled = (resultsButtonEnabled == true)
    }

    func nextButtonEnable() {
        nextButton.isEnabled = (nextButtonEnabled == true)
    }

    func timerGetStarted() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerik), userInfo: nil, repeats: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    private func configureView() {
        nextButtonEnable()
        resultsButtonEnable()
        checkDifficulty()
        checkConfiguration()
        getNewTask()
        timerGetStarted()
        timeLabel.layer.cornerRadius = timeLabel.frame.width / 2
        timeLabel.layer.masksToBounds = true
        timeLabel.text = String(time)
        myPointsLabel.layer.cornerRadius = timeLabel.frame.width / 2
        myPointsLabel.layer.masksToBounds = true
    }

    func easyRandoms() {
        firstRandom = Int.random(in: -9...9)
        secondRandom = Int.random(in: -9...9)
        addPoints = 1
        minusPoints = 2
    }

    func mediumRandoms() {
        firstRandom = Int.random(in: -20...20)
        secondRandom = Int.random(in: -20...20)
        addPoints = 2
        minusPoints = 2
    }

    func hardRandoms() {
        firstRandom = Int.random(in: -50...50)
        secondRandom = Int.random(in: -50...50)
        addPoints = 3
        minusPoints = 2
    }

    func choosenTypeRandoms() {
        guard let difficulty = difficulty else { return }
        switch difficulty.rawValue {
            case 0:
                easyRandoms()
            case 1:
                mediumRandoms()
            case 2:
                hardRandoms()
            default:
                firstRandom = 0
                secondRandom = 0
        }
    }

    func checkDifficulty() {
        guard let difficulty = difficulty else { return }
        taskCount = taskCounts[difficulty.rawValue]
        choosenTypeRandoms()
    }

    func checkConfiguration() {
        guard let configuration = configuration else { return }
        optionType = configuration.rawValue
    }

    func chechChoosenAnswerIndex() {
        guard let answers = answers else { return }
        choosenAnswerIndex = answers.rawValue
    }

    func getNewTask() {

        choosenTypeRandoms()
        timerik()

        var wrongAnswer1 = 0
        var wrongAnswer2 = 0
        var wrongAnswer3 = 0
        var option: Int

        switch optionType {
            case 0:
                option = Int.random(in: 0...1)
            case 1:
                option = Int.random(in: 2...3)
            case 2:
                option = Int.random(in: 0...3)
            default:
                option = Int.random(in: 0...3)
        }

        switch option {
            case 0:
                taskPlaceLabel.text = "\(tasks). Sum of \(firstRandom) & \(secondRandom) ?"
                rightAnswer = firstRandom + secondRandom
                wrongAnswer1 = rightAnswer + Int.random(in: (-10)...(-1))
                wrongAnswer2 = (firstRandom) * (-1) + secondRandom
                wrongAnswer3 = rightAnswer + Int.random(in: 1...10)
            case 1:
                taskPlaceLabel.text = "\(tasks). Difference of \(firstRandom) & \(secondRandom) ?"
                rightAnswer = firstRandom - secondRandom
                wrongAnswer1 = rightAnswer + Int.random(in: (-10)...(-1))
                wrongAnswer2 = firstRandom - secondRandom * (-1)
                wrongAnswer3 = rightAnswer + Int.random(in: 2...10)
            case 2:
                taskPlaceLabel.text = "\(tasks). Prodact of \(firstRandom) & \(secondRandom) ?"
                rightAnswer = firstRandom * secondRandom
                wrongAnswer1 = (firstRandom + Int.random(in: 1...2)) * secondRandom
                wrongAnswer2 = firstRandom * (secondRandom - Int.random(in: 1...2))
                wrongAnswer3 = rightAnswer * (-1)

            case 3:
                firstRandom = secondRandom * Int.random(in: 1...9)
                if secondRandom == 0 {
                    secondRandom = secondRandom + Int.random(in: 1...9)
                    firstRandom = secondRandom * Int.random(in: 1...9)
                }
                taskPlaceLabel.text = "\(tasks). Quotient of \(firstRandom) & \(secondRandom) ?"
                rightAnswer = firstRandom / secondRandom
                wrongAnswer1 = rightAnswer + Int.random(in: (-5)...(-3))
                wrongAnswer2 = rightAnswer * (-1) + Int.random(in: 0...1)
                wrongAnswer3 = rightAnswer + Int.random(in: 1...5)

            default: rightAnswer = 0
        }

        var arrayOfAnswers: [Int] = []
        arrayOfAnswers.append(rightAnswer)
        arrayOfAnswers.append(wrongAnswer1)
        arrayOfAnswers.append(wrongAnswer2)
        arrayOfAnswers.append(wrongAnswer3)

        shuffledArrayOfAnswers = arrayOfAnswers.shuffled()

        rightAnswerIndex = shuffledArrayOfAnswers.firstIndex(where: { $0 == rightAnswer })!

        variantAButton.setTitle("\(shuffledArrayOfAnswers[0])", for: .normal)
        variantBButton.setTitle("\(shuffledArrayOfAnswers[1])", for: .normal)
        variantCButton.setTitle("\(shuffledArrayOfAnswers[2])", for: .normal)
        variantDButton.setTitle("\(shuffledArrayOfAnswers[3])", for: .normal)

        tasks = tasks + 1

    }

    func unColoringButtons() {
        variantAButton.backgroundColor = .systemGray6
        variantBButton.backgroundColor = .systemGray6
        variantCButton.backgroundColor = .systemGray6
        variantDButton.backgroundColor = .systemGray6
    }

    @IBAction func didTapNextButton(_ sender: UIButton) {
         if taskCount > 1 && nextButtonEnabled {
            buttonsEnabled = true
            unColoringButtons()
            getNewTask()
            taskCount = taskCount - 1
            nextButtonEnabled = false
            nextButtonEnable()
        }
    }

    @IBAction func didTapVariantButton(_ sender: UIButton) {
        if buttonsEnabled {
            nextButtonEnabled = true
            answers = Game.Answers(rawValue: sender.tag)
            chechChoosenAnswerIndex()
            unColoringButtons()
            checkAnswer()
            buttonsEnabled = false
            nextButtonEnable()
        }
    }

    func checkAnswer() {
        let arrayOfButtons = [variantAButton, variantBButton, variantCButton, variantDButton]
        if choosenAnswerIndex == rightAnswerIndex {
            countOfRightAnswers += 1
            myPoints = myPoints + addPoints
            arrayOfButtons[choosenAnswerIndex]?.backgroundColor = .green
        } else {
            countOfWrongAnswers += 1
            myPoints = myPoints - minusPoints
            arrayOfButtons[choosenAnswerIndex]?.backgroundColor = .red
            arrayOfButtons[rightAnswerIndex]?.backgroundColor = .green
        }
        myPointsLabel.text = String(myPoints)
    }

}
