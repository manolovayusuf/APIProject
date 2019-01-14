//
//  TriviaDetailViewController.swift
//  TriviaCrack
//
//  Created by Manny Yusuf on 1/14/19.
//  Copyright © 2019 Manny Yusuf. All rights reserved.
//

import UIKit

class TriviaDetailViewController: UIViewController {
    
    @IBOutlet weak var catagoryLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answersTableView: UITableView!
    
    var triviaQuestion: TriviaQuestion!
    lazy var answers = triviaQuestion.incorrect_answers + [triviaQuestion.correct_answer]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answersTableView.dataSource = self
        answersTableView.delegate = self
        catagoryLabel.text = triviaQuestion.category
        questionLabel.text = triviaQuestion.question
        answers.shuffle()
    }
}
extension TriviaDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = answersTableView.dequeueReusableCell(withIdentifier: "AnswersCell", for: indexPath)
        let answer = answers[indexPath.row]
        cell.textLabel?.text = answer
        return cell
    }
}
extension TriviaDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.textLabel?.text == triviaQuestion.correct_answer {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .green
        } else {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .red
        }
    }
}


