//
//  TweeterViewController.swift
//  tweeterApp
//
//  Created by Yuliya Martsenko on 12.02.2022.
//

import UIKit

class TweeterViewController: UIViewController {
    
    var controller: APIController?
    
    var tweets: [TweetModel]?
    
    lazy var search: UITextField = {
        let view  = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 5.0
        view.layer.borderColor = CGColor.init(red: 0, green: 0, blue:256, alpha: 100)
        view.layer.cornerRadius = 8.0
        view.backgroundColor = .white
        view.placeholder = "Enter your request:"
        view.textAlignment = .center
        view.becomeFirstResponder()
        view.delegate = self
        let action = UIAction { [weak self] _ in
            guard let self = self,
                  let text = self.search.text else {
                return
            }
            self.controller?.tweetReciever(by: text)
        }
        view.addAction(action, for: .editingDidEnd)
        return view
    }()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TweetTableViewCell.self, forCellReuseIdentifier: "Tweet")
        return table
    }()
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        title = "Tweets"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        navigationItem.rightBarButtonItem?.tintColor = UIColor.darkGray
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            search.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            search.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            search.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: search.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .white
        view.addSubview(search)
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        controller = APIController(token: ACCESS_KEY, delegate: self)
        controller?.tweetReciever(by: "ecole 42")
        setupNavigationBar()
        setupView()
        setupConstraints()
    }
    
    func showAllert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension TweeterViewController: APITwitterDelegate {
    
    func recievedTweetManager(tweets: [TweetModel]) {
        DispatchQueue.main.sync {
            self.tweets = tweets
            tableView.reloadData()
        }
        for tweet in tweets {
            print(tweet)
        }
    }
    
    func recievedErrorManager(error: Error) {
        DispatchQueue.main.sync {
            showAllert(error: error)
        }
        print(error)
    }

}

extension TweeterViewController: UITableViewDelegate {
    
}

extension TweeterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tweets?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet",
                                                       for: indexPath) as? TweetTableViewCell,
              let tweet = tweets?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.setupCell(from: tweet)
        return cell
    }
    
}

extension TweeterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        search.endEditing(true)
        return true
    }

}

