//
//  ViewController.swift
//  CharactersApp
//
//  Created by Sarah Gamal on 28/11/2024.
//

import UIKit
import SwiftUI

class CharactersViewController: UIViewController, CharacterViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
   
    private var viewModel = CharacterViewModel()
    private var activityIndicator: UIActivityIndicatorView!
    private var refreshControl = UIRefreshControl()
    private var overlayView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupActivityIndicator()
        setupOverlayView()
        bindViewModel()
        fetchData()
    }
    
    private func setupTableView() {
        setupTableViewDelegateAndDataSource()
        loadTableViewCell()
        handleRefreshControl()
        loadFilterHeaderView()
    }
    
    private func setupTableViewDelegateAndDataSource() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func loadTableViewCell() {
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
    }
    
    private func handleRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func loadFilterHeaderView()  {
        let filterView = FilterView()
        filterView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: tableView.frame.width,
                                  height: 50)
        
        filterView.delegate = self
        tableView.tableHeaderView = filterView
    }
    
    private func setupOverlayView() {
        overlayView = UIView(frame: self.view.bounds)
        overlayView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = overlayView.center
        loadingIndicator.startAnimating()
        
        overlayView.addSubview(loadingIndicator)
        overlayView.isHidden = true
        self.view.addSubview(overlayView)
    }

    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
    }
    
    private func bindViewModel() {
        viewModel.delegate = self
    }
    
    // MARK: - CharacterViewModelDelegate methods
    
    func didChangeLoadingState(isLoading: Bool) {
        DispatchQueue.main.async {
            self.overlayView.isHidden = !isLoading
        }
    }
    
    func didUpdateCharacters() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didEncounterError(message: String) {
        DispatchQueue.main.async {
            self.showErrorAlert(message: message)
        }
    }
    
    private func fetchData() {
        Task {
            await viewModel.fetchCharacters()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func refreshData() {
        viewModel.resetPagination()
        fetchData()
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return viewModel.numberOfCharacters
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        let character = viewModel.characterAt(index: indexPath.row)
        cell.configure(with: character)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfCharacters - 1 && viewModel.hasNextPage == true {
            fetchData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = viewModel.characterAt(index: indexPath.row)
            navigateToCharacterDetails(selectedCharacter)
    }
}

extension CharactersViewController: FilterHeaderViewDelegate {
    func didTapFilterButton(withStatus status: String) {
        viewModel.filterCharacters(by: status)
    }
}

extension CharactersViewController {
    func navigateToCharacterDetails(_ character: Character) {
        let detailsView = CharacterDetailsView(character: character)
        let hostingController = UIHostingController(rootView: detailsView)
        hostingController.modalPresentationStyle = .fullScreen
        self.present(hostingController, animated: true)
    }
}
