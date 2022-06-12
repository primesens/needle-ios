//
//  AgoraAudioViewController+TableView.swift
//  Nedl
//
//  Created by Gautham Sritharan on 2022-04-22.
//

import UIKit

extension AgoraAudioViewController: UITableViewDelegate, UITableViewDataSource {

    func createSpeakerTable() {
        let newTable = UITableView()
        self.view.addSubview(newTable)
        newTable.frame = self.view.bounds
        newTable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newTable.delegate = self
        newTable.dataSource = self
        newTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.speakerTable = newTable
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? self.activeSpeakers.count : self.activeAudience.count
    }

    func numberOfSections(in tableView: UITableView) -> Int { 2 }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        ["Speakers", "Audience"][section]
    }

    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let cellUserID = Array(
            indexPath.section == 0 ? self.activeSpeakers : self.activeAudience
        )[indexPath.row]

        cell.textLabel?.text = self.usernameLookups[cellUserID]

        if indexPath.section == 0, cellUserID == self.activeSpeaker {
            cell.backgroundColor = .systemGreen
        } else {
            cell.backgroundColor = .systemBackground
        }
        return cell
    }
}
