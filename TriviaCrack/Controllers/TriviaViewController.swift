//
//  ViewController.swift
//  TriviaCrack
//
//  Created by Manny Yusuf on 1/14/19.
//  Copyright © 2019 Manny Yusuf. All rights reserved.
//

import UIKit

class TriviaViewController: UIViewController {
    
    @IBOutlet weak var triviaSearchBar: UISearchBar!
    @IBOutlet weak var triviaTableView: UITableView!
    
    public var triviaQuestions = [TriviaQuestion]() {
        didSet {
            DispatchQueue.main.async {
                self.triviaTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        triviaTableView.delegate = self
        triviaTableView.dataSource = self
        triviaSearchBar.delegate = self
        TriviaAPIClient.retrieveTriviaQuestions { (triviaQuestions, error) in
            if let error = error {
                print("There's an \(error) error retrieving your data")
            } else if let triviaQuestions = triviaQuestions {
                self.triviaQuestions = triviaQuestions
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = triviaTableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as? TriviaDetailViewController else {
                fatalError("indexPath, detailVC nil")
        }
        let trivia = triviaQuestions[indexPath.row]
        detailViewController.triviaQuestion = trivia
    }
}

extension TriviaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return triviaQuestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TriviaCell", for: indexPath) as? TriviaCell else {
            fatalError("TriviaCell error")
        }
        let triviaCrack = triviaQuestions[indexPath.row]
        cell.catagroryLabel.text = triviaCrack.category
        cell.questionTypeLabel.text = triviaCrack.type
        cell.difficultyLabel.text = triviaCrack.difficulty
        return cell
    }
}
extension TriviaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension TriviaViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text?.lowercased() else { return }
        if searchText == "" || searchText == " " {
            TriviaAPIClient.retrieveTriviaQuestions { (triviaQuestions, error) in
                if let error = error {
                    print("There's an \(error) error retrieving your data")
                } else if let triviaQuestions = triviaQuestions {
                    self.triviaQuestions = triviaQuestions
                }
            }
        } else {
             triviaQuestions = triviaQuestions.filter { searchText == $0.category.lowercased() }
        }
    }
}
